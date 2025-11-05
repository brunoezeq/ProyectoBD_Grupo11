/*
Tema: Optimización de consultas a través de índices

Criterios de Evaluación:

	1. Medición correcta de los tiempos de respuesta antes y después de aplicar índices.
	2. Documentación detallada de los planes de ejecución de las consultas.
	3. Evaluación de la mejora en el rendimiento.

Tareas: 

	1. Realizar una carga masiva de por lo menos un millón de registro sobre alguna tabla que contenga un campo fecha (sin índice). Hacerlo con un script para poder automatizarlo.
	2. Realizar una búsqueda por periodo y registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.
	3. Definir un índice agrupado sobre la columna fecha y repetir la consulta anterior. Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.
	4. Borrar el índice creado
	5. Definir otro índice agrupado sobre la columna fecha pero que además incluya las columnas seleccionadas y repetir la consulta anterior. Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.
	6. Expresar las conclusiones en base a las pruebas realizadas.
*/

USE FilmStream;
GO

-- ====================================
-- 1. CARGA MASIVA DE DATOS
-- ====================================

-- ====================================
-- CARGA MASIVA DE DATOS (versión corregida)
-- ====================================

TRUNCATE TABLE reproduccion;

DECLARE @i INT = 1;
DECLARE @max INT = 1000000;

WHILE @i <= @max
BEGIN
    INSERT INTO reproduccion (fecha_reproduccion, progreso_minutos, id_contenido, id_usuario)
    VALUES (
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 730, '2023-01-01'), -- Fecha aleatoria entre 2023 y 2025
        ABS(CHECKSUM(NEWID())) % 120,                             -- Minutos vistos (0 a 120)
        (ABS(CHECKSUM(NEWID())) % 3) + 1,                         -- Contenidos válidos: 1, 2, 3
        (ABS(CHECKSUM(NEWID())) % 3) + 1                          -- Usuarios válidos: 1, 2, 3
    );
    SET @i += 1;
END;


-- Verificamos que se hayan cargado correctamente los registros
SELECT COUNT(*) AS "Registros totales" FROM reproduccion; 


-- ====================================
-- 2. CONSULTA POR PERIODO
-- ====================================

-- Se mostraran los datos de las reproducciones dadas entre 01/01/2024 y 31/03/2024

SET STATISTICS TIME ON; -- mide el tiempo que tarda SQL Server en procesar una consulta
SET STATISTICS IO ON;	-- mide la cantidad de lecturas físicas y lógicas

SELECT
	*
FROM 
	reproduccion
WHERE 
	fecha_reproduccion BETWEEN '2024-01-01' AND '2024-03-31';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

/*	Plan de ejecucion y tiempos de respuesta:

(124743 rows affected)
Table 'reproduccion'. Scan count 1, logical reads 3475, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 219 ms,  elapsed time = 1809 ms.
*/


-- ====================================
-- 3. CREAR ÍNDICE AGRUPADO
-- ====================================

-- Se debe eliminar temporalmente la PK porque solo puede existir un índice agrupado por tabla
ALTER TABLE reproduccion DROP CONSTRAINT PK_reproduccion;

-- Creación del índice agrupado por fecha
CREATE CLUSTERED INDEX idx_reproduccion_fecha
ON reproduccion (fecha_reproduccion);

-- Repetimos la consulta por periodo
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT id_reproduccion, id_usuario, id_contenido, fecha_reproduccion, progreso_minutos
FROM reproduccion
WHERE fecha_reproduccion BETWEEN '2024-01-01' AND '2024-03-31';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

/*	Plan de ejecucion y tiempos de respuesta:

(124743 rows affected)
Table 'reproduccion'. Scan count 1, logical reads 562, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 62 ms,  elapsed time = 1910 ms.
*/

-- ====================================
-- 4. BORRAR ÍNDICE AGRUPADO
-- ====================================
DROP INDEX idx_reproduccion_fecha ON reproduccion;

-- (opcional) volver a crear la PK original
ALTER TABLE reproduccion
ADD CONSTRAINT PK_reproduccion PRIMARY KEY (id_reproduccion);


-- ====================================
-- 5. ÍNDICE AGRUPADO CON COLUMNAS INCLUIDAS
-- ====================================
ALTER TABLE reproduccion DROP CONSTRAINT PK_reproduccion;

CREATE CLUSTERED INDEX idx_reproduccion_fecha_incluye
ON reproduccion (fecha_reproduccion, id_usuario, id_contenido, progreso_minutos); 

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT id_reproduccion, id_usuario, id_contenido, fecha_reproduccion, progreso_minutos
FROM reproduccion
WHERE fecha_reproduccion BETWEEN '2024-01-01' AND '2024-03-31';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

-- DROP INDEX idx_reproduccion_fecha_incluye ON reproduccion; 

/*	Plan de ejecucion y tiempos de respuesta:

(124743 rows affected) Table 'reproduccion'. Scan count 1, logical reads 492, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0. 

SQL Server Execution Times: 
	CPU time = 94 ms, elapsed time = 1841 ms.

*/


-- ====================================
-- 6. CONCLUSIONES 
-- ====================================

/*

Una vez desarrolladas todas las pruebas de rendimiento aplicacion busquedas sin indices, con indices agrupados y  con indice agrupado incluyendo las demas columnas podemos concluir que:
	
	1. Al trabajar sin indices el motor debía realizar un escaneo completo de la tabla, lo cual resultó en un alto numero de 
	lectura logicas 3475 con un tiempo de procesamiento en CPU de 219ms y un tiempo total de ejecución de 1809ms.
	2. Al aplicar un indice agrupado sobre la columna fecha la consulta arrojó los siguientes resultados: 
		- 562 lecturas lógicas  
		- Tiempo de procesamiento en CPU de 62ms
		- Tiempo total de ejecución de 1910ms, podemos observar un leve aumento con respecto al tiempo de ejecución total de la 
		consulta sin indice, esto puede deberse al cache del sistema operativo o SQL o a la actividade del disco o memoria al momento de la medición
	3. Por último, al trabajar con un indice agrupado e incluyendo las demas columnas de la tabla reproduccion obtuvimos los siguientes resultados:
		- Una baja en la cantidad de lecturas lógicas a 492
		- Un aumento poco significativo del procesamiento en CPU de 94ms, debido al mayor tamaño del indice
		- Un tiempo de ejecución total de 1841ms 

En conclusión, el uso de índices adecuados mejora notablemente el rendimiento de las consultas, especialmente cuando se aplican sobre columnas que se usan 
frecuentemente en filtros o cláusulas WHERE y cuando se incluyen las columnas más consultadas en el índice.

*/