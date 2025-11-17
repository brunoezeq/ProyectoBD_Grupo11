# Tema: Procedimientos y funciones almacenadas

## **Introducción**

En el ecosistema de SQL Server, tanto los procedimientos almacenados como las funciones son componentes cruciales para estructurar y optimizar el trabajo dentro de una base de datos.

Los procedimientos almacenados están diseñados para ejecutar tareas concretas. Se utilizan comúnmente para operaciones que modifican datos (como inserciones, actualizaciones o eliminaciones) o incluso para alterar la estructura de la base de datos. Su principal ventaja es que permiten encapsular una serie de pasos complejos en un solo bloque de código que puede ser invocado fácilmente. Además, pueden manejar parámetros de entrada y de salida, lo que les da flexibilidad para procesar datos y devolver resultados variables.

Por otro lado, las funciones se centran en realizar cálculos o transformaciones de datos, y están diseñadas para ser utilizadas directamente dentro de las consultas SQL. Esto significa que puedes llamar a una función como parte de un SELECT o en una cláusula WHERE para manipular datos dinámicamente. Sin embargo, su gran diferencia con los procedimientos es que tienen restricciones importantes: solo pueden leer datos y no tienen permitido modificarlos. Este diseño las hace seguras de usar en consultas, asegurando que no provocarán efectos secundarios que alteren la base de datos.

## **¿Qué es un procedimiento almacenado?**

Un procedimiento almacenado es un conjunto de instrucciones T-SQL que se guarda y compila directamente en el servidor de la base de datos. Su propósito es realizar una tarea específica cuando es invocado.

Estos procedimientos son una herramienta fundamental para centralizar la lógica de negocio en la base de datos. Al usarlos, se evita repetir el mismo código en las distintas aplicaciones que se conectan a ella, promoviendo la reutilización y el mantenimiento.

## **Tipos de procedimientos almacenados**

### `1. Definidos por el Usuario`

Estos son los procedimientos que los desarrolladores y administradores crean para ejecutar operaciones personalizadas en la base de datos. Se pueden alojar en cualquier base de datos de usuario o de sistema (exceptuando la base interna "Resource").

Los procedimientos definidos por el usuario se pueden escribir en Transact-SQL (el lenguaje estándar de SQL Server) o pueden ser desarrollados usando .NET CLR (Common Language Runtime). Esta última opción permite implementar lógica de administración y manipulación de datos mucho más compleja y personalizada.

```SQL
CREATE PROCEDURE RegistrarReproduccion
    @id_perfil INT,
    @id_contenido INT = NULL,
    @id_episodio INT = NULL,
    @progreso_minutos INT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- aqui validamos que el perfil existe y se encuentra activo
        IF NOT EXISTS (
            SELECT 1 FROM perfil p 
            JOIN usuario u ON p.id_usuario = u.id_usuario 
            WHERE p.id_perfil = @id_perfil AND u.activo = 1
        )
        BEGIN
            RAISERROR('El perfil no existe o el usuario está inactivo.', 16, 1);
            RETURN;
        END

        -- validamos que se proporciona contenido o episodio, pero no ambos
        IF (@id_contenido IS NULL AND @id_episodio IS NULL) OR 
           (@id_contenido IS NOT NULL AND @id_episodio IS NOT NULL)
        BEGIN
            RAISERROR('Debe proporcionar id_contenido o id_episodio, pero no ambos.', 16, 1);
            RETURN;
        END

        -- insertamos la repdroduccion
        INSERT INTO reproduccion (id_perfil, id_contenido, id_episodio, progreso_minutos, completado)
        VALUES (
            @id_perfil, 
            @id_contenido, 
            @id_episodio, 
            @progreso_minutos,
            CASE 
                WHEN @id_contenido IS NOT NULL THEN 
                    CASE WHEN @progreso_minutos >= (SELECT duracion FROM contenido WHERE id_contenido = @id_contenido) * 0.9 THEN 1 ELSE 0 END
                ELSE 
                    CASE WHEN @progreso_minutos >= (SELECT duracion FROM episodio WHERE id_episodio = @id_episodio) * 0.9 THEN 1 ELSE 0 END
            END
        );
        
        PRINT 'Reproducción registrada exitosamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al registrar la reproducción: ' + ERROR_MESSAGE();
    END CATCH
END;
```

> [!NOTE]  
> Por defecto, los procedimientos almacenados de definidos por el usuario son *permanentes locales*, es decir, están disponibles solo en la base de datos actual y se almacenan en la base de datos local.

### `2. Temporales`

