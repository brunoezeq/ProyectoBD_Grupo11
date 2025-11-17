## Índices columnares 

Los índices columnares se tratan de un tipo de índice especializado introducido por Microsoft SQL Server con el objetivo de optimizar el rendimiento de consultas analíticas sobre grandes volúmenes de datos.
A diferencia de los índices tradicionales, los cuales almacenas la información por filas (rowstore), los índices columnares almacenan los datos por columnas, lo cual permite niveles de compresión muy altos y mayor eficiencia en las lecturas.

Este tipo de índices es apropiado para cargas de trabajo analíticas como por ejemplo, reportes, dashboards, consultas que recorren millones de registros, agrupaciones y análisis de pratrones. Su tecnología también es clave para entornos de Big Data, Data Warehousing y sistemas con altos volumen de datos históricos.

Entre los tipos de índices columnares se encuentran:

  - Clustered Columnstore Index: remplaza el almacenamiento original de la          tabla. Máxima comprensión y rendimiento analítico.
  - Nonclustered Columnstore Index: es agregado como índice adicional. Ideal para   bases OLPT con algunos reportes.
    
Ventajas y Desventajas de los Índices columnares:

- Ventajas:
    - Alta compresión de datos.
    - Menos I/O.
    - Batch Execution Mode.
    - Excelente rendimiento en consultas analíticas.

- Desventajas:
    - No recomendado para tablas con muchos INSERT/UPDATE.
    - Las filas no se almacenan completas.
    - No reemplaza los índices tradicionales.
