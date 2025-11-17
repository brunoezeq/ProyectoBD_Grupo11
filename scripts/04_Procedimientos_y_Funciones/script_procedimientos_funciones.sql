USE FilmStream;
GO

/* Ejercicio 1:
Realizar al menos tres procedimientos almacenados que permitan: Insertar, 
Modificar y borrar registros de alguna de las tablas del proyecto.
*/
  
/*
=======================================================================
1. PROCEDIMIENTO PARA INSERTAR UN NUEVO CONTENIDO
=======================================================================
*/
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

    IF EXISTS (SELECT 1 FROM contenido WHERE id_contenido = @id_contenido)
    BEGIN
        BEGIN TRY
            -- 1. Borrar Episodios (dependen de la tabla Temporada)
            --    Necesitamos encontrar las temporadas asociadas a este contenido
            DELETE FROM episodio 
            WHERE id_contenido = @id_contenido;
            
            -- 2. Borrar Temporadas (dependen de la tabla Contenido)
            DELETE FROM temporada 
            WHERE id_contenido = @id_contenido;
            
            -- 3. Borrar tablas muchos a muchos y otras dependencias directas
            DELETE FROM director_contenido WHERE id_contenido = @id_contenido;
            DELETE FROM reparto WHERE id_contenido = @id_contenido;
            DELETE FROM genero_contenido WHERE id_contenido = @id_contenido;
            DELETE FROM reproduccion WHERE id_contenido = @id_contenido;
            DELETE FROM reseña WHERE id_contenido = @id_contenido;
            
            -- 4. Finalmente, borramos el contenido principal
            DELETE FROM contenido
            WHERE id_contenido = @id_contenido;
            
            PRINT 'El contenido y todos sus registros asociados fueron eliminados correctamente.';
        END TRY
        BEGIN CATCH
            PRINT 'Error al eliminar el contenido. Verifique las dependencias.';
            PRINT ERROR_MESSAGE();
        END CATCH
    END
    ELSE
    BEGIN
        PRINT 'Error: El contenido con ID ' + CAST(@id_contenido AS VARCHAR) + ' no existe.';
    END
END
GO

----------------------------------------------------------------------------
/* Ejercicio 2:
Insertar un lote de datos en las tablas mencionadas (guardar el script) 
con sentencias insert y otro lote invocando a los procedimientos creados.
*/

-- Lote de datos con sentencias INSERT directas

-- Insertamos una pelicula (ID 5)
INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido)
VALUES ('Interestelar', 'Un equipo de exploradores viaja a través de un agujero de gusano.', 2014, 169, 1);

-- Insertamos una serie (ID 6)
INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido)
VALUES ('Stranger Things', 'Un niño desaparece y sus amigos descubren un misterio.', 2016, 60, 2);
GO

-- Verificamos 
SELECT * FROM contenido WHERE id_contenido IN (5, 6);
GO

----------------------------------------------------------------------------

-- Lote de datos invocando al procedimiento almacenado

-- Insertamos un documental (ID 7)
EXEC sp_Contenido_Insertar
    @titulo = 'Nuestro Planeta',
    @sinopsis = 'Documental sobre la belleza y fragilidad de nuestro planeta.',
    @año_lanzamiento = 2019,
    @duracion = 50,
    @id_tipo_contenido = 3;

-- Insertamos otra pelicula (ID 8)
EXEC sp_Contenido_Insertar
    @titulo = 'El Padrino',
    @sinopsis = 'El envejecido patriarca de una dinastía del crimen organizado.',
    @año_lanzamiento = 1972,
    @duracion = 175,
    @id_tipo_contenido = 1;
GO

-- Verificamos los contenidos insertados
SELECT * FROM contenido WHERE id_contenido IN (7, 8);
GO

----------------------------------------------------------------------------
/* Ejercicio 4:
Realizar  update y delete sobre  algunos de los registros insertados
en esas tablas invocando a los procedimientos. 
*/
----------------------------------------------------------------------------

-- 1. ACTUALIZAR 'El Padrino' (ID 8) usando el procedimiento almacenado 
-- Vamos a actualizar la sinopsis.
EXEC sp_Contenido_Actualizar
    @id_contenido = 8,
    @titulo = 'El Padrino',
    @sinopsis = 'El patriarca de una dinastía criminal transfiere el control a su hijo.', -- Sinopsis corregida
    @año_lanzamiento = 1972,
    @duracion = 175,
    @id_tipo_contenido = 1;
GO

-- Verificamos el cambio
SELECT * FROM contenido WHERE id_contenido = 8;
GO

-- 2. ELIMINAR 'Nuestro Planeta' (ID 7) usando el SP
EXEC sp_Contenido_Eliminar
    @id_contenido = 7;
GO

-- Verificamos la eliminación
SELECT * FROM contenido WHERE id_contenido = 7; -- Deberia devolver 0 filas dado que el contenido fue eliminado.
GO

----------------------------------------------------------------------------
-- Ejercicio 5: 
-- Desarrollar al menos tres funciones almacenadas. 
----------------------------------------------------------------------------

/*
=======================================================================
1. FUNCIÓN PARA OBTENER EL PROMEDIO DE VALORACIÓN
=======================================================================
- Recibe un @id_contenido y calcula la valoración media de sus reseñas.
- Usamos ISNULL para devolver 0 si no tiene reseñas.
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
    FROM reseña
    WHERE id_contenido = @id_contenido;
    
    RETURN ISNULL(@promedio, 0.00);
END
GO

-- Probamos obtener el promedio de valoracion:
SELECT 
    titulo, 
    dbo.fn_Contenido_ObtenerPromedioValoracion(id_contenido) AS ValoracionPromedio
FROM contenido
WHERE id_contenido IN (1, 2); -- Verificamos con jurassic park y el secreto de sus ojos
GO


/*
=======================================================================
2. FUNCION PARA OBTENER EL NOMBRE DEL TIPO DE CONTENIDO
=======================================================================
- Recibe un @id_tipo_contenido y devuelve el nombre ('Pelicula', 'Serie').
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

-- Ejemplo de uso:
SELECT 
    titulo, 
    dbo.fn_Contenido_ObtenerNombreTipo(id_tipo_contenido) AS Tipo
FROM contenido
WHERE id_contenido IN (1, 3); -- Vemos Jurassic Park (Pelicula) y La Casa de Papel (Serie)
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

-- Ejemplo de uso:
SELECT 
    titulo, 
    duracion, 
    dbo.fn_Contenido_FormatearDuracion(duracion) AS DuracionFormateada
FROM contenido
WHERE id_tipo_contenido = 1; -- Vemos la duracion formateada de las peliculas
GO