Estos procedimientos son una variante de los que define el usuario, pero se caracterizan por no ser permanentes. Están diseñados para un uso a corto plazo y se almacenan en la base de datos tempdb.

Existen dos tipos: los temporales locales, que solo están disponibles dentro de la sesión de usuario que los creó, y los temporales globales, que son visibles para cualquier usuario del servidor una vez creados.

Su principal utilidad es para ejecutar operaciones específicas de una sesión o tareas transitorias, sin necesidad de que el procedimiento se guarde de forma permanente en la base de datos.

- De manera local:

```SQL
CREATE PROCEDURE #VerificarAccesoContenido
    @id_usuario INT,
    @id_contenido INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @plan_activo BIT;
    DECLARE @resolucion_permitida VARCHAR(10);
    DECLARE @mensaje VARCHAR(200);
    
    -- verificamos si el usuario tiene una suscripcion activa
    SELECT @plan_activo = CASE WHEN s.estado = 'Activa' THEN 1 ELSE 0 END,
           @resolucion_permitida = p.resolucion_permitida
    FROM usuario u
    LEFT JOIN suscripcion s ON u.id_usuario = s.id_usuario 
        AND s.estado = 'Activa'
    LEFT JOIN planes p ON s.id_plan = p.id_plan
    WHERE u.id_usuario = @id_usuario;
    
    -- determinamos el resultado
    IF @plan_activo = 1
    BEGIN
        SET @mensaje = 'Acceso permitido. Resolución disponible: ' + @resolucion_permitida;
    END
    ELSE
    BEGIN
        SET @mensaje = 'Acceso denegado. No hay suscripción activa.';
    END
    
    SELECT @mensaje AS Resultado;
END;
```

- De manera global:

```SQL
CREATE PROCEDURE ##EstadisticasReproduccionHoy
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        COUNT(DISTINCT r.id_perfil) AS PerfilesActivos,
        COUNT(r.id_reproduccion) AS TotalReproducciones,
        SUM(CASE WHEN r.completado = 1 THEN 1 ELSE 0 END) AS ReproduccionesCompletadas,
        AVG(r.progreso_minutos) AS PromedioMinutosVistos,
        (SELECT TOP 1 c.titulo 
         FROM reproduccion r2
         JOIN contenido c ON r2.id_contenido = c.id_contenido
         WHERE CAST(r2.fecha_reproduccion AS DATE) = CAST(GETDATE() AS DATE)
         GROUP BY c.titulo, c.id_contenido
         ORDER BY COUNT(*) DESC) AS ContenidoMasVisto
    FROM reproduccion r
    WHERE CAST(r.fecha_reproduccion AS DATE) = CAST(GETDATE() AS DATE);
END;
```

### `3. Sistema`

Estos procedimientos son componentes internos del motor de SQL Server, utilizados para gestionar la base de datos. Físicamente se guardan en la base de datos interna "Resource", aunque para el usuario aparecen de forma lógica en el esquema sys de cada base de datos.

Cumplen tareas administrativas y de mantenimiento; por ejemplo, muchos de los procedimientos en la base msdb se usan para administrar trabajos y alertas.

Se identifican fácilmente porque sus nombres comienzan con el prefijo sp_. Por esta razón, SQL Server recomienda no usar ese mismo prefijo al nombrar los procedimientos creados por el usuario, para así evitar conflictos o confusiones.

```SQL
-- obtenemos informacion sobre la estructura de la tabla contenido
EXEC sp_help 'contenido';

-- nos permite ver todas las dependencias de la tabla reproduccion
EXEC sp_depends 'reproduccion';

-- lista todos los procedimientos almacenados en la base de datos FilmStream
EXEC sp_stored_procedures;

-- obtenemos informacion detallada sobre las columnas de la tabla usuario
EXEC sp_columns 'usuario';

-- nos permite ver las foreign keys de la tabla episodio
EXEC sp_fkeys 'episodio';
```

### `4. Extendidos Definidos por el Usuario`

Los procedimientos extendidos ofrecen una forma de ejecutar código que se encuentra fuera de SQL Server, como funciones compiladas en bibliotecas DLL, escritas comúnmente en lenguajes como C.

Esta capacidad se utiliza para realizar tareas muy especializadas que serían extremadamente complejas o imposibles de lograr usando únicamente T-SQL. Esto incrementa la flexibilidad del motor de base de datos para manejar requerimientos avanzados o interactuar con el sistema operativo.

