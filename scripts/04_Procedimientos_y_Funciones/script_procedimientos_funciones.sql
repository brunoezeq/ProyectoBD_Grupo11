USE filmstream;
GO

/* Ejercicio 1:
Realizar al menos tres procedimientos almacenados que permitan: Insertar, 
Modificar y borrar registros de alguna de las tablas del proyecto.
*/

/*=======================================================================
1. PROCEDIMIENTO PARA INSERTAR UN NUEVO CONTENIDO
=======================================================================*/
CREATE PROCEDURE sp_Contenido_Insertar
    @titulo VARCHAR(150),
    @sinopsis VARCHAR(300),
    @año_lanzamiento INT,
    @duracion INT,
    @id_tipo_contenido INT
AS
BEGIN
    SET NOCOUNT ON; 
    BEGIN TRY
        -- Validamos que el tipo de contenido exista
        IF NOT EXISTS (SELECT 1 FROM tipo_contenido WHERE id_tipo_contenido = @id_tipo_contenido)
        BEGIN
            PRINT 'Error: El id_tipo_contenido especificado no existe.';
            RETURN;
        END

        INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido)
        VALUES (@titulo, @sinopsis, @año_lanzamiento, @duracion, @id_tipo_contenido);
        
        PRINT 'Contenido insertado correctamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar el contenido.';
        PRINT ERROR_MESSAGE();
    END CATCH
END
GO

-- Ejemplo de uso:
EXEC sp_Contenido_Insertar
    @titulo = 'Matrix',
    @sinopsis = 'Un hacker descubre la verdad sobre su realidad.',
    @año_lanzamiento = 1999,
    @duracion = 136,
    @id_tipo_contenido = 1;
GO

/*
=======================================================================
2. PROCEDIMIENTO PARA MODIFICAR UN CONTENIDO EXISTENTE
=======================================================================
- Usamos @id_contenido para identificar el registro a modificar.
*/
CREATE PROCEDURE sp_Contenido_Actualizar
    @id_contenido INT,
    @titulo VARCHAR(150),
    @sinopsis VARCHAR(300),
    @año_lanzamiento INT,
    @duracion INT,
    @id_tipo_contenido INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificamos si el contenido existe
    IF EXISTS (SELECT 1 FROM contenido WHERE id_contenido = @id_contenido)
    BEGIN
        BEGIN TRY
            -- Validamos que el tipo de contenido exista
            IF NOT EXISTS (SELECT 1 FROM tipo_contenido WHERE id_tipo_contenido = @id_tipo_contenido)
            BEGIN
                PRINT 'Error: El id_tipo_contenido especificado no existe.';
                RETURN; -- Terminamos la ejecucion
            END

            UPDATE contenido
            SET 
                titulo = @titulo,
                sinopsis = @sinopsis,
                año_lanzamiento = @año_lanzamiento,
                duracion = @duracion,
                id_tipo_contenido = @id_tipo_contenido
            WHERE 
                id_contenido = @id_contenido;
            
            PRINT 'Contenido actualizado correctamente.';
        END TRY
        BEGIN CATCH
            PRINT 'Error al actualizar el contenido.';
            PRINT ERROR_MESSAGE();
        END CATCH
    END
    ELSE
    BEGIN
        PRINT 'Error: El contenido con ID ' + CAST(@id_contenido AS VARCHAR) + ' no existe.';
    END
END
GO

-- Ejemplo de uso:
DECLARE @id_actualizar INT = (SELECT TOP 1 id_contenido FROM contenido WHERE titulo = 'Matrix');

IF @id_actualizar IS NOT NULL
    EXEC sp_Contenido_Actualizar
        @id_contenido = @id_actualizar,
        @titulo = 'Matrix',
        @sinopsis = 'Un hacker descubre la verdad sobre su realidad y su papel en la guerra contra las máquinas.',
        @año_lanzamiento = 1999,
        @duracion = 136,
        @id_tipo_contenido = 1;
GO

