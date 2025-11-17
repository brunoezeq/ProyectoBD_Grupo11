USE FilmStream;

/*
Tarea 1:
Escribir el código Transact SQL que permita definir una transacción consistente en: Insertar un registro en alguna tabla,
luego otro registro en otra tabla y por último la actualización de uno o más registros en otra tabla.
Actualizar los datos solamente si toda la operación es completada con éxito.
*/

BEGIN TRY
	
	BEGIN TRAN;
		INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido) VALUES
		('Jurassic Park', 'Un parque de dinosaurios se sale de control.', 1993, 127, 1),
		('El Secreto de sus Ojos', 'Un crimen y un amor perduran en el tiempo.', 2009, 129, 1),
		('La Casa de Papel', 'Un grupo de ladrones ejecuta un gran golpe.', 2017, 50, 2),
		('Planeta Tierra', 'Documental sobre la vida en la Tierra.', 2006, 90, 3);

		INSERT INTO director_contenido (id_director, id_contenido) VALUES
		(1, 1),
		(2, 2),
		(3, 4);

		INSERT INTO genero_contenido (id_genero, id_contenido) VALUES
		(1, 1),
		(3, 2),
		(1, 3),
		(5, 4);

		INSERT INTO reparto (es_protagonista, nombre_personaje, id_actor, id_contenido) VALUES
		(1, 'Dr. Grant', 1, 1),
		(1, 'Benjamín Espósito', 3, 2),
		(0, 'Profesor', 4, 3),
		(1, 'Narrador', 5, 4);

		INSERT INTO temporada ( id_temporada, nro_temporada, resumen, id_contenido) VALUES
		(1, 1, 'Primera temporada del atraco.', 3),
		(2, 2, 'Segunda temporada del atraco.', 3);

		INSERT INTO episodio (id_episodio, titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
		(1, 'El Comienzo', 1, 50, 'Inicio del atraco.', 1, 3),
		(2, 'El Caos', 2, 55, 'Problemas dentro de la Fábrica.', 1, 3),
		(3, 'El Final', 1, 60, 'Desenlace de la historia.', 2, 3);

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
		INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido) VALUES
		('Jurassic Park', 'Un parque de dinosaurios se sale de control.', 1993, 127, 1),
		('El Secreto de sus Ojos', 'Un crimen y un amor perduran en el tiempo.', 2009, 129, 1),
		('La Casa de Papel', 'Un grupo de ladrones ejecuta un gran golpe.', 2017, 50, 2),
		('Planeta Tierra', 'Documental sobre la vida en la Tierra.', 2006, 90, 3);

		INSERT INTO director_contenido (id_director, id_contenido) VALUES
		(1, 1),
		(2, 2),
		(3, 4);

		INSERT INTO genero_contenido (id_genero, id_contenido) VALUES
		(1, 1),
		(3, 2),
		(1, 3),
		(5, 4);

		INSERT INTO reparto (es_protagonista, nombre_personaje, id_actor, id_contenido) VALUES
		(1, 'Dr. Grant', 1, 1),
		(1, 'Benjamín Espósito', 3, 2),
		(0, 'Profesor', 4, 3),
		(1, 'Narrador', 5, 4);

		INSERT INTO temporada ( id_temporada, nro_temporada, resumen, id_contenido) VALUES
		(1, 1, 'Primera temporada del atraco.', 3),
		(2, 2, 'Segunda temporada del atraco.', 3);

		INSERT INTO episodio (id_episodio, titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
		(1, 'El Comienzo', 1, 50, 'Inicio del atraco.', 1, 3),
		(2, 'El Caos', 2, 55, 'Problemas dentro de la Fábrica.', 1, 3),
		(3, 'El Final', 1, 60, 'Desenlace de la historia.', 2, 3),

		--Se provoca un error intentando insertar un registro con id ya existente
		(3, 'El Final', 1, 60, 'Desenlace de la historia.', 2, 3);

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