Un ejemplo conocido es xp_cmdshell, que permite ejecutar comandos directamente en el sistema operativo del servidor. En el contexto de nuestra base de datos, esto podría utilizarse para tareas como exportar reportes de reproducción a archivos CSV, crear respaldos automatizados de logs de auditoría de usuarios, o verificar el espacio en disco disponible para almacenar archivos de contenido multimedia. Es importante destacar que este tipo de procedimiento requiere ser habilitado explícitamente y necesita permisos de seguridad muy específicos para su uso.

```SQL
-- exportar estadisticas de reproduccion a un archivo CSV
EXEC xp_cmdshell 'bcp "SELECT u.nombre, COUNT(r.id_reproduccion) as total_reproducciones FROM FilmStream.dbo.usuario u JOIN FilmStream.dbo.perfil p ON u.id_usuario = p.id_usuario JOIN FilmStream.dbo.reproduccion r ON p.id_perfil = r.id_perfil GROUP BY u.nombre" queryout "C:\Reportes\estadisticas_usuarios.csv" -c -t, -T -S localhost';

-- Crear un respaldo del log de auditoría de suscripciones
EXEC xp_cmdshell 'bcp "SELECT * FROM FilmStream.dbo.auditoria_suscripcion" queryout "C:\Backups\auditoria_suscripcion_backup.txt" -c -T -S localhost';
```

## **Ventajas del uso de procedimientos almacenados**

1. **Reducción del tráfico de red**: En lugar de que la aplicación envíe numerosas sentencias SQL por separado, envía una única llamada al procedimiento. El servidor ejecuta el bloque completo de comandos internamente. Esto reduce drásticamente la comunicación entre el cliente y el servidor, mejorando el rendimiento, especialmente en aplicaciones que realizan operaciones de datos de forma intensiva.

2. **Mayor seguridad**: Permiten gestionar los permisos de forma más granular. Un usuario puede tener permiso para ejecutar un procedimiento (que inserta datos, por ejemplo) sin tener permiso directo para escribir en la tabla subyacente. Esto limita la superficie de ataque, ayuda a prevenir la inyección de SQL (ya que las consultas suelen estar parametrizadas) y el código fuente del procedimiento se puede cifrar para ocultar la lógica de negocio.

3. **Reutilización del código**: Las tareas comunes o repetitivas se encapsulan en un solo lugar (el procedimiento). Cualquier aplicación o script que necesite realizar esa tarea simplemente llama al procedimiento, en lugar de replicar el código SQL. Esto no solo ahorra trabajo, sino que garantiza la consistencia: si la lógica necesita actualizarse, el cambio se hace una sola vez.

4. **Facilidad de mantenimiento**: Al centralizar la lógica de negocio en la base de datos (en lugar de tenerla repartida en el código de la aplicación), las actualizaciones son más sencillas. Se puede modificar el funcionamiento de un procedimiento (por ejemplo, cambiar cómo se calcula un descuento) directamente en el servidor, sin necesidad de editar, recompilar y redistribuir las aplicaciones cliente que lo utilizan.

5. **Mejora de rendimiento**: La primera vez que se ejecuta un procedimiento, SQL Server lo compila y crea un plan de ejecución (la forma más eficiente de acceder a los datos). Este plan se almacena en caché. En las llamadas siguientes, el servidor reutiliza ese plan optimizado en lugar de tener que analizar y compilar la consulta desde cero, lo que resulta en una ejecución mucho más rápida.

## **¿Qué es una función almacenada?**

Las funciones almacenadas (también conocidas como funciones definidas por el usuario o UDF) son objetos de base de datos diseñados para encapsular cálculos o lógica de negocio específica.

Su propósito es poder reutilizar esa lógica fácilmente en distintas consultas. La característica principal que las diferencia de los procedimientos almacenados es que obligatoriamente deben devolver un valor.

Gracias a esto, las funciones pueden ser invocadas directamente dentro de sentencias SQL, por ejemplo, como parte de una cláusula `SELECT`, `WHERE` o incluso en un `JOIN`.

## **Tipos de funciones almacenadas**

### `1. Funciones Escalares`

Las funciones escalares son aquellas que devuelven un único valor con un tipo de dato específico (por ejemplo, un número, una cadena de texto o una fecha).

Su principal utilidad es encapsular cálculos o transformaciones que resultan en un solo dato. Gracias a que devuelven un solo valor, estas funciones son muy flexibles y pueden utilizarse en diversas partes de una sentencia SQL, como en las cláusulas `SELECT` o `WHERE`.

