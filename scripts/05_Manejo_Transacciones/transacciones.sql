USE filmstream_transaccion;
GO

/*
Tarea 1:
Escribir el código Transact SQL que permita definir una transacción consistente en: Insertar un registro en alguna tabla,
luego otro registro en otra tabla y por último la actualización de uno o más registros en otra tabla.
Actualizar los datos solamente si toda la operación es completada con éxito.
*/

BEGIN TRY
	
	BEGIN TRAN;

		-- Contenidos peliculas
		INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
		VALUES ('Inception','Un ladrón que roba secretos a través de los sueños.',2010,128,
		  (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Pelicula'),
		  (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'TV-MA')
		);

		INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
		VALUES ('Planeta Tierra','Documental sobre la naturaleza del planeta.',2006,60,
		  (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Documental'),
		  (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'G')
		);
		
		INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
        VALUES ('Stranger Things','Un niño desaparece en un pequeño pueblo.',2016,NULL,
          (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Serie'),
          (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'TV-14')
        );

		-- Contenido series: temporada
		INSERT INTO temporada (nro_temporada, resumen, fecha_lanzamiento, id_contenido)
		SELECT 1, 'Primera temporada.', '2016-07-15', c.id_contenido
		FROM contenido c WHERE c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		-- Verifica que se haya hecho la inserción, de no ser asi, hace rollback
		IF @@ROWCOUNT = 0
			THROW 50001, 'Error: No se pudo insertar temporada 1', 1;

		INSERT INTO temporada (nro_temporada, resumen, fecha_lanzamiento, id_contenido)
		SELECT 2, 'Segunda temporada.', '2017-10-27', c.id_contenido
		FROM contenido c WHERE c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;


		IF @@ROWCOUNT = 0
			THROW 50002, 'Error: No se pudo insertar temporada 2', 1;

		-- Contenido series: episodios T1
		INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
		SELECT 'Capítulo Uno: La desaparición de Will', 1, 47, 'El niño Will desaparece misteriosamente.', '2016-07-15', t.id_temporada
		FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
		WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 1;

		IF @@ROWCOUNT = 0
			THROW 50003, 'Error: No se pudo insertar episodio 1 temporada 1', 1;

		INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
		SELECT 'Capítulo Dos: La loca de la calle Maple', 2, 55, 'Aparecen pistas sobrenaturales.', '2016-07-15', t.id_temporada
		FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
		WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 1;

		IF @@ROWCOUNT = 0
			THROW 50004, 'Error: No se pudo insertar episodio 2 temporada 1', 1;

		-- Contenido series: episodios T2
		INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
		SELECT 'MADMAX', 1, 48, 'Un nuevo jugador llega al pueblo.', '2017-10-27', t.id_temporada
		FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
		WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 2;

		IF @@ROWCOUNT = 0
			THROW 50005, 'Error: No se pudo insertar episodio 1 temporada 2', 1;

		INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
		SELECT 'Trick or Treat, Freak', 2, 56, 'Halloween trae viejos temores.', '2017-10-27', t.id_temporada
		FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
		WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 2;

		IF @@ROWCOUNT = 0
			THROW 50006, 'Error: No se pudo insertar episodio 2 temporada 2', 1;

		-- Relacion Directores
		INSERT INTO director_contenido (id_director, id_contenido)
		SELECT d.id_director, c.id_contenido
		FROM director d CROSS JOIN contenido c
		WHERE d.nombre = 'Christopher' AND d.apellido = 'Nolan' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50007, 'Error: No se pudo insertar relación director Christopher Nolan', 1;

		INSERT INTO director_contenido (id_director, id_contenido)
		SELECT d.id_director, c.id_contenido
		FROM director d CROSS JOIN contenido c
		WHERE d.nombre = 'Matt' AND d.apellido = 'Duffer' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50008, 'Error: No se pudo insertar relación director Matt Duffer', 1;

		INSERT INTO director_contenido (id_director, id_contenido)
		SELECT d.id_director, c.id_contenido
		FROM director d CROSS JOIN contenido c
		WHERE d.nombre = 'Ross' AND d.apellido = 'Duffer' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50009, 'Error: No se pudo insertar relación director Ross Duffer', 1;

		INSERT INTO director_contenido (id_director, id_contenido)
		SELECT d.id_director, c.id_contenido
		FROM director d CROSS JOIN contenido c
		WHERE d.nombre = 'Juan' AND d.apellido = 'Perez' AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

		IF @@ROWCOUNT = 0
			THROW 50010, 'Error: No se pudo insertar relación director Juan Perez', 1;

		-- Géneros por contenido
		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Accion' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50011, 'Error: No se pudo insertar género Acción para Inception', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Ciencia Ficcion' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50012, 'Error: No se pudo insertar género Ciencia Ficcion para Inception', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Drama' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50013, 'Error: No se pudo insertar género Drama para Inception', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Fantasia' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50014, 'Error: No se pudo insertar género Fantasia para Stranger Things', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Terror' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50015, 'Error: No se pudo insertar género Terror para Stranger Things', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Drama' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50016, 'Error: No se pudo insertar género Drama para Stranger Things', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Documental' AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

		IF @@ROWCOUNT = 0
			THROW 50017, 'Error: No se pudo insertar género Documental para Planeta Tierra', 1;

		-- Reparto (actores por contenido)
		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Dom Cobb', 1, 1
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'Leonardo' AND a.apellido = 'DiCaprio'
		  AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50018, 'Error: No se pudo insertar reparto Leonardo DiCaprio para Inception', 1;

		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Joyce Byers', 1, 1
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'Winona' AND a.apellido = 'Ryder'
		  AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50019, 'Error: No se pudo insertar reparto Winona Ryder para Stranger Things', 1;

		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Eleven', 1, 2
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'Millie Bobby' AND a.apellido = 'Brown'
		  AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50020, 'Error: No se pudo insertar reparto Millie Bobby Brown para Stranger Things', 1;

		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Jim Hopper', 1, 3
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'David' AND a.apellido = 'Harbour'
		  AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50021, 'Error: No se pudo insertar reparto David Harbour para Stranger Things', 1;

		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Narrador', 1, 1
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'David' AND a.apellido = 'Attenborough'
		  AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

		IF @@ROWCOUNT = 0
			THROW 50022, 'Error: No se pudo insertar reparto David Attenborough para Planeta Tierra', 1;

	COMMIT TRAN;

END TRY

BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK;
	THROW;
END CATCH;

/*
Tarea 2:
Sobre el código escrito anteriormente provocar intencionalmente un error luego del insert y
verificar que los datos queden consistentes (No se debería realizar ningún insert). 
*/

BEGIN TRY
	
	BEGIN TRAN;

		-- Contenidos peliculas
		INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
		VALUES ('Inception','Un ladrón que roba secretos a través de los sueños.',2010,128,
		  (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Pelicula'),
		  (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'TV-MA')
		);

		INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
		VALUES ('Planeta Tierra','Documental sobre la naturaleza del planeta.',2006,60,
		  (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Documental'),
		  (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'G')
		);
		
		INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
        VALUES ('Stranger Things','Un niño desaparece en un pequeño pueblo.',2016,NULL,
          (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Serie'),
          (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'TV-14')
        );

		-- Contenido series: temporada
		INSERT INTO temporada (nro_temporada, resumen, fecha_lanzamiento, id_contenido)
		SELECT 1, 'Primera temporada.', '2016-07-15', c.id_contenido
		FROM contenido c WHERE c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		-- Verifica que se haya hecho la inserción, de no ser asi, hace rollback
		IF @@ROWCOUNT = 0
			THROW 50001, 'Error: No se pudo insertar temporada 1', 1;

		INSERT INTO temporada (nro_temporada, resumen, fecha_lanzamiento, id_contenido)
		SELECT 2, 'Segunda temporada.', '2017-10-27', c.id_contenido
		FROM contenido c WHERE c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;


		IF @@ROWCOUNT = 0
			THROW 50002, 'Error: No se pudo insertar temporada 2', 1;

		-- Contenido series: episodios T1
		INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
		SELECT 'Capítulo Uno: La desaparición de Will', 1, 47, 'El niño Will desaparece misteriosamente.', '2016-07-15', t.id_temporada
		FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
		WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 1;

		IF @@ROWCOUNT = 0
			THROW 50003, 'Error: No se pudo insertar episodio 1 temporada 1', 1;

		INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
		SELECT 'Capítulo Dos: La loca de la calle Maple', 2, 55, 'Aparecen pistas sobrenaturales.', '2016-07-15', t.id_temporada
		FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
		WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 1;

		IF @@ROWCOUNT = 0
			THROW 50004, 'Error: No se pudo insertar episodio 2 temporada 1', 1;

		-- Contenido series: episodios T2
		INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
		SELECT 'MADMAX', 1, 48, 'Un nuevo jugador llega al pueblo.', '2017-10-27', t.id_temporada
		FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
		WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 2;

		IF @@ROWCOUNT = 0
			THROW 50005, 'Error: No se pudo insertar episodio 1 temporada 2', 1;

		INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
		SELECT 'Trick or Treat, Freak', 2, 56, 'Halloween trae viejos temores.', '2017-10-27', t.id_temporada
		FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
		WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 2;

		IF @@ROWCOUNT = 0
			THROW 50006, 'Error: No se pudo insertar episodio 2 temporada 2', 1;

		-- Relacion Directores
		INSERT INTO director_contenido (id_director, id_contenido)
		SELECT d.id_director, c.id_contenido
		FROM director d CROSS JOIN contenido c
		WHERE d.nombre = 'Christopher' AND d.apellido = 'Nolan' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50007, 'Error: No se pudo insertar relación director Christopher Nolan', 1;

		INSERT INTO director_contenido (id_director, id_contenido)
		SELECT d.id_director, c.id_contenido
		FROM director d CROSS JOIN contenido c
		WHERE d.nombre = 'Matt' AND d.apellido = 'Duffer' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50008, 'Error: No se pudo insertar relación director Matt Duffer', 1;

		INSERT INTO director_contenido (id_director, id_contenido)
		SELECT d.id_director, c.id_contenido
		FROM director d CROSS JOIN contenido c
		WHERE d.nombre = 'Ross' AND d.apellido = 'Duffer' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50009, 'Error: No se pudo insertar relación director Ross Duffer', 1;

		INSERT INTO director_contenido (id_director, id_contenido)
		SELECT d.id_director, c.id_contenido
		FROM director d CROSS JOIN contenido c
		WHERE d.nombre = 'Juan' AND d.apellido = 'Perez' AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

		IF @@ROWCOUNT = 0
			THROW 50010, 'Error: No se pudo insertar relación director Juan Perez', 1;

		-- Géneros por contenido
		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Accion' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50011, 'Error: No se pudo insertar género Acción para Inception', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Ciencia Ficcion' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50012, 'Error: No se pudo insertar género Ciencia Ficcion para Inception', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Drama' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50013, 'Error: No se pudo insertar género Drama para Inception', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Fantasia' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50014, 'Error: No se pudo insertar género Fantasia para Stranger Things', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Terror' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50015, 'Error: No se pudo insertar género Terror para Stranger Things', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Drama' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50016, 'Error: No se pudo insertar género Drama para Stranger Things', 1;

		INSERT INTO genero_contenido (id_genero, id_contenido)
		SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
		WHERE g.nombre_genero = 'Documental' AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

		IF @@ROWCOUNT = 0
			THROW 50017, 'Error: No se pudo insertar género Documental para Planeta Tierra', 1;

		-- Reparto (actores por contenido)
		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Dom Cobb', 1, 1
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'Leonardo' AND a.apellido = 'DiCaprio'
		  AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

		IF @@ROWCOUNT = 0
			THROW 50018, 'Error: No se pudo insertar reparto Leonardo DiCaprio para Inception', 1;

		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Joyce Byers', 1, 1
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'Winona' AND a.apellido = 'Ryder'
		  AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50019, 'Error: No se pudo insertar reparto Winona Ryder para Stranger Things', 1;

		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Eleven', 1, 2
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'Millie Bobby' AND a.apellido = 'Brown'
		  AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50020, 'Error: No se pudo insertar reparto Millie Bobby Brown para Stranger Things', 1;

		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Jim Hopper', 1, 3
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'David' AND a.apellido = 'Harbour'
		  AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

		IF @@ROWCOUNT = 0
			THROW 50021, 'Error: No se pudo insertar reparto David Harbour para Stranger Things', 1;

		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Narrador', 1, 1
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'David' AND a.apellido = 'Attenborough'
		  AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

		IF @@ROWCOUNT = 0
			THROW 50022, 'Error: No se pudo insertar reparto David Attenborough para Planeta Tierra', 1;

		--Se provoca un error intentando insertar un registro con primary key compuesta ya existente
		INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
		SELECT a.id_actor, c.id_contenido, 'Narrador', 1, 1
		FROM actor a CROSS JOIN contenido c
		WHERE a.nombre = 'David' AND a.apellido = 'Attenborough'
		  AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

	COMMIT TRAN;

END TRY

BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK;
	THROW;
END CATCH;

/*
Tarea 3:
Expresar las conclusiones en base a las pruebas realizadas.
*/

/*
Las transacciones son herramientas muy útiles para modificar datos en la base 
cuando se requiere que sean tratados de forma consistente y en el caso de que 
algo falle, volver al punto de partida o donde quiera el usuario.
*/
