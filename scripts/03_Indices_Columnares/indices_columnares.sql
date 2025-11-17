/*
Tema: Índices columnares en SQL server 

Criterios de Evaluación: 

	1. Implementación correcta del índice columnar y comparación de resultados con índices tradicionales. 
	2. Documentación detallada del rendimiento y tiempos de consulta. 
	3. Claridad en las conclusiones sobre la mejora de rendimiento. 

Tareas: 
	
	1. Crear una nueva tabla, tomando como modelo la tabla de mayor ocurrencia del modelo (tabla origen), y renombrarla (tabla nueva) 
	2. Realizar una carga masiva de por lo menos 1 millón de registros sobre la tabla recién creada. Se pueden repetir los registros ya existentes. 
	Hacerlo con un script para poder compartirlo. 
	3. Definir un índice columnar sobre la nueva tabla. 
	4. Ejecutar una consulta sobre tabla origen y la tabla nueva, evaluar los tiempos de respuestas entre ambas tablas (con índice columnar y 
	sin el mismo). 
	5. Expresar las conclusiones en base a las pruebas realizadas.
*/

USE filmstream; 
GO 

-- ==============================
-- 1. CREACIÓN DE LA NUEVA TABLA
-- ==============================

SELECT 
	*
INTO 
	reproduccion_columnar
FROM 
	reproduccion;

-- Comprobamos que se haya creado correctamente la tabla

SELECT * FROM reproduccion_columnar;
SELECT COUNT(*) AS total_registros FROM reproduccion_columnar;

-- =========================
-- 2. CARGA MASIVA DE DATOS
-- =========================

TRUNCATE TABLE reproduccion_columnar;
GO

DECLARE @i INT = 1;
DECLARE @max INT = 1000000;

WHILE @i <= @max
BEGIN
    INSERT INTO reproduccion_columnar (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 3) + 1, -- perfiles 1,2,3
        (ABS(CHECKSUM(NEWID())) % 3) + 1, -- contenidos 1,2,3 (Inception, Stranger Things, Planeta Tierra)
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 730, '2023-01-01'), -- fecha entre 2023-2025
        ABS(CHECKSUM(NEWID())) % 120, -- minutos vistos
        ABS(CHECKSUM(NEWID())) % 2     -- completado 0/1
    );

    SET @i += 1;
END;

-- Verificamos que se haya cargafo el millón de registros 
SELECT COUNT(*) AS "Registros totales" FROM reproduccion_columnar;

-- ==============================
-- 3. CREAMOS EL INDICE COLUMNAR
-- ==============================

CREATE CLUSTERED COLUMNSTORE INDEX CCI_reproduccion
ON reproduccion_columnar;

-- ==============================================================
-- 4. REALIZAMOS LAS CONSULTAS Y COMPARAMOS TIEMPOS DE RESPUESTA
-- ==============================================================

SET STATISTICS IO ON
SET STATISTICS TIME ON

-- TABLA ORIGEN
SELECT id_perfil, id_contenido, fecha_reproduccion, progreso_minutos
FROM reproduccion
WHERE fecha_reproduccion BETWEEN '2024-01-01' AND '2024-03-31';

/* 
(124940 rows affected)
Table 'reproduccion'. Scan count 1, logical reads 4714, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 157 ms,  elapsed time = 1614 ms. */

-- TABLA NUEVA
SELECT id_perfil, id_contenido, fecha_reproduccion, progreso_minutos
FROM reproduccion_columnar
WHERE fecha_reproduccion BETWEEN '2024-01-01' AND '2024-03-31';

/*
La consulta no lee páginas tradicionales.
Solo lee segmentos columnares comprimidos, por eso: 0 logical reads (gran mejora)

(124879 rows affected)
Table 'reproduccion_columnar'. Scan count 1, logical reads 0, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 192, lob physical reads 4, lob page server reads 0, lob read-ahead reads 10, lob page server read-ahead reads 0.
Table 'reproduccion_columnar'. Segment reads 1, segment skipped 0.

 SQL Server Execution Times:
   CPU time = 93 ms,  elapsed time = 1594 ms.
*/

-- ================
-- 5. CONCLUSIONES 
-- ================

/*
Los índices columnares demostraron una optimización significativa en la ejecución de consultas analíticas. En la tabla tradicional (rowstore), 
la consulta requirió 4714 lecturas lógicas, mientras que en la tabla con índice columnar la misma consulta redujo ese valor a 0, 
ejecutando únicamente 192 lecturas LOB asociadas a segmentos comprimidos. Además, el consumo de CPU disminuyó de 157 ms a 93 ms. 
Esto confirma que los índices columnares son altamente eficientes para cargas de trabajo de tipo analítico (OLAP), 
donde se procesan grandes volúmenes de datos y predominan operaciones de filtrado y agregación.
*/