/*
=======================================================================
3. PROCEDIMIENTO PARA BORRAR UN CONTENIDO
=======================================================================
- Este procedimiento almacenado es más complejo debido a las foreign keys.
- Debemos eliminar todos los registros en tablas hijas antes de poder 
    eliminar el registro en la tabla padre (contenido).
*/
CREATE PROCEDURE sp_Contenido_Eliminar
    @id_contenido INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM contenido WHERE id_contenido = @id_contenido)
    BEGIN
        RAISERROR('Error: El contenido con ID %d no existe.', 16, 1, @id_contenido);
        RETURN;
    END

    BEGIN TRY
        -- 1. Borrar reproducciones de episodios asociados al contenido (series)
        DELETE r
        FROM reproduccion r
        INNER JOIN episodio e ON r.id_episodio = e.id_episodio
        INNER JOIN temporada t ON e.id_temporada = t.id_temporada
        WHERE t.id_contenido = @id_contenido;
        
        -- 2. Borrar reproducciones directas del contenido (películas)
        DELETE FROM reproduccion WHERE id_contenido = @id_contenido;
        
        -- 3. Borrar reseñas del contenido
        DELETE FROM [reseña] WHERE id_contenido = @id_contenido;
        
        -- 4. Borrar listas que contienen este contenido
        DELETE FROM lista_contenido WHERE id_contenido = @id_contenido;
        
        -- 5. Las siguientes se eliminan por CASCADE automáticamente:
        -- director_contenido, reparto, genero_contenido, temporada, episodio
            
        
        -- 6. Finalmente, borramos el contenido principal
        DELETE FROM contenido WHERE id_contenido = @id_contenido;
        
        PRINT 'El contenido y todos sus registros asociados fueron eliminados correctamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al eliminar el contenido: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END
GO

-- Ejemplo de uso:
DECLARE @id_eliminar INT = (SELECT TOP 1 id_contenido FROM contenido WHERE titulo = 'Matrix');

IF @id_eliminar IS NOT NULL
    EXEC sp_Contenido_Eliminar @id_contenido = @id_eliminar;
GO

/*
=================================================================================================
4. PROCEDIMIENTO TEMPORAL LOCAL PARA VERIFICAR DISPONIBILIDAD DE CONTENIDO EN EL PLAN DE USUARIO
=================================================================================================
*/
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

-- Ejemplo de uso (solo disponible en la sesión actual):
DECLARE @usuario_id INT = (SELECT TOP 1 id_usuario FROM usuario WHERE activo = 1);
DECLARE @contenido_id INT = (SELECT TOP 1 id_contenido FROM contenido);

EXEC #VerificarAccesoContenido @id_usuario = @usuario_id, @id_contenido = @contenido_id;
GO

/*
=======================================================================
5. PROCEDIMIENTO PARA REGISTRAR UNA NUEVA REPRODUCCION DE CONTENIDO
=======================================================================
*/
CREATE PROCEDURE sp_RegistrarReproduccion
    @id_perfil INT,
    @id_contenido INT = NULL,
    @id_episodio INT = NULL,
    @progreso_minutos INT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validar que el perfil existe y está activo
        IF NOT EXISTS (
            SELECT 1 FROM perfil p 
            JOIN usuario u ON p.id_usuario = u.id_usuario 
            WHERE p.id_perfil = @id_perfil AND u.activo = 1
        )
        BEGIN
            RAISERROR('El perfil no existe o el usuario está inactivo.', 16, 1);
            RETURN;
        END

        -- Validar que se proporciona contenido O episodio, pero no ambos
        IF (@id_contenido IS NULL AND @id_episodio IS NULL) OR 
           (@id_contenido IS NOT NULL AND @id_episodio IS NOT NULL)
        BEGIN
            RAISERROR('Debe proporcionar id_contenido o id_episodio, pero no ambos.', 16, 1);
            RETURN;
        END

        -- Validar existencia del contenido
        IF @id_contenido IS NOT NULL AND NOT EXISTS (SELECT 1 FROM contenido WHERE id_contenido = @id_contenido)
        BEGIN
            RAISERROR('El contenido especificado no existe.', 16, 1);
            RETURN;
        END

        -- Validar existencia del episodio
        IF @id_episodio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM episodio WHERE id_episodio = @id_episodio)
        BEGIN
            RAISERROR('El episodio especificado no existe.', 16, 1);
            RETURN;
        END

        -- Registrar la reproducción
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
GO