```SQL
CREATE OR ALTER FUNCTION dbo.fn_Contenido_ObtenerPromedioValoracion
(
    @id_contenido INT
)
RETURNS DECIMAL(4,2)
AS
BEGIN
    DECLARE @promedio DECIMAL(4,2);

    SELECT @promedio = CONVERT(DECIMAL(4,2), AVG(CAST(r.valoracion AS DECIMAL(10,2))))
    FROM dbo.resena r
    WHERE r.id_contenido = @id_contenido;

    RETURN ISNULL(@promedio, 0.00);
END;
```

### `2. Funciones con Valores de Tabla en Línea`

Este tipo de función retorna un conjunto de resultados (una tabla). Su característica distintiva es que su lógica interna se basa en una única instrucción de consulta (una sola sentencia `SELECT`).

Se asemejan mucho a las Vistas, pero tienen una ventaja fundamental: pueden aceptar parámetros. Esto las hace más dinámicas, ya que permiten filtrar o controlar los datos que devuelven basándose en los valores de entrada proporcionados.

```SQL
CREATE OR ALTER FUNCTION dbo.fn_ContenidosPorGenero
(
    @nombre_genero VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        c.id_contenido,
        c.titulo,
        c.año_lanzamiento,
        c.duracion,
        g.nombre_genero
    FROM contenido c
    INNER JOIN genero_contenido gc ON c.id_contenido = gc.id_contenido
    INNER JOIN genero g ON gc.id_genero = g.id_genero
    WHERE g.nombre_genero = @nombre_genero
);
```

### `3. Funciones con Valores de Tabla Multidefinidas`

A diferencia de las funciones en línea (que solo permiten una sentencia), este tipo de función retorna una tabla, pero su lógica interna puede ser mucho más compleja.

Las funciones multisentencia permiten usar múltiples sentencias T-SQL para construir el resultado. Dentro de ellas se pueden definir variables (`DECLARE`) y utilizar estructuras de control de flujo (como `IF` o `WHILE`). Esto significa que pueden ejecutar varios pasos y una lógica más elaborada antes de ensamblar y devolver la tabla final.

```SQL
CREATE OR ALTER FUNCTION dbo.fn_PerfilTopContenido
(
    @id_perfil INT,
    @top INT
)
RETURNS @T TABLE
(
    id_contenido INT,
    titulo VARCHAR(150),
    minutos_vistos INT
)
AS
BEGIN
    INSERT INTO @T (id_contenido, titulo, minutos_vistos)
    SELECT TOP (@top)
        c.id_contenido,
        c.titulo,
        SUM(r.progreso_minutos) AS minutos_vistos
    FROM reproduccion r
    JOIN contenido c ON r.id_contenido = c.id_contenido
    WHERE r.id_perfil = @id_perfil
    GROUP BY c.id_contenido, c.titulo
    ORDER BY SUM(r.progreso_minutos) DESC;

    RETURN;
END;
```

## **Ventajas del uso de funciones almacenadas**

- Reutilización de Código: Las funciones encapsulan lógica que se puede reutilizar en múltiples consultas, permitiendo su invocación en diferentes partes de la aplicación y en expresiones SQL.

- Devolución de Valores: Las funciones almacenadas pueden devolver un único valor (funciones escalares) o un conjunto de resultados (funciones de tabla), permitiendo su uso directo en consultas, lo cual no es posible con los procedimientos.

- Integración en Consultas: Las funciones pueden ser integradas en diversas partes de una consulta SQL, como en SELECT, WHERE, o ORDER BY, otorgando flexibilidad. Los procedimientos almacenados, en cambio, requieren llamadas separadas.

- Abstracción de Complejidad: Las funciones almacenadas permiten ocultar la complejidad de la lógica de negocio, proporcionando una interfaz sencilla para operaciones complejas.

- Mejor Rendimiento en Consultas: Las funciones de tabla en línea pueden ser optimizadas por SQL Server en ciertas situaciones, mejorando el rendimiento en comparación con subconsultas.

- Mantenimiento Simplificado: Actualizar la lógica de negocio solo requiere modificar la función en un solo lugar, lo que mejora la consistencia y simplifica el mantenimiento en el código de la aplicación.

## **Tareas**

> Ver el script para entender más [script.sql](script_procedimientos_funciones.sql)

## **Conclución**

Una función puede ser llamada en un `SELECT`, `WHERE`, o cualquier otra parte de una consulta, lo que facilita la manipulación de datos de manera dinámica. Mientras que un procedimiento almacenado se utiliza para ejecutar operaciones como inserciones, actualizaciones, eliminaciones, o cualquier acción que implique cambios en los datos o en su estructura.
