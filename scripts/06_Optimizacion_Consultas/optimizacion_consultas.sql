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

USE filmstream;
GO

-- ====================================
-- 1. CARGA MASIVA DE DATOS
-- ====================================

TRUNCATE TABLE reproduccion;
TRUNCATE TABLE reproduccion;

DECLARE @i INT = 1;
DECLARE @max INT = 1000000;

WHILE @i <= @max
BEGIN
    INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 3) + 1,         -- perfiles válidos: 1, 2, 3
        (ABS(CHECKSUM(NEWID())) % 3) + 1,         -- contenidos válidos: 1, 2, 3
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 730, '2023-01-01'), -- fecha entre 2023-2025
        ABS(CHECKSUM(NEWID())) % 120,             -- minutos vistos
        ABS(CHECKSUM(NEWID())) % 2                -- completado (0/1)
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

(124940 rows affected)
Table 'reproduccion'. Scan count 1, logical reads 4714, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 204 ms,  elapsed time = 2012 ms.
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

SELECT 
    id_reproduccion, id_perfil, id_contenido, fecha_reproduccion, progreso_minutos
FROM 
    reproduccion
WHERE 
    fecha_reproduccion BETWEEN '2024-01-01' AND '2024-03-31';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

/*	Plan de ejecucion y tiempos de respuesta:

(124940 rows affected)
Table 'reproduccion'. Scan count 1, logical reads 716, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 31 ms,  elapsed time = 1774 ms.
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
ON reproduccion (fecha_reproduccion, id_perfil, id_contenido, progreso_minutos);

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT 
    id_reproduccion, id_perfil, id_contenido, fecha_reproduccion, progreso_minutos
FROM 
    reproduccion
WHERE 
    fecha_reproduccion BETWEEN '2024-01-01' AND '2024-03-31';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

DROP INDEX idx_reproduccion_fecha_incluye ON reproduccion; 

/*	Plan de ejecucion y tiempos de respuesta:

(124940 rows affected)
Table 'reproduccion'. Scan count 1, logical reads 649, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 78 ms,  elapsed time = 2151 ms.

*/


-- ====================================
-- 6. CONCLUSIONES 
-- ====================================

/*
Una vez desarrolladas todas las mediciones de rendimiento aplicando busquedas sin indices, con indices agrupados y  con indice agrupado incluyendo las demas columnas 
podemos concluir que:
	
	1. Sin índice: al no poseer ningun índice SQL Server debió realizar un escaneo completo (full table scan) dando como resultado:	
		
		- Lecturas lógicas: 4714
		- CPU: ~157–219 ms
		- Tiempo total: ~1600–1800 ms

	La ausencia de índices obliga al motor a leer todas las páginas de la tabla, generando un alto volumen de I/O lógico. 
	Este caso representa el peor escenario en términos de eficiencia.

	2. Con índice agrupado: se definió un índice agrupado sobre fecha_reproduccion, obligando físicamente a la tabla a ordenarse por esta columna. Dando como resultado;

		- Lecturas lógicas: 716
		- CPU: 31 ms
		- Tiempo total: ~1774 ms

	El número de lecturas disminuyó significativamente (4714 → 716), mostrando que SQL Server pudo navegar directamente hacia el rango de fechas usando la estructura del 
	índice.
	El tiempo total de ejecución se mantuvo estable, ya que factores externos como caché, disco o concurrencia influyen en esta métrica. 
	Sin embargo, la mejora en CPU y lecturas es clara y consistente.

	3. Con índice agrupado + columnas: se probó un índice agrupado definiendo varias columnas dentro de la clave del índice. Dando como resultado: 

		- Lecturas lógicas: 649
		- CPU: 78 ms
		- Tiempo total: ~2000–2150 ms

	Al ampliar la clave del índice, se logró una pequeña reducción en el volumen de lecturas (716 → 649). Sin embargo, el índice se vuelve más pesado y complejo, 
	resultando en un mayor consumo de CPU y un incremento del tiempo total. 
	Este tipo de índice solo es recomendable cuando existe una fuerte necesidad de ordenar o cubrir múltiples columnas simultáneamente.

En conclusión, el uso de índices adecuados mejora notablemente el rendimiento de las consultas, especialmente cuando se aplican sobre columnas que se usan 
frecuentemente en filtros o cláusulas WHERE y cuando se incluyen las columnas más consultadas en el índice.
*/