-- Ejemplos de uso:
-- 1. Registrar que un perfil vio una película (usar IDs reales del lote)
DECLARE @perfil_1 INT = (SELECT TOP 1 id_perfil FROM perfil);
DECLARE @pelicula_1 INT = (SELECT TOP 1 id_contenido FROM contenido WHERE duracion IS NOT NULL);

IF @perfil_1 IS NOT NULL AND @pelicula_1 IS NOT NULL
    EXEC sp_RegistrarReproduccion 
        @id_perfil = @perfil_1, 
        @id_contenido = @pelicula_1, 
        @progreso_minutos = 120;
GO

-- 2. Registrar que un perfil vio un episodio de una serie
DECLARE @perfil_2 INT = (SELECT TOP 1 id_perfil FROM perfil ORDER BY id_perfil DESC);
DECLARE @episodio_1 INT = (SELECT TOP 1 id_episodio FROM episodio);

IF @perfil_2 IS NOT NULL AND @episodio_1 IS NOT NULL
    EXEC sp_RegistrarReproduccion 
        @id_perfil = @perfil_2, 
        @id_episodio = @episodio_1, 
        @progreso_minutos = 45;
GO

/*
=======================================================================
6. PROCEDIMIENTO PARA OBTENER ESTADISTICAS DE REPRODUCCION DEL DIA
=======================================================================
*/
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
GO

-- Ejemplo de uso (disponible para cualquier sesión del servidor):
-- Nota: Requiere que haya reproducciones del día actual
EXEC ##EstadisticasReproduccionHoy;
GO

----------------------------------------------------------------------------

/* 
Ejercicio 2:
Insertar un lote de datos en las tablas mencionadas (guardar el script) 
con sentencias insert y otro lote invocando a los procedimientos creados.
*/

-- Lote de datos con sentencias INSERT directas

