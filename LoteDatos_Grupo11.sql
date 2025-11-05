CREATE DATABASE FilmStream;
GO

USE FilmStream;
GO

-- LOTE DE DATOS

-- ==============================
-- DATOS PARA LA TABLA CONTINENTE
-- ==============================

INSERT INTO continente (nombre_continente) VALUES 
('América'),
('Europa'),
('Asia');


-- ==============================
-- DATOS PARA LA TABLA PAIS
-- ==============================

INSERT INTO pais (nombre_pais, id_continente) VALUES 
('Argentina', 1),
('Estados Unidos', 1),
('España', 2),
('Francia', 2),
('Japón', 3);


-- ==============================
-- DATOS PARA LA TABLA TIPO_CONTENIDO
-- ==============================

INSERT INTO tipo_contenido (id_tipo_contenido, nombre_contenido) VALUES
(1, 'Película'),
(2, 'Serie'),
(3, 'Documental');


-- ==============================
-- DATOS PARA LA TABLA GENERO
-- ==============================

INSERT INTO genero (nombre_genero) VALUES
('Acción'),
('Comedia'),
('Drama'),
('Ciencia Ficción'),
('Documental');


-- ==============================
-- DATOS PARA LA TABLA DIRECTOR
-- ==============================

INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais) VALUES
('Steven', 'Spielberg', '1946-12-18', 'Director estadounidense reconocido por Jurassic Park.', 2),
('Pedro', 'Almodóvar', '1949-09-25', 'Director español con estilo distintivo.', 3),
('Akira', 'Kurosawa', '1910-03-23', 'Legendario director japonés.', 5);


-- ==============================
-- DATOS PARA LA TABLA ACTOR
-- ==============================

INSERT INTO actor (nombre, apellido, año_nacimiento, biografia, id_pais) VALUES
('Tom', 'Hanks', '1956-07-09', 'Actor estadounidense ganador del Oscar.', 2),
('Natalie', 'Portman', '1981-06-09', 'Actriz estadounidense-israelí.', 2),
('Ricardo', 'Darín', '1957-01-16', 'Actor argentino muy reconocido.', 1),
('Jean', 'Reno', '1948-07-30', 'Actor francés de cine internacional.', 4),
('Toshiro', 'Mifune', '1920-04-01', 'Actor japonés legendario.', 5);


-- ==============================
-- DATOS PARA LA TABLA CONTENIDO
-- ==============================

INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido) VALUES
('Jurassic Park', 'Un parque de dinosaurios se sale de control.', 1993, 127, 1),
('El Secreto de sus Ojos', 'Un crimen y un amor perduran en el tiempo.', 2009, 129, 1),
('La Casa de Papel', 'Un grupo de ladrones ejecuta un gran golpe.', 2017, 50, 2),
('Planeta Tierra', 'Documental sobre la vida en la Tierra.', 2006, 90, 3);


-- ==============================
-- DATOS PARA LA TABLA DIRECTOR_CONTENIDO
-- ==============================

INSERT INTO director_contenido (id_director, id_contenido) VALUES
(1, 1),
(2, 2),
(3, 4);


-- ==============================
-- DATOS PARA LA TABLA GENERO_CONTENIDO
-- ==============================

INSERT INTO genero_contenido (id_genero, id_contenido) VALUES
(1, 1),
(3, 2),
(1, 3),
(5, 4);


-- ==============================
-- DATOS PARA LA TABLA REPARTO
-- ==============================

INSERT INTO reparto (es_protagonista, nombre_personaje, id_actor, id_contenido) VALUES
(1, 'Dr. Grant', 1, 1),
(1, 'Benjamín Espósito', 3, 2),
(0, 'Profesor', 4, 3),
(1, 'Narrador', 5, 4);


-- ==============================
-- DATOS PARA LA TABLA USUARIO
-- ==============================

INSERT INTO usuario (nombre, apellido, email, fecha_registro, id_pais) VALUES
('Bruno', 'Pérez', 'bruno.perez@gmail.com', '2024-03-01', 1),
('Nicolas', 'Fernandez', 'nicolas.fernandez@gmail.com', '2024-04-15', 3),
('Franco', 'Montecino', 'franco.montecino@gmail.com', '2024-02-20', 2);


-- ==============================
-- DATOS PARA LA TABLA PLANES
-- ==============================

INSERT INTO planes (nombre_plan, precio, cantidad_pantallas, resolucion_permitida) VALUES
('Básico', 5.99, 1, 720),
('Estándar', 9.99, 2, 1080),
('Premium', 14.99, 4, 2160);


-- ==============================
-- DATOS PARA LA TABLA SUSCRIPCION
-- ==============================

INSERT INTO suscripcion (fecha_inicio, fecha_fin, precio_pagado, id_usuario, id_plan) VALUES
('2024-03-01', '2024-06-01', 9.99, 1, 2),
('2024-04-15', NULL, 14.99, 2, 3),
('2024-02-20', '2024-08-20', 5.99, 3, 1);


-- ==============================
-- DATOS PARA LA TABLA RESEÑA
-- ==============================

INSERT INTO reseña (fecha_reseña, valoracion, id_contenido, id_usuario) VALUES
('2024-03-05', 5, 1, 1),
('2024-03-10', 4, 2, 2),
('2024-03-12', 5, 3, 3),
('2024-03-20', 4, 4, 1);


-- ==============================
-- DATOS PARA LA TABLA REPRODUCCION
-- ==============================

INSERT INTO reproduccion (fecha_reproduccion, progreso_minutos, id_contenido, id_usuario) VALUES
('2024-03-01', 45, 1, 1),
('2024-03-02', 127, 1, 1),
('2024-04-01', 20, 3, 2),
('2024-05-10', 60, 4, 3),
('2024-06-15', 90, 2, 1);


-- ==============================
-- DATOS PARA LA TABLA TEMPORADA
-- ==============================

INSERT INTO temporada ( id_temporada, nro_temporada, resumen, id_contenido) VALUES
(1, 1, 'Primera temporada del atraco.', 3),
(2, 2, 'Segunda temporada del atraco.', 3);


-- ==============================
-- DATOS PARA LA TABLA EPISODIO
-- ==============================

INSERT INTO episodio (id_episodio, titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
(1, 'El Comienzo', 1, 50, 'Inicio del atraco.', 1, 3),
(2, 'El Caos', 2, 55, 'Problemas dentro de la Fábrica.', 1, 3),
(3, 'El Final', 1, 60, 'Desenlace de la historia.', 2, 3);

-- ==============================
-- DATOS PARA LA TABLA PERFIL
-- ==============================

INSERT INTO perfil (nombre_perfil, restriccion, id_usuario) VALUES
('Bruno', 'Sin restricción', 1),
('Nicolas', 'Infantil', 2),
('Franco', 'Todo público', 3);