-- Insertamos una película
INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido, id_clasificacion)
VALUES (
    'Interestelar', 
    'Un equipo de exploradores viaja a través de un agujero de gusano en busca de un nuevo hogar para la humanidad.', 
    2014, 
    169, 
    (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Pelicula'),
    (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'PG-13')
);

-- Insertamos un documental
INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido, id_clasificacion)
VALUES (
    'Cosmos', 
    'Exploración del universo y nuestro lugar en él.', 
    1980, 
    60, 
    (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Documental'),
    (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'G')
);
GO

-- Verificamos los contenidos insertados
SELECT titulo, año_lanzamiento, duracion 
FROM contenido 
WHERE titulo IN ('Interestelar', 'Cosmos');
GO

----------------------------------------------------------------------------

-- Lote de datos invocando al procedimiento almacenado

-- Insertamos otra película usando el procedimiento
EXEC sp_Contenido_Insertar
    @titulo = 'El Padrino',
    @sinopsis = 'El envejecido patriarca de una dinastía del crimen organizado transfiere el control a su hijo renuente.',
    @año_lanzamiento = 1972,
    @duracion = 175,
    @id_tipo_contenido = 1;

-- Insertamos un documental usando el procedimiento
EXEC sp_Contenido_Insertar
    @titulo = 'Nuestro Planeta',
    @sinopsis = 'Serie documental sobre la belleza y fragilidad de nuestro planeta.',
    @año_lanzamiento = 2019,
    @duracion = 50,
    @id_tipo_contenido = 3;
GO

-- Verificamos los contenidos insertados por procedimiento
SELECT titulo, año_lanzamiento, duracion 
FROM contenido 
WHERE titulo IN ('El Padrino', 'Nuestro Planeta');
GO

----------------------------------------------------------------------------
/* 
Ejercicio 3: Realizar una consulta a las tablas para verificar los datos insertados.
*/
----------------------------------------------------------------------------

-- Consulta 1: Ver todos los contenidos con su tipo y clasificación
SELECT 
    c.id_contenido,
    c.titulo,
    c.año_lanzamiento,
    c.duracion,
    tc.nombre_contenido AS Tipo,
    cl.codigo AS Clasificacion
FROM contenido c
LEFT JOIN tipo_contenido tc ON c.id_tipo_contenido = tc.id_tipo_contenido
LEFT JOIN clasificacion cl ON c.id_clasificacion = cl.id_clasificacion
ORDER BY c.fecha_agregado DESC;
GO

-- Consulta 2: Ver contenidos insertados recientemente (ultimos 5)
SELECT TOP 5
    titulo,
    año_lanzamiento,
    duracion,
    fecha_agregado
FROM contenido
ORDER BY fecha_agregado DESC;
GO

-- Consulta 3: Contar contenidos por tipo
SELECT 
    tc.nombre_contenido AS TipoContenido,
    COUNT(*) AS Total
FROM contenido c
JOIN tipo_contenido tc ON c.id_tipo_contenido = tc.id_tipo_contenido
GROUP BY tc.nombre_contenido
ORDER BY Total DESC;
GO

----------------------------------------------------------------------------
/* Ejercicio 4:
Realizar update y delete sobre algunos de los registros insertados
en esas tablas invocando a los procedimientos.
*/
----------------------------------------------------------------------------

-- 1. ACTUALIZAR 'El Padrino' usando el procedimiento almacenado
-- Obtenemos el ID dinámicamente y actualizamos la sinopsis
DECLARE @id_padrino INT = (SELECT id_contenido FROM contenido WHERE titulo = 'El Padrino' AND año_lanzamiento = 1972);

IF @id_padrino IS NOT NULL
BEGIN
    EXEC sp_Contenido_Actualizar
        @id_contenido = @id_padrino,
        @titulo = 'El Padrino',
        @sinopsis = 'El patriarca de una dinastía criminal transfiere el control a su hijo. Obra maestra del cine.',
        @año_lanzamiento = 1972,
        @duracion = 175,
        @id_tipo_contenido = 1;
    
    -- Verificamos el cambio
    SELECT titulo, sinopsis, duracion 
    FROM contenido 
    WHERE id_contenido = @id_padrino;
END
ELSE
    PRINT 'No se encontró El Padrino para actualizar.';
GO

-- 2. ELIMINAR 'Cosmos' usando el procedimiento almacenado
DECLARE @id_cosmos INT = (SELECT id_contenido FROM contenido WHERE titulo = 'Cosmos' AND año_lanzamiento = 1980);

IF @id_cosmos IS NOT NULL
BEGIN
    EXEC sp_Contenido_Eliminar @id_contenido = @id_cosmos;
    
    -- Verificamos la eliminación (debe devolver 0 filas)
    SELECT COUNT(*) AS Registros 
    FROM contenido 
    WHERE id_contenido = @id_cosmos;
    
    IF NOT EXISTS (SELECT 1 FROM contenido WHERE id_contenido = @id_cosmos)
        PRINT 'Cosmos fue eliminado correctamente.';
END
ELSE
    PRINT 'No se encontró Cosmos para eliminar.';
GO

----------------------------------------------------------------------------
-- Ejercicio 5: 
-- Desarrollar al menos tres funciones almacenadas. 
----------------------------------------------------------------------------

/*
=======================================================================
1. FUNCIÓN PARA OBTENER EL PROMEDIO DE VALORACIÓN
=======================================================================
*/
CREATE FUNCTION fn_Contenido_ObtenerPromedioValoracion
(
    @id_contenido INT
)
RETURNS DECIMAL(4, 2)
AS
BEGIN
    DECLARE @promedio DECIMAL(4, 2);
    
    SELECT @promedio = AVG(CAST(valoracion AS DECIMAL(4, 2)))
    FROM [reseña]
    WHERE id_contenido = @id_contenido;
    
    RETURN ISNULL(@promedio, 0.00);
END
GO

-- Ejemplos de uso:
-- 1. Obtener el promedio de valoración de contenidos con reseñas
SELECT 
    c.titulo, 
    dbo.fn_Contenido_ObtenerPromedioValoracion(c.id_contenido) AS ValoracionPromedio
FROM contenido c
WHERE EXISTS (SELECT 1 FROM [reseña] r WHERE r.id_contenido = c.id_contenido);

-- 2. Filtrar contenidos con valoración alta (mayor o igual a 8)
SELECT 
    c.titulo,
    c.año_lanzamiento,
    dbo.fn_Contenido_ObtenerPromedioValoracion(c.id_contenido) AS Valoracion
FROM contenido c
WHERE dbo.fn_Contenido_ObtenerPromedioValoracion(c.id_contenido) >= 8.0
ORDER BY Valoracion DESC;
GO

/*
========================================================
2. FUNCION PARA OBTENER EL NOMBRE DEL TIPO DE CONTENIDO
========================================================
*/
CREATE FUNCTION fn_Contenido_ObtenerNombreTipo
(
    @id_tipo_contenido INT
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @nombreTipo VARCHAR(50);
    
    SELECT @nombreTipo = nombre_contenido
    FROM tipo_contenido
    WHERE id_tipo_contenido = @id_tipo_contenido;
    
    RETURN @nombreTipo;
END
GO

-- Ejemplos de uso:
-- 1. Obtener el tipo de los primeros 5 contenidos
SELECT TOP 5
    titulo, 
    dbo.fn_Contenido_ObtenerNombreTipo(id_tipo_contenido) AS Tipo
FROM contenido
ORDER BY id_contenido;

-- 2. Contar contenidos por tipo usando la función
SELECT 
    dbo.fn_Contenido_ObtenerNombreTipo(id_tipo_contenido) AS TipoContenido,
    COUNT(*) AS Total
FROM contenido
GROUP BY id_tipo_contenido
ORDER BY Total DESC;
GO

/*
=======================================================================
3. FUNCION PARA FORMATEAR LA DURACION
=======================================================================
- Recibe la duracion en minutos (ej. 127)
- Devuelve un string formateado (ej. '2h 7m')
*/
CREATE FUNCTION fn_Contenido_FormatearDuracion
(
    @minutos INT
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @horas INT;
    DECLARE @minRestantes INT;
    DECLARE @resultado VARCHAR(20);
    
    SET @horas = @minutos / 60;
    SET @minRestantes = @minutos % 60;
    
    SET @resultado = CAST(@horas AS VARCHAR) + 'h ' + CAST(@minRestantes AS VARCHAR) + 'm';
    
    RETURN @resultado;
END
GO

-- Ejemplos de uso:
-- 1. Formatear duración de películas (contenido con duracion NOT NULL)
SELECT TOP 5
    titulo, 
    duracion AS MinutosOriginales, 
    dbo.fn_Contenido_FormatearDuracion(duracion) AS DuracionFormateada
FROM contenido
WHERE duracion IS NOT NULL
ORDER BY duracion DESC;

-- 2. Ver películas largas (más de 2 horas) con formato legible
SELECT 
    titulo,
    año_lanzamiento,
    dbo.fn_Contenido_FormatearDuracion(duracion) AS Duracion
FROM contenido
WHERE duracion > 120
ORDER BY duracion DESC;
GO

/*
=======================================================================
4. FUNCION PARA OBTENER LA CANTIDAD DE CONTENIDOS POR GENERO
=======================================================================
*/
CREATE FUNCTION fn_ContenidosPorGenero
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
GO

-- Ejemplos de uso (usar géneros del lote: Accion, Drama, Ciencia Ficcion, Fantasia, Documental, Terror):
-- 1. Ver todos los documentales
SELECT * FROM dbo.fn_ContenidosPorGenero('Documental');

-- 2. Ver todas las películas de Drama
SELECT titulo, año_lanzamiento, duracion 
FROM dbo.fn_ContenidosPorGenero('Drama');

-- 3. Ver películas de Acción que duren más de 2 horas
SELECT 
    c.titulo,
    c.año_lanzamiento,
    c.duracion
FROM dbo.fn_ContenidosPorGenero('Accion') c 
WHERE c.duracion > 120
ORDER BY c.duracion DESC;

-- 4. Contar contenidos por género usando la función
SELECT 'Accion' AS Genero, COUNT(*) AS Total FROM dbo.fn_ContenidosPorGenero('Accion')
UNION ALL
SELECT 'Drama', COUNT(*) FROM dbo.fn_ContenidosPorGenero('Drama')
UNION ALL
SELECT 'Terror', COUNT(*) FROM dbo.fn_ContenidosPorGenero('Terror');
GO

/*
=======================================================================
5. FUNCION PARA OBTENER UN RANKING PERSONA DE CONSUMO POR PERFIL
=======================================================================
*/
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
GO

-- Ejemplos de uso:
-- 1. Top 5 contenidos más vistos por el primer perfil
DECLARE @primer_perfil INT = (SELECT TOP 1 id_perfil FROM perfil ORDER BY id_perfil);
SELECT * FROM dbo.fn_PerfilTopContenido(@primer_perfil, 5);
GO

-- 2. Top 10 contenidos más vistos por un perfil específico
DECLARE @perfil_fran INT = (SELECT id_perfil FROM perfil p 
                            JOIN usuario u ON p.id_usuario = u.id_usuario 
                            WHERE u.email = 'fran@gmail.com' AND p.nombre_perfil = 'Fran');

IF @perfil_fran IS NOT NULL
BEGIN
    SELECT 
        titulo,
        minutos_vistos,
        minutos_vistos / 60 AS horas_vistas
    FROM dbo.fn_PerfilTopContenido(@perfil_fran, 10)
    ORDER BY minutos_vistos DESC;
END;

/*
Ejercicio 5: Comparar la eficiencia de las operaciones directas versus el uso de procedimientos y funciones.
*/

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

/*
=======================================================================
PRUEBA 1: INSERCION DIRECTA VS PROCEDIMIENTO ALMACENADO
=======================================================================
*/

-- Operacion directa
INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido)
VALUES ('Test Directo', 'Prueba de inserción directa', 2024, 120, 1);
GO

-- Usando procedimiento almacenado
EXEC sp_Contenido_Insertar
    @titulo = 'Test Procedimiento',
    @sinopsis = 'Prueba de inserción con procedimiento',
    @año_lanzamiento = 2024,
    @duracion = 120,
    @id_tipo_contenido = 1;
GO

/*
==============================================
PRUEBA 2: CONSULTA DIRECTA VS FUNCION ESCALAR
==============================================
*/

-- Consulta directa con subconsulta
SELECT TOP 100
    c.titulo,
    c.año_lanzamiento,
    (SELECT AVG(CAST(valoracion AS DECIMAL(4,2))) 
     FROM [reseña] r 
     WHERE r.id_contenido = c.id_contenido) AS ValoracionPromedio
FROM contenido c;
GO

-- Consulta usando función escalar
SELECT TOP 100
    c.titulo,
    c.año_lanzamiento,
    dbo.fn_Contenido_ObtenerPromedioValoracion(c.id_contenido) AS ValoracionPromedio
FROM contenido c;
GO

/*
========================================================
PRUEBA 3: CONSULTA DIRECTA VS FUNCION DE TABLA EN LINEA
========================================================
*/

-- Consulta directa con JOINs
SELECT 
    c.id_contenido,
    c.titulo,
    c.año_lanzamiento
FROM contenido c
INNER JOIN genero_contenido gc ON c.id_contenido = gc.id_contenido
INNER JOIN genero g ON gc.id_genero = g.id_genero
WHERE g.nombre_genero = 'Drama';
GO

-- Usando funcion de tabla en línea
SELECT 
    id_contenido,
    titulo,
    año_lanzamiento
FROM dbo.fn_ContenidosPorGenero('Drama');
GO

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO