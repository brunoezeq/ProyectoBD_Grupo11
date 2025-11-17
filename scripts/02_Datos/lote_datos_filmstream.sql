use filmstream
-- =============================================
-- LOTE DE DATOS DE PRUEBA 
-- Propósito: Cargar un conjunto coherente de datos para probar todas las funcionalidades y relaciones.
-- =============================================

-- ----- Tipos de Contenido -----
INSERT INTO tipo_contenido (nombre_contenido) VALUES
  ('Pelicula'),
  ('Serie'),
  ('Documental');

INSERT INTO clasificacion (codigo, descripcion, edad_minima) VALUES
  ('G', 'Apta para todo público', 0),
  ('PG', 'Sugiere la guía paterna', 10),
  ('PG-13', 'Guía paterna estricta para menores de 13', 13),
  ('R', 'Restringida para menores de 16', 16),
  ('TV-MA', 'Solo adultos', 18);

-- ----- Geografía -----
INSERT INTO continente (nombre_continente) VALUES ('America'), ('Europa');

INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Estados Unidos', c.id_continente FROM continente c WHERE c.nombre_continente = 'America';

INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Argentina', c.id_continente FROM continente c WHERE c.nombre_continente = 'America';

INSERT INTO pais (nombre_pais, id_continente)
SELECT 'España', c.id_continente FROM continente c WHERE c.nombre_continente = 'Europa';

INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Reino Unido', c.id_continente FROM continente c WHERE c.nombre_continente = 'Europa';

-- ----- Personas (Directores y Actores) -----
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Christopher', 'Nolan', '1970-07-30', 'Director y guionista británico-estadounidense.', p.id_pais
FROM pais p WHERE p.nombre_pais = 'Reino Unido';

INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Matt', 'Duffer', '1984-02-15', 'Cocreador de Stranger Things.', p.id_pais
FROM pais p WHERE p.nombre_pais = 'Estados Unidos';

INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Ross', 'Duffer', '1984-02-15', 'Cocreador de Stranger Things.', p.id_pais
FROM pais p WHERE p.nombre_pais = 'Estados Unidos';

INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Juan', 'Perez', '1980-05-05', 'Director de documentales.', p.id_pais
FROM pais p WHERE p.nombre_pais = 'Argentina';

INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Leonardo', 'DiCaprio', '1974-11-11', 'Actor estadounidense.', p.id_pais
FROM pais p WHERE p.nombre_pais = 'Estados Unidos';

INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Winona', 'Ryder', '1971-10-29', 'Actriz estadounidense.', p.id_pais
FROM pais p WHERE p.nombre_pais = 'Estados Unidos';

INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Millie Bobby', 'Brown', '2004-02-19', 'Actriz británica.', p.id_pais
FROM pais p WHERE p.nombre_pais = 'Reino Unido';

INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'David', 'Harbour', '1975-04-10', 'Actor estadounidense.', p.id_pais
FROM pais p WHERE p.nombre_pais = 'Estados Unidos';

INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'David', 'Attenborough', '1926-05-08', 'Narrador y naturalista.', p.id_pais
FROM pais p WHERE p.nombre_pais = 'Reino Unido';

-- ----- Géneros -----
INSERT INTO genero (nombre_genero) VALUES
  ('Accion'), ('Drama'), ('Ciencia Ficcion'), ('Fantasia'), ('Documental'), ('Terror');

-- Variables necesarias para sección de películas
DECLARE @id_tipo_pelicula INT = (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Pelicula');
DECLARE @id_gen_accion INT = (SELECT id_genero FROM genero WHERE nombre_genero = 'Accion');
DECLARE @id_gen_drama INT = (SELECT id_genero FROM genero WHERE nombre_genero = 'Drama');
DECLARE @id_gen_cf INT = (SELECT id_genero FROM genero WHERE nombre_genero = 'Ciencia Ficcion');
DECLARE @id_gen_fantasia INT = (SELECT id_genero FROM genero WHERE nombre_genero = 'Fantasia');
DECLARE @id_gen_doc INT = (SELECT id_genero FROM genero WHERE nombre_genero = 'Documental');
DECLARE @id_gen_terror INT = (SELECT id_genero FROM genero WHERE nombre_genero = 'Terror');
DECLARE @id_cls_pg INT = (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'PG');
DECLARE @id_cls_pg13 INT = (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'PG-13');
DECLARE @id_cls_r INT = (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'R');
DECLARE @id_cls_g INT = (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'G');

-- ----- Contenidos -----
INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
VALUES (
  'Inception',
  'Un ladrón que roba secretos a través de los sueños.',
  2010,
  128,
  (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Pelicula'),
  (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'TV-MA')
);

INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
VALUES (
  'Planeta Tierra',
  'Documental sobre la naturaleza del planeta.',
  2006,
  60,
  (SELECT id_tipo_contenido FROM tipo_contenido WHERE nombre_contenido = 'Documental'),
  (SELECT id_clasificacion FROM clasificacion WHERE codigo = 'G')
);

-- ----- Series: Temporadas y Episodios (para Stranger Things) -----
INSERT INTO temporada (nro_temporada, resumen, fecha_lanzamiento, id_contenido)
SELECT 1, 'Primera temporada.', '2016-07-15', c.id_contenido
FROM contenido c WHERE c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

INSERT INTO temporada (nro_temporada, resumen, fecha_lanzamiento, id_contenido)
SELECT 2, 'Segunda temporada.', '2017-10-27', c.id_contenido
FROM contenido c WHERE c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

-- Episodios T1
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
SELECT 'Capítulo Uno: La desaparición de Will', 1, 47, 'El niño Will desaparece misteriosamente.', '2016-07-15', t.id_temporada
FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 1;

INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
SELECT 'Capítulo Dos: La loca de la calle Maple', 2, 55, 'Aparecen pistas sobrenaturales.', '2016-07-15', t.id_temporada
FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 1;

-- Episodios T2
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
SELECT 'MADMAX', 1, 48, 'Un nuevo jugador llega al pueblo.', '2017-10-27', t.id_temporada
FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 2;

INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, fecha_lanzamiento, id_temporada)
SELECT 'Trick or Treat, Freak', 2, 56, 'Halloween trae viejos temores.', '2017-10-27', t.id_temporada
FROM temporada t JOIN contenido c ON c.id_contenido = t.id_contenido
WHERE c.titulo = 'Stranger Things' AND t.nro_temporada = 2;

-- ----- Relaciones puente -----
-- Directores
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director, c.id_contenido
FROM director d CROSS JOIN contenido c
WHERE d.nombre = 'Christopher' AND d.apellido = 'Nolan' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director, c.id_contenido
FROM director d CROSS JOIN contenido c
WHERE d.nombre = 'Matt' AND d.apellido = 'Duffer' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director, c.id_contenido
FROM director d CROSS JOIN contenido c
WHERE d.nombre = 'Ross' AND d.apellido = 'Duffer' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director, c.id_contenido
FROM director d CROSS JOIN contenido c
WHERE d.nombre = 'Juan' AND d.apellido = 'Perez' AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

-- Géneros por contenido
INSERT INTO genero_contenido (id_genero, id_contenido)
SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
WHERE g.nombre_genero = 'Accion' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

INSERT INTO genero_contenido (id_genero, id_contenido)
SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
WHERE g.nombre_genero = 'Ciencia Ficcion' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

INSERT INTO genero_contenido (id_genero, id_contenido)
SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
WHERE g.nombre_genero = 'Drama' AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

INSERT INTO genero_contenido (id_genero, id_contenido)
SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
WHERE g.nombre_genero = 'Fantasia' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

INSERT INTO genero_contenido (id_genero, id_contenido)
SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
WHERE g.nombre_genero = 'Terror' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

INSERT INTO genero_contenido (id_genero, id_contenido)
SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
WHERE g.nombre_genero = 'Drama' AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

INSERT INTO genero_contenido (id_genero, id_contenido)
SELECT g.id_genero, c.id_contenido FROM genero g CROSS JOIN contenido c
WHERE g.nombre_genero = 'Documental' AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

-- Reparto (actores por contenido)
INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
SELECT a.id_actor, c.id_contenido, 'Dom Cobb', 1, 1
FROM actor a CROSS JOIN contenido c
WHERE a.nombre = 'Leonardo' AND a.apellido = 'DiCaprio'
  AND c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010;

INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
SELECT a.id_actor, c.id_contenido, 'Joyce Byers', 1, 1
FROM actor a CROSS JOIN contenido c
WHERE a.nombre = 'Winona' AND a.apellido = 'Ryder'
  AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
SELECT a.id_actor, c.id_contenido, 'Eleven', 1, 2
FROM actor a CROSS JOIN contenido c
WHERE a.nombre = 'Millie Bobby' AND a.apellido = 'Brown'
  AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
SELECT a.id_actor, c.id_contenido, 'Jim Hopper', 1, 3
FROM actor a CROSS JOIN contenido c
WHERE a.nombre = 'David' AND a.apellido = 'Harbour'
  AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016;

INSERT INTO reparto (id_actor, id_contenido, nombre_personaje, es_protagonista, orden_creditos)
SELECT a.id_actor, c.id_contenido, 'Narrador', 1, 1
FROM actor a CROSS JOIN contenido c
WHERE a.nombre = 'David' AND a.apellido = 'Attenborough'
  AND c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006;

-- ----- Usuarios y Perfiles -----
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Franco', 'Monte', 'fran@gmail.com', 'hash_fran123', '2003-03-20', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Argentina';

INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Ana', 'Garcia', 'ana@example.com', 'hash_ana', '2000-06-10', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'España';

-- Perfiles de Franco
INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Fran', 0, NULL, u.id_usuario FROM usuario u WHERE u.email = 'fran@gmail.com';

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Niños', 1, c.id_clasificacion, u.id_usuario
FROM usuario u CROSS JOIN clasificacion c
WHERE u.email = 'fran@gmail.com' AND c.codigo = 'PG-13';

-- Perfil de Ana
INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Ana', 0, NULL, u.id_usuario FROM usuario u WHERE u.email = 'ana@example.com';

-- ----- Planes y Suscripciones -----
INSERT INTO planes (nombre_plan, descripcion, precio, cantidad_pantallas, resolucion_permitida, activo)
VALUES
  ('Basico', 'Plan básico', 5.99, 1, '720p', 1),
  ('Estandar', 'Plan estándar', 9.99, 2, '1080p', 1),
  ('Premium', 'Plan premium', 14.99, 4, '2160p', 1);

-- Suscripción activa de Franco (Estandar), fecha_fin NULL por estado 'Activa'
INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 9.99, 'Tarjeta', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email = 'fran@gmail.com' AND p.nombre_plan = 'Estandar';

-- Suscripción cancelada de Ana (Basico), requiere fecha_fin NOT NULL
INSERT INTO suscripcion (id_usuario, id_plan, fecha_inicio, fecha_fin, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, '2024-01-01', '2024-12-31', 5.99, 'Tarjeta', 'Cancelada'
FROM usuario u CROSS JOIN planes p
WHERE u.email = 'ana@example.com' AND p.nombre_plan = 'Basico';

-- Auditoría: Ana cambió de Basico a Estandar
INSERT INTO auditoria_suscripcion (id_usuario, id_plan_anterior, id_plan_nuevo, fecha_cambio, motivo)
SELECT u.id_usuario,
       p_old.id_plan,
       p_new.id_plan,
       '2025-01-15',
       'Upgrade de plan por mayor calidad'
FROM usuario u
JOIN planes p_old ON p_old.nombre_plan = 'Basico'
JOIN planes p_new ON p_new.nombre_plan = 'Estandar'
WHERE u.email = 'ana@example.com';

-- ----- Reproducciones -----

-- Fran viendo Inception (contenido, no episodio)
INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, GETDATE(), 30, 0
FROM perfil pf JOIN usuario u ON u.id_usuario = pf.id_usuario
JOIN contenido c ON c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010
WHERE u.email = 'fran@gmail.com' AND pf.nombre_perfil = 'Fran';

-- Fran (perfil Niños) viendo Planeta Tierra
INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, GETDATE(), 10, 0
FROM perfil pf JOIN usuario u ON u.id_usuario = pf.id_usuario
JOIN contenido c ON c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006
WHERE u.email = 'fran@gmail.com' AND pf.nombre_perfil = 'Niños';

-- Ana viendo Stranger Things (episodio T1E1)
INSERT INTO reproduccion (id_perfil, id_episodio, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, e.id_episodio, GETDATE(), 20, 0
FROM perfil pf
JOIN usuario u ON u.id_usuario = pf.id_usuario
JOIN episodio e ON e.nro_episodio = 1
JOIN temporada t ON t.id_temporada = e.id_temporada AND t.nro_temporada = 1
JOIN contenido c ON c.id_contenido = t.id_contenido AND c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016
WHERE u.email = 'ana@example.com' AND pf.nombre_perfil = 'Ana';

-- ----- Reseñas -----
INSERT INTO [reseña] (id_usuario, id_contenido, valoracion, comentario)
SELECT u.id_usuario, c.id_contenido, 9, 'Excelente película de ciencia ficción.'
FROM usuario u JOIN contenido c ON c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010
WHERE u.email = 'fran@gmail.com';

INSERT INTO [reseña] (id_usuario, id_contenido, valoracion, comentario)
SELECT u.id_usuario, c.id_contenido, 8, 'Muy entretenida y nostálgica.'
FROM usuario u JOIN contenido c ON c.titulo = 'Stranger Things' AND c.[año_lanzamiento] = 2016
WHERE u.email = 'ana@example.com';

-- ----- Lista de contenido (watchlist) -----
INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON u.id_usuario = pf.id_usuario
JOIN contenido c ON c.titulo = 'Planeta Tierra' AND c.[año_lanzamiento] = 2006
WHERE u.email = 'fran@gmail.com' AND pf.nombre_perfil = 'Niños';

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON u.id_usuario = pf.id_usuario
JOIN contenido c ON c.titulo = 'Inception' AND c.[año_lanzamiento] = 2010
WHERE u.email = 'ana@example.com' AND pf.nombre_perfil = 'Ana';

-- =============================================================
-- DIRECTORES (3 PELICULAS C/U) Y RELACIONADOS
-- =============================================================

-- Continentes adicionales (idempotentes)
INSERT INTO continente (nombre_continente)
SELECT 'Asia' WHERE NOT EXISTS (SELECT 1 FROM continente WHERE nombre_continente = 'Asia');
INSERT INTO continente (nombre_continente)
SELECT 'Oceania' WHERE NOT EXISTS (SELECT 1 FROM continente WHERE nombre_continente = 'Oceania');
INSERT INTO continente (nombre_continente)
SELECT 'Africa' WHERE NOT EXISTS (SELECT 1 FROM continente WHERE nombre_continente = 'Africa');

-- Países necesarios (idempotentes)
-- America
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'México', c.id_continente FROM continente c
WHERE c.nombre_continente = 'America' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'México');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Canadá', c.id_continente FROM continente c
WHERE c.nombre_continente = 'America' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Canadá');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Brasil', c.id_continente FROM continente c
WHERE c.nombre_continente = 'America' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Brasil');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Chile', c.id_continente FROM continente c
WHERE c.nombre_continente = 'America' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Chile');

-- Europa
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Francia', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Francia');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Dinamarca', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Dinamarca');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Italia', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Italia');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Alemania', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Alemania');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Suecia', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Suecia');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Rusia', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Rusia');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Polonia', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Polonia');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Países Bajos', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Países Bajos');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Rumania', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Rumania');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Grecia', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Grecia');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Bélgica', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Bélgica');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Portugal', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Portugal');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Irlanda', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Irlanda');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'República Checa', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'República Checa');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Austria', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Europa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Austria');

-- Asia
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Corea del Sur', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Asia' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Corea del Sur');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Japón', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Asia' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Japón');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'China', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Asia' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'China');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Taiwán', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Asia' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Taiwán');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Hong Kong', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Asia' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Hong Kong');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'India', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Asia' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'India');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Irán', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Asia' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Irán');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Turquía', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Asia' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Turquía');

-- Oceania
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Nueva Zelanda', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Oceania' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Nueva Zelanda');
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Australia', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Oceania' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Australia');

-- Africa
INSERT INTO pais (nombre_pais, id_continente)
SELECT 'Sudáfrica', c.id_continente FROM continente c
WHERE c.nombre_continente = 'Africa' AND NOT EXISTS (SELECT 1 FROM pais WHERE nombre_pais = 'Sudáfrica');

-- =====================
-- Directores
-- =====================

-- USA-based
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Steven','Spielberg','1946-12-18','Director estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Steven' AND d.apellido='Spielberg' AND d.fecha_nacimiento='1946-12-18' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Martin','Scorsese','1942-11-17','Director estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Martin' AND d.apellido='Scorsese' AND d.fecha_nacimiento='1942-11-17' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Quentin','Tarantino','1963-03-27','Director estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Quentin' AND d.apellido='Tarantino' AND d.fecha_nacimiento='1963-03-27' AND d.id_pais=p.id_pais
);

-- Reino Unido / Canadá / México / España / etc.
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Ridley','Scott','1937-11-30','Director británico.', p.id_pais FROM pais p
WHERE p.nombre_pais='Reino Unido' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Ridley' AND d.apellido='Scott' AND d.fecha_nacimiento='1937-11-30' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'James','Cameron','1954-08-16','Director canadiense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Canadá' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='James' AND d.apellido='Cameron' AND d.fecha_nacimiento='1954-08-16' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Denis','Villeneuve','1967-10-03','Director canadiense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Canadá' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Denis' AND d.apellido='Villeneuve' AND d.fecha_nacimiento='1967-10-03' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Guillermo','del Toro','1964-10-09','Director mexicano.', p.id_pais FROM pais p
WHERE p.nombre_pais='México' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Guillermo' AND d.apellido='del Toro' AND d.fecha_nacimiento='1964-10-09' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Alfonso','Cuarón','1961-11-28','Director mexicano.', p.id_pais FROM pais p
WHERE p.nombre_pais='México' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Alfonso' AND d.apellido='Cuarón' AND d.fecha_nacimiento='1961-11-28' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Alejandro','González Iñárritu','1963-08-15','Director mexicano.', p.id_pais FROM pais p
WHERE p.nombre_pais='México' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Alejandro' AND d.apellido='González Iñárritu' AND d.fecha_nacimiento='1963-08-15' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Pedro','Almodóvar','1949-09-25','Director español.', p.id_pais FROM pais p
WHERE p.nombre_pais='España' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Pedro' AND d.apellido='Almodóvar' AND d.fecha_nacimiento='1949-09-25' AND d.id_pais=p.id_pais
);

-- Asia (Corea, Japón, China, Taiwán, Hong Kong)
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Bong','Joon-ho','1969-09-14','Director surcoreano.', p.id_pais FROM pais p
WHERE p.nombre_pais='Corea del Sur' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Bong' AND d.apellido='Joon-ho' AND d.fecha_nacimiento='1969-09-14' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Park','Chan-wook','1963-08-23','Director surcoreano.', p.id_pais FROM pais p
WHERE p.nombre_pais='Corea del Sur' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Park' AND d.apellido='Chan-wook' AND d.fecha_nacimiento='1963-08-23' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Hayao','Miyazaki','1941-01-05','Director japonés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Japón' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Hayao' AND d.apellido='Miyazaki' AND d.fecha_nacimiento='1941-01-05' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Akira','Kurosawa','1910-03-23','Director japonés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Japón' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Akira' AND d.apellido='Kurosawa' AND d.fecha_nacimiento='1910-03-23' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Zhang','Yimou','1951-11-14','Director chino.', p.id_pais FROM pais p
WHERE p.nombre_pais='China' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Zhang' AND d.apellido='Yimou' AND d.fecha_nacimiento='1951-11-14' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Ang','Lee','1954-10-23','Director taiwanés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Taiwán' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Ang' AND d.apellido='Lee' AND d.fecha_nacimiento='1954-10-23' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Wong','Kar-wai','1958-07-17','Director de Hong Kong.', p.id_pais FROM pais p
WHERE p.nombre_pais='Hong Kong' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Wong' AND d.apellido='Kar-wai' AND d.fecha_nacimiento='1958-07-17' AND d.id_pais=p.id_pais
);

-- Europa (Francia, Dinamarca, Italia)
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Luc','Besson','1959-03-18','Director francés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Francia' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Luc' AND d.apellido='Besson' AND d.fecha_nacimiento='1959-03-18' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Jean-Pierre','Jeunet','1953-09-03','Director francés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Francia' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Jean-Pierre' AND d.apellido='Jeunet' AND d.fecha_nacimiento='1953-09-03' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Lars','von Trier','1956-04-30','Director danés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Dinamarca' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Lars' AND d.apellido='von Trier' AND d.fecha_nacimiento='1956-04-30' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Thomas','Vinterberg','1969-05-19','Director danés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Dinamarca' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Thomas' AND d.apellido='Vinterberg' AND d.fecha_nacimiento='1969-05-19' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Paolo','Sorrentino','1970-05-31','Director italiano.', p.id_pais FROM pais p
WHERE p.nombre_pais='Italia' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Paolo' AND d.apellido='Sorrentino' AND d.fecha_nacimiento='1970-05-31' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Sergio','Leone','1929-01-03','Director italiano.', p.id_pais FROM pais p
WHERE p.nombre_pais='Italia' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Sergio' AND d.apellido='Leone' AND d.fecha_nacimiento='1929-01-03' AND d.id_pais=p.id_pais
);

-- Oceania (Nueva Zelanda, Australia)
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Peter','Jackson','1961-10-31','Director neozelandés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Nueva Zelanda' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Peter' AND d.apellido='Jackson' AND d.fecha_nacimiento='1961-10-31' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Taika','Waititi','1975-08-16','Director neozelandés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Nueva Zelanda' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Taika' AND d.apellido='Waititi' AND d.fecha_nacimiento='1975-08-16' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'George','Miller','1945-03-03','Director australiano.', p.id_pais FROM pais p
WHERE p.nombre_pais='Australia' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='George' AND d.apellido='Miller' AND d.fecha_nacimiento='1945-03-03' AND d.id_pais=p.id_pais
);

-- Europa (Alemania, Suecia, Rusia)
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Werner','Herzog','1942-09-05','Director alemán.', p.id_pais FROM pais p
WHERE p.nombre_pais='Alemania' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Werner' AND d.apellido='Herzog' AND d.fecha_nacimiento='1942-09-05' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Ingmar','Bergman','1918-07-14','Director sueco.', p.id_pais FROM pais p
WHERE p.nombre_pais='Suecia' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Ingmar' AND d.apellido='Bergman' AND d.fecha_nacimiento='1918-07-14' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Andrei','Tarkovsky','1932-04-04','Director ruso.', p.id_pais FROM pais p
WHERE p.nombre_pais='Rusia' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Andrei' AND d.apellido='Tarkovsky' AND d.fecha_nacimiento='1932-04-04' AND d.id_pais=p.id_pais
);

-- Asia (India, Irán)
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Satyajit','Ray','1921-05-02','Director indio.', p.id_pais FROM pais p
WHERE p.nombre_pais='India' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Satyajit' AND d.apellido='Ray' AND d.fecha_nacimiento='1921-05-02' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Asghar','Farhadi','1972-05-07','Director iraní.', p.id_pais FROM pais p
WHERE p.nombre_pais='Irán' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Asghar' AND d.apellido='Farhadi' AND d.fecha_nacimiento='1972-05-07' AND d.id_pais=p.id_pais
);

-- America del Sur adicionales
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Fernando','Meirelles','1955-11-09','Director brasileño.', p.id_pais FROM pais p
WHERE p.nombre_pais='Brasil' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Fernando' AND d.apellido='Meirelles' AND d.fecha_nacimiento='1955-11-09' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Lucrecia','Martel','1966-12-14','Directora argentina.', p.id_pais FROM pais p
WHERE p.nombre_pais='Argentina' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Lucrecia' AND d.apellido='Martel' AND d.fecha_nacimiento='1966-12-14' AND d.id_pais=p.id_pais
);
INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Pablo','Larraín','1976-08-19','Director chileno.', p.id_pais FROM pais p
WHERE p.nombre_pais='Chile' AND NOT EXISTS (
  SELECT 1 FROM director d WHERE d.nombre='Pablo' AND d.apellido='Larraín' AND d.fecha_nacimiento='1976-08-19' AND d.id_pais=p.id_pais
);

-- =====================
-- Pool de Actores (reutilizables, idempotentes)
-- =====================
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Robert','De Niro','1943-08-17','Actor estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Robert' AND a.apellido='De Niro' AND a.fecha_nacimiento='1943-08-17' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Leonardo','DiCaprio','1974-11-11','Actor estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Leonardo' AND a.apellido='DiCaprio' AND a.fecha_nacimiento='1974-11-11' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Tom','Hanks','1956-07-09','Actor estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Tom' AND a.apellido='Hanks' AND a.fecha_nacimiento='1956-07-09' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Cate','Blanchett','1969-05-14','Actriz australiana.', p.id_pais FROM pais p
WHERE p.nombre_pais='Australia' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Cate' AND a.apellido='Blanchett' AND a.fecha_nacimiento='1969-05-14' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Tilda','Swinton','1960-11-05','Actriz británica.', p.id_pais FROM pais p
WHERE p.nombre_pais='Reino Unido' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Tilda' AND a.apellido='Swinton' AND a.fecha_nacimiento='1960-11-05' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Brad','Pitt','1963-12-18','Actor estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Brad' AND a.apellido='Pitt' AND a.fecha_nacimiento='1963-12-18' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Natalie','Portman','1981-06-09','Actriz estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Natalie' AND a.apellido='Portman' AND a.fecha_nacimiento='1981-06-09' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Keanu','Reeves','1964-09-02','Actor canadiense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Canadá' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Keanu' AND a.apellido='Reeves' AND a.fecha_nacimiento='1964-09-02' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Scarlett','Johansson','1984-11-22','Actriz estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Scarlett' AND a.apellido='Johansson' AND a.fecha_nacimiento='1984-11-22' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Christian','Bale','1974-01-30','Actor británico.', p.id_pais FROM pais p
WHERE p.nombre_pais='Reino Unido' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Christian' AND a.apellido='Bale' AND a.fecha_nacimiento='1974-01-30' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Meryl','Streep','1949-06-22','Actriz estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Meryl' AND a.apellido='Streep' AND a.fecha_nacimiento='1949-06-22' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Samuel L.','Jackson','1948-12-21','Actor estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Samuel L.' AND a.apellido='Jackson' AND a.fecha_nacimiento='1948-12-21' AND a.id_pais=p.id_pais
);

-- Actores específicos por regiones
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Sigourney','Weaver','1949-10-08','Actriz estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Sigourney' AND a.apellido='Weaver' AND a.fecha_nacimiento='1949-10-08' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Arnold','Schwarzenegger','1947-07-30','Actor austriaco-estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Austria' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Arnold' AND a.apellido='Schwarzenegger' AND a.fecha_nacimiento='1947-07-30' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Amy','Adams','1974-08-20','Actriz estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Amy' AND a.apellido='Adams' AND a.fecha_nacimiento='1974-08-20' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Ron','Perlman','1950-04-13','Actor estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Ron' AND a.apellido='Perlman' AND a.fecha_nacimiento='1950-04-13' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Sandra','Bullock','1964-07-26','Actriz estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Sandra' AND a.apellido='Bullock' AND a.fecha_nacimiento='1964-07-26' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Gael','García Bernal','1978-11-30','Actor mexicano.', p.id_pais FROM pais p
WHERE p.nombre_pais='México' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Gael' AND a.apellido='García Bernal' AND a.fecha_nacimiento='1978-11-30' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Penélope','Cruz','1974-04-28','Actriz española.', p.id_pais FROM pais p
WHERE p.nombre_pais='España' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Penélope' AND a.apellido='Cruz' AND a.fecha_nacimiento='1974-04-28' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Song','Kang-ho','1967-01-17','Actor surcoreano.', p.id_pais FROM pais p
WHERE p.nombre_pais='Corea del Sur' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Song' AND a.apellido='Kang-ho' AND a.fecha_nacimiento='1967-01-17' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Kim','Min-hee','1982-03-01','Actriz surcoreana.', p.id_pais FROM pais p
WHERE p.nombre_pais='Corea del Sur' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Kim' AND a.apellido='Min-hee' AND a.fecha_nacimiento='1982-03-01' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Rumi','Hiiragi','1987-08-01','Actriz japonesa.', p.id_pais FROM pais p
WHERE p.nombre_pais='Japón' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Rumi' AND a.apellido='Hiiragi' AND a.fecha_nacimiento='1987-08-01' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Toshiro','Mifune','1920-04-01','Actor japonés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Japón' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Toshiro' AND a.apellido='Mifune' AND a.fecha_nacimiento='1920-04-01' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Zhang','Ziyi','1979-02-09','Actriz china.', p.id_pais FROM pais p
WHERE p.nombre_pais='China' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Zhang' AND a.apellido='Ziyi' AND a.fecha_nacimiento='1979-02-09' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Tony','Leung','1962-06-27','Actor de Hong Kong.', p.id_pais FROM pais p
WHERE p.nombre_pais='Hong Kong' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Tony' AND a.apellido='Leung' AND a.fecha_nacimiento='1962-06-27' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Jean','Reno','1948-07-30','Actor francés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Francia' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Jean' AND a.apellido='Reno' AND a.fecha_nacimiento='1948-07-30' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Audrey','Tautou','1976-08-09','Actriz francesa.', p.id_pais FROM pais p
WHERE p.nombre_pais='Francia' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Audrey' AND a.apellido='Tautou' AND a.fecha_nacimiento='1976-08-09' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Mads','Mikkelsen','1965-11-22','Actor danés.', p.id_pais FROM pais p
WHERE p.nombre_pais='Dinamarca' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Mads' AND a.apellido='Mikkelsen' AND a.fecha_nacimiento='1965-11-22' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Toni','Servillo','1959-01-25','Actor italiano.', p.id_pais FROM pais p
WHERE p.nombre_pais='Italia' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Toni' AND a.apellido='Servillo' AND a.fecha_nacimiento='1959-01-25' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Clint','Eastwood','1930-05-31','Actor estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Clint' AND a.apellido='Eastwood' AND a.fecha_nacimiento='1930-05-31' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Elijah','Wood','1981-01-28','Actor estadounidense.', p.id_pais FROM pais p
WHERE p.nombre_pais='Estados Unidos' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Elijah' AND a.apellido='Wood' AND a.fecha_nacimiento='1981-01-28' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Tom','Hardy','1977-09-15','Actor británico.', p.id_pais FROM pais p
WHERE p.nombre_pais='Reino Unido' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Tom' AND a.apellido='Hardy' AND a.fecha_nacimiento='1977-09-15' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Klaus','Kinski','1926-10-18','Actor alemán.', p.id_pais FROM pais p
WHERE p.nombre_pais='Alemania' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Klaus' AND a.apellido='Kinski' AND a.fecha_nacimiento='1926-10-18' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Max','von Sydow','1929-04-10','Actor sueco.', p.id_pais FROM pais p
WHERE p.nombre_pais='Suecia' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Max' AND a.apellido='von Sydow' AND a.fecha_nacimiento='1929-04-10' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Anatoly','Solonitsyn','1934-08-30','Actor ruso.', p.id_pais FROM pais p
WHERE p.nombre_pais='Rusia' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Anatoly' AND a.apellido='Solonitsyn' AND a.fecha_nacimiento='1934-08-30' AND a.id_pais=p.id_pais
);
INSERT INTO actor (nombre, apellido, fecha_nacimiento, biografia, id_pais)
SELECT 'Soumitra','Chatterjee','1935-01-19','Actor indio.', p.id_pais FROM pais p
WHERE p.nombre_pais='India' AND NOT EXISTS (
  SELECT 1 FROM actor a WHERE a.nombre='Soumitra' AND a.apellido='Chatterjee' AND a.fecha_nacimiento='1935-01-19' AND a.id_pais=p.id_pais
);

-- =====================
-- Películas (3 por director) + vínculos director/género/actor
-- =====================

-- Steven Spielberg
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Jaws' AND [año_lanzamiento]=1975 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN
  INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
  VALUES ('Jaws','Un tiburón blanco aterroriza un pueblo costero.',1975,124,@id_tipo_pelicula,@id_cls_pg13);
END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='E.T. The Extra-Terrestrial' AND [año_lanzamiento]=1982 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN
  INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
  VALUES ('E.T. The Extra-Terrestrial','Un niño se hace amigo de un extraterrestre.',1982,115,@id_tipo_pelicula,@id_cls_pg);
END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Jurassic Park' AND [año_lanzamiento]=1993 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN
  INSERT INTO contenido (titulo, sinopsis, [año_lanzamiento], duracion, id_tipo_contenido, id_clasificacion)
  VALUES ('Jurassic Park','Un parque con dinosaurios clonados colapsa.',1993,127,@id_tipo_pelicula,@id_cls_pg13);
END

-- Vincular director y géneros principales
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director, c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Jaws','E.T. The Extra-Terrestrial','Jurassic Park')
WHERE d.nombre='Steven' AND d.apellido='Spielberg'
AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_terror, c.id_contenido FROM contenido c WHERE c.titulo='Jaws' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_terror AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_fantasia, c.id_contenido FROM contenido c WHERE c.titulo='E.T. The Extra-Terrestrial' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_fantasia AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_cf, c.id_contenido FROM contenido c WHERE c.titulo='Jurassic Park' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_cf AND gc.id_contenido=c.id_contenido);

-- Reparto simplificado
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor, c.id_contenido, 'Jefe Brody',1,1 FROM actor a JOIN contenido c ON c.titulo='Jaws'
WHERE a.nombre='Robert' AND a.apellido='De Niro' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor, c.id_contenido, 'Elliott',1,1 FROM actor a JOIN contenido c ON c.titulo='E.T. The Extra-Terrestrial'
WHERE a.nombre='Tom' AND a.apellido='Hanks' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor, c.id_contenido, 'Dr. Alan Grant',1,1 FROM actor a JOIN contenido c ON c.titulo='Jurassic Park'
WHERE a.nombre='Brad' AND a.apellido='Pitt' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Martin Scorsese
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Taxi Driver' AND [año_lanzamiento]=1976 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Taxi Driver','Un veterano inestable conduce un taxi en NYC.',1976,114,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Goodfellas' AND [año_lanzamiento]=1990 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Goodfellas','Ascenso y caída en la mafia.',1990,146,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Departed' AND [año_lanzamiento]=2006 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Departed','Infiltrados de ambos bandos en Boston.',2006,151,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Taxi Driver','Goodfellas','The Departed')
WHERE d.nombre='Martin' AND d.apellido='Scorsese'
AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Taxi Driver','Goodfellas','The Departed')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Travis Bickle',1,1 FROM actor a JOIN contenido c ON c.titulo='Taxi Driver'
WHERE a.nombre='Robert' AND a.apellido='De Niro' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Henry Hill',1,1 FROM actor a JOIN contenido c ON c.titulo='Goodfellas'
WHERE a.nombre='Robert' AND a.apellido='De Niro' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Billy Costigan',1,1 FROM actor a JOIN contenido c ON c.titulo='The Departed'
WHERE a.nombre='Robert' AND a.apellido='De Niro' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Quentin Tarantino
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Pulp Fiction' AND [año_lanzamiento]=1994 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Pulp Fiction','Historias criminales entrelazadas en Los Ángeles.',1994,154,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Kill Bill Vol 1' AND [año_lanzamiento]=2003 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Kill Bill Vol 1','Una asesina busca venganza.',2003,111,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Inglourious Basterds' AND [año_lanzamiento]=2009 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Inglourious Basterds','Comando judío en la Segunda Guerra.',2009,153,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Pulp Fiction','Kill Bill Vol 1','Inglourious Basterds')
WHERE d.nombre='Quentin' AND d.apellido='Tarantino'
AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo IN ('Kill Bill Vol 1','Inglourious Basterds')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo='Pulp Fiction'
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Jules Winnfield',1,1 FROM actor a JOIN contenido c ON c.titulo='Pulp Fiction'
WHERE a.nombre='Samuel L.' AND a.apellido='Jackson' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'O-Ren Ishii',1,2 FROM actor a JOIN contenido c ON c.titulo='Kill Bill Vol 1'
WHERE a.nombre='Samuel L.' AND a.apellido='Jackson' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Narrator',1,1 FROM actor a JOIN contenido c ON c.titulo='Inglourious Basterds'
WHERE a.nombre='Samuel L.' AND a.apellido='Jackson' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Ridley Scott
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Alien' AND [año_lanzamiento]=1979 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Alien','Criatura mortal ataca una tripulación espacial.',1979,117,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Blade Runner' AND [año_lanzamiento]=1982 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Blade Runner','Cazador de replicantes en un futuro distópico.',1982,117,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Gladiator' AND [año_lanzamiento]=2000 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Gladiator','General romano convertido en gladiador.',2000,155,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Alien','Blade Runner','Gladiator')
WHERE d.nombre='Ridley' AND d.apellido='Scott' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_terror, c.id_contenido FROM contenido c WHERE c.titulo='Alien' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_terror AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_cf, c.id_contenido FROM contenido c WHERE c.titulo='Blade Runner' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_cf AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo='Gladiator' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Ellen Ripley',1,1 FROM actor a JOIN contenido c ON c.titulo='Alien'
WHERE a.nombre='Sigourney' AND a.apellido='Weaver' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Rick Deckard',1,1 FROM actor a JOIN contenido c ON c.titulo='Blade Runner'
WHERE a.nombre='Sigourney' AND a.apellido='Weaver' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Maximus',1,1 FROM actor a JOIN contenido c ON c.titulo='Gladiator'
WHERE a.nombre='Sigourney' AND a.apellido='Weaver' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- James Cameron
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Terminator' AND [año_lanzamiento]=1984 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Terminator','Un cyborg viaja al pasado para asesinar.',1984,107,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Titanic' AND [año_lanzamiento]=1997 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Titanic','Romance y tragedia en el famoso barco.',1997,195,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Avatar' AND [año_lanzamiento]=2009 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Avatar','Humano se integra con nativos de Pandora.',2009,162,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('The Terminator','Titanic','Avatar')
WHERE d.nombre='James' AND d.apellido='Cameron' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo='The Terminator' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo='Titanic' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_cf, c.id_contenido FROM contenido c WHERE c.titulo='Avatar' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_cf AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'T-800',1,1 FROM actor a JOIN contenido c ON c.titulo='The Terminator'
WHERE a.nombre='Arnold' AND a.apellido='Schwarzenegger' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Jack Dawson',1,1 FROM actor a JOIN contenido c ON c.titulo='Titanic'
WHERE a.nombre='Arnold' AND a.apellido='Schwarzenegger' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Jake Sully',1,1 FROM actor a JOIN contenido c ON c.titulo='Avatar'
WHERE a.nombre='Arnold' AND a.apellido='Schwarzenegger' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Denis Villeneuve
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Arrival' AND [año_lanzamiento]=2016 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Arrival','Lingüista intenta comunicarse con extraterrestres.',2016,116,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Sicario' AND [año_lanzamiento]=2015 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Sicario','Agente del FBI entra en guerra contra el narco.',2015,121,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Prisoners' AND [año_lanzamiento]=2013 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Prisoners','Padre desesperado tras desaparición de su hija.',2013,153,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Arrival','Sicario','Prisoners')
WHERE d.nombre='Denis' AND d.apellido='Villeneuve' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_cf, c.id_contenido FROM contenido c WHERE c.titulo='Arrival' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_cf AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Sicario','Prisoners') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Dra. Louise Banks',1,1 FROM actor a JOIN contenido c ON c.titulo='Arrival'
WHERE a.nombre='Amy' AND a.apellido='Adams' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Kate Macer',1,1 FROM actor a JOIN contenido c ON c.titulo='Sicario'
WHERE a.nombre='Amy' AND a.apellido='Adams' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Keller Dover',1,1 FROM actor a JOIN contenido c ON c.titulo='Prisoners'
WHERE a.nombre='Amy' AND a.apellido='Adams' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Guillermo del Toro
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Pans Labyrinth' AND [año_lanzamiento]=2006 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Pans Labyrinth','Fábula oscura en la posguerra española.',2006,118,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Shape of Water' AND [año_lanzamiento]=2017 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Shape of Water','Romance fantástico entre mujer y criatura.',2017,123,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Hellboy' AND [año_lanzamiento]=2004 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Hellboy','Demonio criado por humanos combate amenazas.',2004,122,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Pans Labyrinth','The Shape of Water','Hellboy')
WHERE d.nombre='Guillermo' AND d.apellido='del Toro' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_fantasia, c.id_contenido FROM contenido c WHERE c.titulo IN ('Pans Labyrinth','The Shape of Water','Hellboy')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_fantasia AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Hellboy',1,1 FROM actor a JOIN contenido c ON c.titulo='Hellboy'
WHERE a.nombre='Ron' AND a.apellido='Perlman' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Ofelia',1,1 FROM actor a JOIN contenido c ON c.titulo='Pans Labyrinth'
WHERE a.nombre='Ron' AND a.apellido='Perlman' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Elisa Esposito',1,1 FROM actor a JOIN contenido c ON c.titulo='The Shape of Water'
WHERE a.nombre='Ron' AND a.apellido='Perlman' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Alfonso Cuarón
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Y Tu Mama Tambien' AND [año_lanzamiento]=2001 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Y Tu Mama Tambien','Road movie mexicana sobre amistad y deseo.',2001,106,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Children of Men' AND [año_lanzamiento]=2006 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Children of Men','Futuro sin nacimientos, un hombre protege a una mujer.',2006,109,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Gravity' AND [año_lanzamiento]=2013 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Gravity','Desastre espacial pone a prueba a dos astronautas.',2013,91,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Y Tu Mama Tambien','Children of Men','Gravity')
WHERE d.nombre='Alfonso' AND d.apellido='Cuarón' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo='Y Tu Mama Tambien' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_cf, c.id_contenido FROM contenido c WHERE c.titulo IN ('Children of Men','Gravity') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_cf AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Dra. Ryan Stone',1,1 FROM actor a JOIN contenido c ON c.titulo='Gravity'
WHERE a.nombre='Sandra' AND a.apellido='Bullock' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Tenoch',1,1 FROM actor a JOIN contenido c ON c.titulo='Y Tu Mama Tambien'
WHERE a.nombre='Sandra' AND a.apellido='Bullock' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Theo Faron',1,1 FROM actor a JOIN contenido c ON c.titulo='Children of Men'
WHERE a.nombre='Sandra' AND a.apellido='Bullock' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Alejandro González Iñárritu
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Amores Perros' AND [año_lanzamiento]=2000 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Amores Perros','Historias cruzadas en la Ciudad de México.',2000,154,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Babel' AND [año_lanzamiento]=2006 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Babel','Consecuencias de un disparo a través de continentes.',2006,143,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Revenant' AND [año_lanzamiento]=2015 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Revenant','Supervivencia en la frontera americana.',2015,156,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Amores Perros','Babel','The Revenant')
WHERE d.nombre='Alejandro' AND d.apellido='González Iñárritu' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Amores Perros','Babel','The Revenant') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Hugh Glass',1,1 FROM actor a JOIN contenido c ON c.titulo='The Revenant'
WHERE a.nombre='Leonardo' AND a.apellido='DiCaprio' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Octavio',1,1 FROM actor a JOIN contenido c ON c.titulo='Amores Perros'
WHERE a.nombre='Leonardo' AND a.apellido='DiCaprio' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Susan Jones',1,1 FROM actor a JOIN contenido c ON c.titulo='Babel'
WHERE a.nombre='Leonardo' AND a.apellido='DiCaprio' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Pedro Almodóvar
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='All About My Mother' AND [año_lanzamiento]=1999 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('All About My Mother','Homenaje a las mujeres y la maternidad.',1999,101,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Talk to Her' AND [año_lanzamiento]=2002 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Talk to Her','Vínculos entre dos hombres y dos mujeres en coma.',2002,112,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Volver' AND [año_lanzamiento]=2006 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Volver','Mujeres enfrentan secretos del pasado.',2006,121,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('All About My Mother','Talk to Her','Volver')
WHERE d.nombre='Pedro' AND d.apellido='Almodóvar' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('All About My Mother','Talk to Her','Volver')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Raimunda',1,1 FROM actor a JOIN contenido c ON c.titulo='Volver'
WHERE a.nombre='Penélope' AND a.apellido='Cruz' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Manuela',1,1 FROM actor a JOIN contenido c ON c.titulo='All About My Mother'
WHERE a.nombre='Penélope' AND a.apellido='Cruz' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Alicia',1,1 FROM actor a JOIN contenido c ON c.titulo='Talk to Her'
WHERE a.nombre='Penélope' AND a.apellido='Cruz' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Bong Joon-ho
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Memories of Murder' AND [año_lanzamiento]=2003 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Memories of Murder','Detectives investigan homicidios seriales.',2003,131,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Host' AND [año_lanzamiento]=2006 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Host','Criatura emerge del río Han.',2006,119,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Parasite' AND [año_lanzamiento]=2019 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Parasite','Dos familias se entrelazan con consecuencias impredecibles.',2019,132,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Memories of Murder','The Host','Parasite')
WHERE d.nombre='Bong' AND d.apellido='Joon-ho' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Memories of Murder','Parasite')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_terror, c.id_contenido FROM contenido c WHERE c.titulo='The Host'
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_terror AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Det. Park Doo-man',1,1 FROM actor a JOIN contenido c ON c.titulo='Memories of Murder'
WHERE a.nombre='Song' AND a.apellido='Kang-ho' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Ki-taek',1,1 FROM actor a JOIN contenido c ON c.titulo='Parasite'
WHERE a.nombre='Song' AND a.apellido='Kang-ho' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Gang-du',1,1 FROM actor a JOIN contenido c ON c.titulo='The Host'
WHERE a.nombre='Song' AND a.apellido='Kang-ho' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Park Chan-wook
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Oldboy' AND [año_lanzamiento]=2003 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Oldboy','Hombre secuestrado busca vengarse tras 15 años.',2003,120,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Handmaiden' AND [año_lanzamiento]=2016 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Handmaiden','Intrigas, engaños y deseo en Corea colonial.',2016,144,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Decision to Leave' AND [año_lanzamiento]=2022 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Decision to Leave','Detective se obsesiona con una sospechosa.',2022,138,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Oldboy','The Handmaiden','Decision to Leave')
WHERE d.nombre='Park' AND d.apellido='Chan-wook' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('The Handmaiden','Decision to Leave') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo='Oldboy' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Sook-hee',1,1 FROM actor a JOIN contenido c ON c.titulo='The Handmaiden'
WHERE a.nombre='Kim' AND a.apellido='Min-hee' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Oh Dae-su',1,1 FROM actor a JOIN contenido c ON c.titulo='Oldboy'
WHERE a.nombre='Kim' AND a.apellido='Min-hee' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Seo-rae',1,1 FROM actor a JOIN contenido c ON c.titulo='Decision to Leave'
WHERE a.nombre='Kim' AND a.apellido='Min-hee' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Hayao Miyazaki
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='My Neighbor Totoro' AND [año_lanzamiento]=1988 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('My Neighbor Totoro','Dos hermanas conocen espíritus del bosque.',1988,86,@id_tipo_pelicula,@id_cls_g); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Spirited Away' AND [año_lanzamiento]=2001 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Spirited Away','Niña atrapada en un mundo mágico.',2001,125,@id_tipo_pelicula,@id_cls_g); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Princess Mononoke' AND [año_lanzamiento]=1997 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Princess Mononoke','Conflicto entre industria y naturaleza.',1997,134,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('My Neighbor Totoro','Spirited Away','Princess Mononoke')
WHERE d.nombre='Hayao' AND d.apellido='Miyazaki' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_fantasia, c.id_contenido FROM contenido c WHERE c.titulo IN ('My Neighbor Totoro','Spirited Away','Princess Mononoke')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_fantasia AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Voz protagonista',1,1 FROM actor a JOIN contenido c ON c.titulo='Spirited Away'
WHERE a.nombre='Rumi' AND a.apellido='Hiiragi' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Akira Kurosawa
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Seven Samurai' AND [año_lanzamiento]=1954 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Seven Samurai','Siete samuráis defienden una aldea.',1954,207,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Rashomon' AND [año_lanzamiento]=1950 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Rashomon','Múltiples perspectivas sobre un crimen.',1950,88,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Ikiru' AND [año_lanzamiento]=1952 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Ikiru','Funcionario busca sentido a su vida.',1952,143,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Seven Samurai','Rashomon','Ikiru')
WHERE d.nombre='Akira' AND d.apellido='Kurosawa' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo='Seven Samurai' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Rashomon','Ikiru') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Kambei',1,1 FROM actor a JOIN contenido c ON c.titulo='Seven Samurai'
WHERE a.nombre='Toshiro' AND a.apellido='Mifune' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Tajomaru',1,1 FROM actor a JOIN contenido c ON c.titulo='Rashomon'
WHERE a.nombre='Toshiro' AND a.apellido='Mifune' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Kanji Watanabe',1,1 FROM actor a JOIN contenido c ON c.titulo='Ikiru'
WHERE a.nombre='Toshiro' AND a.apellido='Mifune' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Zhang Yimou
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Raise the Red Lantern' AND [año_lanzamiento]=1991 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Raise the Red Lantern','Joven esposa enfrenta rígidas tradiciones.',1991,125,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Hero' AND [año_lanzamiento]=2002 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Hero','Guerrero relata hazañas ante el rey.',2002,99,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='House of Flying Daggers' AND [año_lanzamiento]=2004 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('House of Flying Daggers','Amor y lealtad en guerra de clanes.',2004,119,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Raise the Red Lantern','Hero','House of Flying Daggers')
WHERE d.nombre='Zhang' AND d.apellido='Yimou' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo='Raise the Red Lantern' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo IN ('Hero','House of Flying Daggers') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Moon',1,1 FROM actor a JOIN contenido c ON c.titulo='Hero'
WHERE a.nombre='Zhang' AND a.apellido='Ziyi' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Mei',1,1 FROM actor a JOIN contenido c ON c.titulo='House of Flying Daggers'
WHERE a.nombre='Zhang' AND a.apellido='Ziyi' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Songlian',1,1 FROM actor a JOIN contenido c ON c.titulo='Raise the Red Lantern'
WHERE a.nombre='Zhang' AND a.apellido='Ziyi' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Ang Lee
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Crouching Tiger Hidden Dragon' AND [año_lanzamiento]=2000 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Crouching Tiger Hidden Dragon','Amor y honor en la China antigua.',2000,120,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Brokeback Mountain' AND [año_lanzamiento]=2005 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Brokeback Mountain','Amor prohibido entre dos vaqueros.',2005,134,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Life of Pi' AND [año_lanzamiento]=2012 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Life of Pi','Joven sobrevive en un bote con un tigre.',2012,127,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Crouching Tiger Hidden Dragon','Brokeback Mountain','Life of Pi')
WHERE d.nombre='Ang' AND d.apellido='Lee' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo='Crouching Tiger Hidden Dragon' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Brokeback Mountain','Life of Pi') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Li Mu Bai',1,1 FROM actor a JOIN contenido c ON c.titulo='Crouching Tiger Hidden Dragon'
WHERE a.nombre='Chow' AND a.apellido='Yun-fat' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Ennis Del Mar',1,1 FROM actor a JOIN contenido c ON c.titulo='Brokeback Mountain'
WHERE a.nombre='Chow' AND a.apellido='Yun-fat' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Pi Patel',1,1 FROM actor a JOIN contenido c ON c.titulo='Life of Pi'
WHERE a.nombre='Chow' AND a.apellido='Yun-fat' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Wong Kar-wai
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Chungking Express' AND [año_lanzamiento]=1994 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Chungking Express','Dos historias de amor en Hong Kong.',1994,102,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='In the Mood for Love' AND [año_lanzamiento]=2000 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('In the Mood for Love','Dos vecinos forjan un vínculo íntimo.',2000,98,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='2046' AND [año_lanzamiento]=2004 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('2046','Escritor reflexiona sobre amores pasados.',2004,129,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Chungking Express','In the Mood for Love','2046')
WHERE d.nombre='Wong' AND d.apellido='Kar-wai' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Chungking Express','In the Mood for Love','2046')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Chow Mo-wan',1,1 FROM actor a JOIN contenido c ON c.titulo='In the Mood for Love'
WHERE a.nombre='Tony' AND a.apellido='Leung' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Cop 223',1,1 FROM actor a JOIN contenido c ON c.titulo='Chungking Express'
WHERE a.nombre='Tony' AND a.apellido='Leung' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Chow Mo-wan',1,1 FROM actor a JOIN contenido c ON c.titulo='2046'
WHERE a.nombre='Tony' AND a.apellido='Leung' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Luc Besson
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Leon The Professional' AND [año_lanzamiento]=1994 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Leon The Professional','Asesino a sueldo cuida de una niña.',1994,110,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Fifth Element' AND [año_lanzamiento]=1997 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Fifth Element','Héroe salva al mundo con un ser supremo.',1997,126,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Nikita' AND [año_lanzamiento]=1990 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Nikita','Criminal se convierte en espía letal.',1990,118,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Leon The Professional','The Fifth Element','Nikita')
WHERE d.nombre='Luc' AND d.apellido='Besson' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo IN ('Leon The Professional','Nikita') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_cf, c.id_contenido FROM contenido c WHERE c.titulo='The Fifth Element' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_cf AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Léon',1,1 FROM actor a JOIN contenido c ON c.titulo='Leon The Professional'
WHERE a.nombre='Jean' AND a.apellido='Reno' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Korben Dallas',1,1 FROM actor a JOIN contenido c ON c.titulo='The Fifth Element'
WHERE a.nombre='Jean' AND a.apellido='Reno' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Victor',1,1 FROM actor a JOIN contenido c ON c.titulo='Nikita'
WHERE a.nombre='Jean' AND a.apellido='Reno' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Jean-Pierre Jeunet
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Delicatessen' AND [año_lanzamiento]=1991 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Delicatessen','Comedia negra en edificio posapocalíptico.',1991,99,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Amelie' AND [año_lanzamiento]=2001 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Amelie','Joven ayuda a otros desde el anonimato.',2001,122,@id_tipo_pelicula,@id_cls_pg); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='A Very Long Engagement' AND [año_lanzamiento]=2004 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('A Very Long Engagement','Mujer busca a su prometido tras la guerra.',2004,133,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Delicatessen','Amelie','A Very Long Engagement')
WHERE d.nombre='Jean-Pierre' AND d.apellido='Jeunet' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Amelie','A Very Long Engagement') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_terror, c.id_contenido FROM contenido c WHERE c.titulo='Delicatessen' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_terror AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Amélie Poulain',1,1 FROM actor a JOIN contenido c ON c.titulo='Amelie'
WHERE a.nombre='Audrey' AND a.apellido='Tautou' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Louison',1,1 FROM actor a JOIN contenido c ON c.titulo='Delicatessen'
WHERE a.nombre='Audrey' AND a.apellido='Tautou' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Mathilde',1,1 FROM actor a JOIN contenido c ON c.titulo='A Very Long Engagement'
WHERE a.nombre='Audrey' AND a.apellido='Tautou' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Lars von Trier
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Breaking the Waves' AND [año_lanzamiento]=1996 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Breaking the Waves','Mujer se sacrifica por su esposo enfermo.',1996,159,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Dancer in the Dark' AND [año_lanzamiento]=2000 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Dancer in the Dark','Mujer inmigrante enfrenta tragedias.',2000,141,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Melancholia' AND [año_lanzamiento]=2011 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Melancholia','Planeta errante amenaza a la Tierra.',2011,136,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Breaking the Waves','Dancer in the Dark','Melancholia')
WHERE d.nombre='Lars' AND d.apellido='von Trier' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Breaking the Waves','Dancer in the Dark','Melancholia') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);

-- Thomas Vinterberg
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Celebration' AND [año_lanzamiento]=1998 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Celebration','Se revela un oscuro secreto familiar.',1998,105,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Hunt' AND [año_lanzamiento]=2012 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Hunt','Maestro es acusado falsamente.',2012,115,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Another Round' AND [año_lanzamiento]=2020 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Another Round','Experimento con alcohol para mejorar la vida.',2020,117,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('The Celebration','The Hunt','Another Round')
WHERE d.nombre='Thomas' AND d.apellido='Vinterberg' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('The Celebration','The Hunt','Another Round') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Lucas',1,1 FROM actor a JOIN contenido c ON c.titulo='The Hunt'
WHERE a.nombre='Mads' AND a.apellido='Mikkelsen' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Martin',1,1 FROM actor a JOIN contenido c ON c.titulo='Another Round'
WHERE a.nombre='Mads' AND a.apellido='Mikkelsen' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Christian',1,1 FROM actor a JOIN contenido c ON c.titulo='The Celebration'
WHERE a.nombre='Mads' AND a.apellido='Mikkelsen' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Paolo Sorrentino
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Great Beauty' AND [año_lanzamiento]=2013 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Great Beauty','Escritor reflexiona sobre su vida en Roma.',2013,141,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Youth' AND [año_lanzamiento]=2015 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Youth','Amigos ancianos enfrentan el paso del tiempo.',2015,124,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Il Divo' AND [año_lanzamiento]=2008 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Il Divo','Retrato del político Giulio Andreotti.',2008,110,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('The Great Beauty','Youth','Il Divo')
WHERE d.nombre='Paolo' AND d.apellido='Sorrentino' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('The Great Beauty','Youth','Il Divo') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);

-- Sergio Leone
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Fistful of Dollars' AND [año_lanzamiento]=1964 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Fistful of Dollars','Forastero agita rivalidad entre bandas.',1964,99,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Good The Bad and The Ugly' AND [año_lanzamiento]=1966 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Good The Bad and The Ugly','Tres pistoleros buscan un tesoro.',1966,178,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Once Upon a Time in the West' AND [año_lanzamiento]=1968 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Once Upon a Time in the West','Venganza y ferrocarril en el oeste.',1968,165,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Fistful of Dollars','The Good The Bad and The Ugly','Once Upon a Time in the West')
WHERE d.nombre='Sergio' AND d.apellido='Leone' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo IN ('Fistful of Dollars','The Good The Bad and The Ugly','Once Upon a Time in the West')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'The Man with No Name',1,1 FROM actor a JOIN contenido c ON c.titulo='Fistful of Dollars'
WHERE a.nombre='Clint' AND a.apellido='Eastwood' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Blondie',1,1 FROM actor a JOIN contenido c ON c.titulo='The Good The Bad and The Ugly'
WHERE a.nombre='Clint' AND a.apellido='Eastwood' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Harmonica',1,1 FROM actor a JOIN contenido c ON c.titulo='Once Upon a Time in the West'
WHERE a.nombre='Clint' AND a.apellido='Eastwood' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Peter Jackson
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Fellowship of the Ring' AND [año_lanzamiento]=2001 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Fellowship of the Ring','Comienza la travesía para destruir el anillo.',2001,178,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Two Towers' AND [año_lanzamiento]=2002 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Two Towers','La comunidad se divide ante nuevas amenazas.',2002,179,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Return of the King' AND [año_lanzamiento]=2003 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Return of the King','La batalla final por la Tierra Media.',2003,201,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Fellowship of the Ring','The Two Towers','The Return of the King')
WHERE d.nombre='Peter' AND d.apellido='Jackson' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_fantasia, c.id_contenido FROM contenido c WHERE c.titulo IN ('Fellowship of the Ring','The Two Towers','The Return of the King')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_fantasia AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Frodo Baggins',1,1 FROM actor a JOIN contenido c ON c.titulo='Fellowship of the Ring'
WHERE a.nombre='Elijah' AND a.apellido='Wood' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Frodo Baggins',1,1 FROM actor a JOIN contenido c ON c.titulo='The Two Towers'
WHERE a.nombre='Elijah' AND a.apellido='Wood' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Frodo Baggins',1,1 FROM actor a JOIN contenido c ON c.titulo='The Return of the King'
WHERE a.nombre='Elijah' AND a.apellido='Wood' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Taika Waititi
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Boy' AND [año_lanzamiento]=2010 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Boy','Niño idolatra a su padre ausente en NZ.',2010,87,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='What We Do in the Shadows' AND [año_lanzamiento]=2014 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('What We Do in the Shadows','Documental falso sobre vampiros en Wellington.',2014,86,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Jojo Rabbit' AND [año_lanzamiento]=2019 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Jojo Rabbit','Niño alemán con amigo imaginario Adolf.',2019,108,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Boy','What We Do in the Shadows','Jojo Rabbit')
WHERE d.nombre='Taika' AND d.apellido='Waititi' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Boy','Jojo Rabbit') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);

-- George Miller
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Mad Max' AND [año_lanzamiento]=1979 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Mad Max','Policía busca venganza en un mundo colapsado.',1979,93,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Fury Road' AND [año_lanzamiento]=2015 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Fury Road','Persecución explosiva en el desierto.',2015,120,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Babe Pig in the City' AND [año_lanzamiento]=1998 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Babe Pig in the City','Cerdito viaja a la gran ciudad.',1998,97,@id_tipo_pelicula,@id_cls_pg); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Mad Max','Fury Road','Babe Pig in the City')
WHERE d.nombre='George' AND d.apellido='Miller' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_accion, c.id_contenido FROM contenido c WHERE c.titulo IN ('Mad Max','Fury Road') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_accion AND gc.id_contenido=c.id_contenido);

-- Werner Herzog
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Aguirre The Wrath of God' AND [año_lanzamiento]=1972 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Aguirre The Wrath of God','Conquistador obsesionado busca El Dorado.',1972,95,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Fitzcarraldo' AND [año_lanzamiento]=1982 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Fitzcarraldo','Hombre intenta llevar un barco sobre una montaña.',1982,158,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Grizzly Man' AND [año_lanzamiento]=2005 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Grizzly Man','Historia real de un activista de osos.',2005,103,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Aguirre The Wrath of God','Fitzcarraldo','Grizzly Man')
WHERE d.nombre='Werner' AND d.apellido='Herzog' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Aguirre The Wrath of God','Fitzcarraldo') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_doc, c.id_contenido FROM contenido c WHERE c.titulo='Grizzly Man' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_doc AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Aguirre',1,1 FROM actor a JOIN contenido c ON c.titulo='Aguirre The Wrath of God'
WHERE a.nombre='Klaus' AND a.apellido='Kinski' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Fitzcarraldo',1,1 FROM actor a JOIN contenido c ON c.titulo='Fitzcarraldo'
WHERE a.nombre='Klaus' AND a.apellido='Kinski' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Timothy Treadwell',1,1 FROM actor a JOIN contenido c ON c.titulo='Grizzly Man'
WHERE a.nombre='Klaus' AND a.apellido='Kinski' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Ingmar Bergman
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Seventh Seal' AND [año_lanzamiento]=1957 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Seventh Seal','Caballero juega ajedrez con la Muerte.',1957,96,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Persona' AND [año_lanzamiento]=1966 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Persona','Actriz y enfermera en simbiosis psicológica.',1966,83,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Fanny and Alexander' AND [año_lanzamiento]=1982 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Fanny and Alexander','Infancia y tragedia en una familia sueca.',1982,188,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('The Seventh Seal','Persona','Fanny and Alexander')
WHERE d.nombre='Ingmar' AND d.apellido='Bergman' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('The Seventh Seal','Persona','Fanny and Alexander')
AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Antonius Block',1,1 FROM actor a JOIN contenido c ON c.titulo='The Seventh Seal'
WHERE a.nombre='Max' AND a.apellido='von Sydow' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Oscar Ekdahl',1,1 FROM actor a JOIN contenido c ON c.titulo='Fanny and Alexander'
WHERE a.nombre='Max' AND a.apellido='von Sydow' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Dr. Vergérus',1,1 FROM actor a JOIN contenido c ON c.titulo='Persona'
WHERE a.nombre='Max' AND a.apellido='von Sydow' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Andrei Tarkovsky
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Andrei Rublev' AND [año_lanzamiento]=1966 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Andrei Rublev','Vida del pintor de iconos ruso.',1966,205,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Solaris' AND [año_lanzamiento]=1972 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Solaris','Estación espacial provoca visiones.',1972,167,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Stalker' AND [año_lanzamiento]=1979 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Stalker','Guía conduce a dos hombres a La Zona.',1979,163,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Andrei Rublev','Solaris','Stalker')
WHERE d.nombre='Andrei' AND d.apellido='Tarkovsky' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo='Andrei Rublev' AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_cf, c.id_contenido FROM contenido c WHERE c.titulo IN ('Solaris','Stalker') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_cf AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Andrei Rublev',1,1 FROM actor a JOIN contenido c ON c.titulo='Andrei Rublev'
WHERE a.nombre='Anatoly' AND a.apellido='Solonitsyn' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Stalker',1,1 FROM actor a JOIN contenido c ON c.titulo='Stalker'
WHERE a.nombre='Anatoly' AND a.apellido='Solonitsyn' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Kris Kelvin',1,1 FROM actor a JOIN contenido c ON c.titulo='Solaris'
WHERE a.nombre='Anatoly' AND a.apellido='Solonitsyn' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Satyajit Ray
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Pather Panchali' AND [año_lanzamiento]=1955 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Pather Panchali','Vida de una familia rural india.',1955,125,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Aparajito' AND [año_lanzamiento]=1956 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Aparajito','Juventud y aprendizaje de Apu.',1956,110,@id_tipo_pelicula,@id_cls_pg13); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The World of Apu' AND [año_lanzamiento]=1959 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The World of Apu','Apu enfrenta el amor y la paternidad.',1959,105,@id_tipo_pelicula,@id_cls_pg13); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Pather Panchali','Aparajito','The World of Apu')
WHERE d.nombre='Satyajit' AND d.apellido='Ray' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Pather Panchali','Aparajito','The World of Apu') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Apu Kumar Roy',1,1 FROM actor a JOIN contenido c ON c.titulo='Pather Panchali'
WHERE a.nombre='Soumitra' AND a.apellido='Chatterjee' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Apu Kumar Roy',1,1 FROM actor a JOIN contenido c ON c.titulo='Aparajito'
WHERE a.nombre='Soumitra' AND a.apellido='Chatterjee' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);
INSERT INTO reparto (id_actor,id_contenido,nombre_personaje,es_protagonista,orden_creditos)
SELECT a.id_actor,c.id_contenido,'Apu Kumar Roy',1,1 FROM actor a JOIN contenido c ON c.titulo='The World of Apu'
WHERE a.nombre='Soumitra' AND a.apellido='Chatterjee' AND NOT EXISTS (SELECT 1 FROM reparto r WHERE r.id_actor=a.id_actor AND r.id_contenido=c.id_contenido);

-- Asghar Farhadi
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='About Elly' AND [año_lanzamiento]=2009 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('About Elly','Excursión a la playa deriva en misterio.',2009,119,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='A Separation' AND [año_lanzamiento]=2011 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('A Separation','Divorcio complica la vida de dos familias.',2011,123,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Salesman' AND [año_lanzamiento]=2016 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Salesman','Pareja afronta un incidente traumático.',2016,125,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('About Elly','A Separation','The Salesman')
WHERE d.nombre='Asghar' AND d.apellido='Farhadi' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('About Elly','A Separation','The Salesman') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);

-- Fernando Meirelles
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='City of God' AND [año_lanzamiento]=2002 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('City of God','Crimen y supervivencia en favelas de Río.',2002,130,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Constant Gardener' AND [año_lanzamiento]=2005 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Constant Gardener','Complot farmacéutico en África.',2005,129,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='360' AND [año_lanzamiento]=2011 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('360','Historias entrelazadas alrededor del mundo.',2011,110,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('City of God','The Constant Gardener','360')
WHERE d.nombre='Fernando' AND d.apellido='Meirelles' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('City of God','The Constant Gardener','360') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);

-- Lucrecia Martel
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='La Cienaga' AND [año_lanzamiento]=2001 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('La Cienaga','Familia disfuncional en provincia argentina.',2001,103,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='The Headless Woman' AND [año_lanzamiento]=2008 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('The Headless Woman','Mujer confundida tras un accidente.',2008,87,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Zama' AND [año_lanzamiento]=2017 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Zama','Oficial español espera su transferencia en el siglo XVIII.',2017,115,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('La Cienaga','The Headless Woman','Zama')
WHERE d.nombre='Lucrecia' AND d.apellido='Martel' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('La Cienaga','The Headless Woman','Zama') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);

-- Pablo Larraín
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Tony Manero' AND [año_lanzamiento]=2008 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Tony Manero','Hombre obsesionado con Fiebre del Sábado Noche.',2008,98,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='No' AND [año_lanzamiento]=2012 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('No','Campaña publicitaria contra Pinochet.',2012,118,@id_tipo_pelicula,@id_cls_r); END
IF NOT EXISTS (SELECT 1 FROM contenido WHERE titulo='Jackie' AND [año_lanzamiento]=2016 AND id_tipo_contenido=@id_tipo_pelicula)
BEGIN INSERT INTO contenido (titulo,sinopsis,[año_lanzamiento],duracion,id_tipo_contenido,id_clasificacion)
VALUES ('Jackie','Retrato de Jacqueline Kennedy tras el asesinato.',2016,100,@id_tipo_pelicula,@id_cls_r); END
INSERT INTO director_contenido (id_director, id_contenido)
SELECT d.id_director,c.id_contenido FROM director d JOIN contenido c ON c.titulo IN ('Tony Manero','No','Jackie')
WHERE d.nombre='Pablo' AND d.apellido='Larraín' AND NOT EXISTS (SELECT 1 FROM director_contenido dc WHERE dc.id_director=d.id_director AND dc.id_contenido=c.id_contenido);
INSERT INTO genero_contenido (id_genero,id_contenido)
SELECT @id_gen_drama, c.id_contenido FROM contenido c WHERE c.titulo IN ('Tony Manero','No','Jackie') AND NOT EXISTS (SELECT 1 FROM genero_contenido gc WHERE gc.id_genero=@id_gen_drama AND gc.id_contenido=c.id_contenido);

-- =============================================================
-- LOTE DE USUARIOS Y ACTIVIDAD (15 usuarios nuevos + relacionados)
-- =============================================================

-- Usuario 1: María López (España) - Usuario activo Premium con 3 perfiles
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'María', 'López', 'maria.lopez@email.es', 'hash_maria', '1995-04-12', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'España' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='maria.lopez@email.es');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'María', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='maria.lopez@email.es' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='maria.lopez@email.es' AND pf.nombre_perfil='María');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Sofía', 1, c.id_clasificacion, u.id_usuario FROM usuario u CROSS JOIN clasificacion c
WHERE u.email='maria.lopez@email.es' AND c.codigo='PG' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='maria.lopez@email.es' AND pf.nombre_perfil='Sofía');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Invitados', 0, c.id_clasificacion, u.id_usuario FROM usuario u CROSS JOIN clasificacion c
WHERE u.email='maria.lopez@email.es' AND c.codigo='PG-13' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='maria.lopez@email.es' AND pf.nombre_perfil='Invitados');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 14.99, 'Tarjeta', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='maria.lopez@email.es' AND p.nombre_plan='Premium' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='maria.lopez@email.es');

-- María es muy activa, ha visto varias películas
INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -5, GETDATE()), 130, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Parasite'
WHERE u.email='maria.lopez@email.es' AND pf.nombre_perfil='María' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -3, GETDATE()), 152, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Amelie'
WHERE u.email='maria.lopez@email.es' AND pf.nombre_perfil='María' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -1, GETDATE()), 89, 0
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Spirited Away'
WHERE u.email='maria.lopez@email.es' AND pf.nombre_perfil='María' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO [reseña] (id_usuario, id_contenido, valoracion, comentario)
SELECT u.id_usuario, c.id_contenido, 10, 'Obra maestra del cine contemporáneo. Imprescindible.'
FROM usuario u JOIN contenido c ON c.titulo='Parasite'
WHERE u.email='maria.lopez@email.es' AND NOT EXISTS (SELECT 1 FROM [reseña] r JOIN usuario u2 ON r.id_usuario=u2.id_usuario WHERE u2.email='maria.lopez@email.es' AND r.id_contenido=c.id_contenido);

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='In the Mood for Love'
WHERE u.email='maria.lopez@email.es' AND pf.nombre_perfil='María' AND NOT EXISTS (SELECT 1 FROM lista_contenido lc WHERE lc.id_perfil=pf.id_perfil AND lc.id_contenido=c.id_contenido);

-- Usuario 2: Carlos Fernández (México) - Suscripción cancelada, sin actividad reciente
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Carlos', 'Fernández', 'carlos.f@gmail.com', 'hash_carlos', '1988-09-22', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'México' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='carlos.f@gmail.com');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Carlos', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='carlos.f@gmail.com' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='carlos.f@gmail.com' AND pf.nombre_perfil='Carlos');

INSERT INTO suscripcion (id_usuario, id_plan, fecha_inicio, fecha_fin, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, '2024-03-01', '2024-11-01', 9.99, 'Tarjeta', 'Cancelada'
FROM usuario u CROSS JOIN planes p
WHERE u.email='carlos.f@gmail.com' AND p.nombre_plan='Estandar' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='carlos.f@gmail.com');

-- Usuario 3: Yuki Tanaka (Japón) - Usuario activo Básico, 1 perfil, actividad moderada
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Yuki', 'Tanaka', 'yuki.tanaka@mail.jp', 'hash_yuki', '1992-11-30', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Japón' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='yuki.tanaka@mail.jp');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Yuki', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='yuki.tanaka@mail.jp' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='yuki.tanaka@mail.jp' AND pf.nombre_perfil='Yuki');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 5.99, 'PayPal', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='yuki.tanaka@mail.jp' AND p.nombre_plan='Basico' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='yuki.tanaka@mail.jp');

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -10, GETDATE()), 125, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Seven Samurai'
WHERE u.email='yuki.tanaka@mail.jp' AND pf.nombre_perfil='Yuki' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Rashomon'
WHERE u.email='yuki.tanaka@mail.jp' AND pf.nombre_perfil='Yuki' AND NOT EXISTS (SELECT 1 FROM lista_contenido lc WHERE lc.id_perfil=pf.id_perfil AND lc.id_contenido=c.id_contenido);

-- Usuario 4: Sophie Martin (Francia) - Suscripción pausada, tiene algo en su lista
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Sophie', 'Martin', 'sophie.martin@wanadoo.fr', 'hash_sophie', '1990-06-18', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Francia' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='sophie.martin@wanadoo.fr');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Sophie', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='sophie.martin@wanadoo.fr' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='sophie.martin@wanadoo.fr' AND pf.nombre_perfil='Sophie');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 9.99, 'Tarjeta', 'Pausada'
FROM usuario u CROSS JOIN planes p
WHERE u.email='sophie.martin@wanadoo.fr' AND p.nombre_plan='Estandar' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='sophie.martin@wanadoo.fr');

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Leon'
WHERE u.email='sophie.martin@wanadoo.fr' AND pf.nombre_perfil='Sophie' AND NOT EXISTS (SELECT 1 FROM lista_contenido lc WHERE lc.id_perfil=pf.id_perfil AND lc.id_contenido=c.id_contenido);

-- Usuario 5: Liam O'Brien (Irlanda) - Usuario muy activo, Premium, 2 perfiles, muchas reproducciones
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Liam', 'O''Brien', 'liam.obrien@eircom.ie', 'hash_liam', '1985-02-14', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Irlanda' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='liam.obrien@eircom.ie');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Liam', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='liam.obrien@eircom.ie' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='liam.obrien@eircom.ie' AND pf.nombre_perfil='Liam');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Sarah', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='liam.obrien@eircom.ie' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='liam.obrien@eircom.ie' AND pf.nombre_perfil='Sarah');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 14.99, 'Tarjeta', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='liam.obrien@eircom.ie' AND p.nombre_plan='Premium' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='liam.obrien@eircom.ie');

-- Liam ha visto muchas películas
INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -15, GETDATE()), 148, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Inception'
WHERE u.email='liam.obrien@eircom.ie' AND pf.nombre_perfil='Liam' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -12, GETDATE()), 146, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Goodfellas'
WHERE u.email='liam.obrien@eircom.ie' AND pf.nombre_perfil='Liam' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -8, GETDATE()), 153, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Inglourious Basterds'
WHERE u.email='liam.obrien@eircom.ie' AND pf.nombre_perfil='Liam' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -4, GETDATE()), 127, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Jurassic Park'
WHERE u.email='liam.obrien@eircom.ie' AND pf.nombre_perfil='Liam' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -2, GETDATE()), 45, 0
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='The Departed'
WHERE u.email='liam.obrien@eircom.ie' AND pf.nombre_perfil='Liam' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO [reseña] (id_usuario, id_contenido, valoracion, comentario)
SELECT u.id_usuario, c.id_contenido, 9, 'Nolan at his best. Mind-bending masterpiece.'
FROM usuario u JOIN contenido c ON c.titulo='Inception'
WHERE u.email='liam.obrien@eircom.ie' AND NOT EXISTS (SELECT 1 FROM [reseña] r JOIN usuario u2 ON r.id_usuario=u2.id_usuario WHERE u2.email='liam.obrien@eircom.ie' AND r.id_contenido=c.id_contenido);

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Blade Runner'
WHERE u.email='liam.obrien@eircom.ie' AND pf.nombre_perfil='Liam' AND NOT EXISTS (SELECT 1 FROM lista_contenido lc WHERE lc.id_perfil=pf.id_perfil AND lc.id_contenido=c.id_contenido);

-- Usuario 6: Min-ji Park (Corea del Sur) - Suscripción expirada
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Min-ji', 'Park', 'minji.park@naver.kr', 'hash_minji', '1998-07-25', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Corea del Sur' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='minji.park@naver.kr');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Min-ji', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='minji.park@naver.kr' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='minji.park@naver.kr' AND pf.nombre_perfil='Min-ji');

INSERT INTO suscripcion (id_usuario, id_plan, fecha_inicio, fecha_fin, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, '2024-01-01', '2024-10-31', 5.99, 'Tarjeta', 'Expirada'
FROM usuario u CROSS JOIN planes p
WHERE u.email='minji.park@naver.kr' AND p.nombre_plan='Basico' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='minji.park@naver.kr');

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, '2024-05-15', 132, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Oldboy'
WHERE u.email='minji.park@naver.kr' AND pf.nombre_perfil='Min-ji' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

-- Usuario 7: Roberto Silva (Brasil) - Usuario activo Estándar, actividad ligera
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Roberto', 'Silva', 'roberto.silva@uol.br', 'hash_roberto', '1993-03-08', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Brasil' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='roberto.silva@uol.br');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Roberto', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='roberto.silva@uol.br' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='roberto.silva@uol.br' AND pf.nombre_perfil='Roberto');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 9.99, 'Tarjeta', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='roberto.silva@uol.br' AND p.nombre_plan='Estandar' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='roberto.silva@uol.br');

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -20, GETDATE()), 130, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='City of God'
WHERE u.email='roberto.silva@uol.br' AND pf.nombre_perfil='Roberto' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Avatar'
WHERE u.email='roberto.silva@uol.br' AND pf.nombre_perfil='Roberto' AND NOT EXISTS (SELECT 1 FROM lista_contenido lc WHERE lc.id_perfil=pf.id_perfil AND lc.id_contenido=c.id_contenido);

-- Usuario 8: Emma Schmidt (Alemania) - Usuario nuevo con upgrade, auditoria de cambio de plan
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Emma', 'Schmidt', 'emma.schmidt@gmx.de', 'hash_emma', '1991-12-05', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Alemania' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='emma.schmidt@gmx.de');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Emma', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='emma.schmidt@gmx.de' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='emma.schmidt@gmx.de' AND pf.nombre_perfil='Emma');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Max', 1, c.id_clasificacion, u.id_usuario FROM usuario u CROSS JOIN clasificacion c
WHERE u.email='emma.schmidt@gmx.de' AND c.codigo='PG' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='emma.schmidt@gmx.de' AND pf.nombre_perfil='Max');

-- Emma comenzó con Básico pero hizo upgrade a Premium
INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 14.99, 'PayPal', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='emma.schmidt@gmx.de' AND p.nombre_plan='Premium' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='emma.schmidt@gmx.de');

INSERT INTO auditoria_suscripcion (id_usuario, id_plan_anterior, id_plan_nuevo, fecha_cambio, motivo)
SELECT u.id_usuario, p_old.id_plan, p_new.id_plan, DATEADD(day, -30, GETDATE()), 'Upgrade por mejor calidad de video'
FROM usuario u JOIN planes p_old ON p_old.nombre_plan='Basico' JOIN planes p_new ON p_new.nombre_plan='Premium'
WHERE u.email='emma.schmidt@gmx.de' AND NOT EXISTS (SELECT 1 FROM auditoria_suscripcion a JOIN usuario u2 ON a.id_usuario=u2.id_usuario WHERE u2.email='emma.schmidt@gmx.de');

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -6, GETDATE()), 115, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='E.T. The Extra-Terrestrial'
WHERE u.email='emma.schmidt@gmx.de' AND pf.nombre_perfil='Max' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

-- Usuario 9: Alessandro Rossi (Italia) - Usuario inactivo, sin reproducciones recientes
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Alessandro', 'Rossi', 'arossi@libero.it', 'hash_alessandro', '1987-08-19', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Italia' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='arossi@libero.it');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Alessandro', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='arossi@libero.it' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='arossi@libero.it' AND pf.nombre_perfil='Alessandro');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 9.99, 'Tarjeta', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='arossi@libero.it' AND p.nombre_plan='Estandar' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='arossi@libero.it');

-- Usuario 10: Priya Sharma (India) - Usuario activo, ama el cine mundial
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Priya', 'Sharma', 'priya.sharma@gmail.com', 'hash_priya', '1994-01-28', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'India' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='priya.sharma@gmail.com');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Priya', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='priya.sharma@gmail.com' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='priya.sharma@gmail.com' AND pf.nombre_perfil='Priya');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 9.99, 'Tarjeta', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='priya.sharma@gmail.com' AND p.nombre_plan='Estandar' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='priya.sharma@gmail.com');

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -7, GETDATE()), 115, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Pather Panchali'
WHERE u.email='priya.sharma@gmail.com' AND pf.nombre_perfil='Priya' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -3, GETDATE()), 133, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='A Separation'
WHERE u.email='priya.sharma@gmail.com' AND pf.nombre_perfil='Priya' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO [reseña] (id_usuario, id_contenido, valoracion, comentario)
SELECT u.id_usuario, c.id_contenido, 10, 'Ray''s masterpiece. Essential cinema history.'
FROM usuario u JOIN contenido c ON c.titulo='Pather Panchali'
WHERE u.email='priya.sharma@gmail.com' AND NOT EXISTS (SELECT 1 FROM [reseña] r JOIN usuario u2 ON r.id_usuario=u2.id_usuario WHERE u2.email='priya.sharma@gmail.com' AND r.id_contenido=c.id_contenido);

-- Usuario 11: Lars Nielsen (Dinamarca) - Suscripción cancelada recientemente
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Lars', 'Nielsen', 'lars.nielsen@hotmail.dk', 'hash_lars', '1986-05-11', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Dinamarca' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='lars.nielsen@hotmail.dk');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Lars', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='lars.nielsen@hotmail.dk' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='lars.nielsen@hotmail.dk' AND pf.nombre_perfil='Lars');

INSERT INTO suscripcion (id_usuario, id_plan, fecha_inicio, fecha_fin, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, '2024-02-01', DATEADD(day, -5, GETDATE()), 14.99, 'Tarjeta', 'Cancelada'
FROM usuario u CROSS JOIN planes p
WHERE u.email='lars.nielsen@hotmail.dk' AND p.nombre_plan='Premium' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='lars.nielsen@hotmail.dk');

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -25, GETDATE()), 131, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Breaking the Waves'
WHERE u.email='lars.nielsen@hotmail.dk' AND pf.nombre_perfil='Lars' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -20, GETDATE()), 136, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Melancholia'
WHERE u.email='lars.nielsen@hotmail.dk' AND pf.nombre_perfil='Lars' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

-- Usuario 12: Olivia Brown (Australia) - Usuario muy nuevo, poca actividad
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Olivia', 'Brown', 'olivia.brown@outlook.com.au', 'hash_olivia', '1997-10-03', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Australia' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='olivia.brown@outlook.com.au');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Olivia', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='olivia.brown@outlook.com.au' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='olivia.brown@outlook.com.au' AND pf.nombre_perfil='Olivia');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 5.99, 'Tarjeta', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='olivia.brown@outlook.com.au' AND p.nombre_plan='Basico' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='olivia.brown@outlook.com.au');

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -1, GETDATE()), 28, 0
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Mad Max'
WHERE u.email='olivia.brown@outlook.com.au' AND pf.nombre_perfil='Olivia' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

-- Usuario 13: Diego Pérez (Chile) - Usuario moderado, tiene familia
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Diego', 'Pérez', 'diego.perez@gmail.cl', 'hash_diego', '1989-07-07', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Chile' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='diego.perez@gmail.cl');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Diego', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='diego.perez@gmail.cl' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='diego.perez@gmail.cl' AND pf.nombre_perfil='Diego');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Familia', 1, c.id_clasificacion, u.id_usuario FROM usuario u CROSS JOIN clasificacion c
WHERE u.email='diego.perez@gmail.cl' AND c.codigo='PG-13' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='diego.perez@gmail.cl' AND pf.nombre_perfil='Familia');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 9.99, 'Tarjeta', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='diego.perez@gmail.cl' AND p.nombre_plan='Estandar' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='diego.perez@gmail.cl');

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -9, GETDATE()), 118, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='No'
WHERE u.email='diego.perez@gmail.cl' AND pf.nombre_perfil='Diego' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Jackie'
WHERE u.email='diego.perez@gmail.cl' AND pf.nombre_perfil='Diego' AND NOT EXISTS (SELECT 1 FROM lista_contenido lc WHERE lc.id_perfil=pf.id_perfil AND lc.id_contenido=c.id_contenido);

-- Usuario 14: Natasha Ivanova (Rusia) - Suscripción pausada, fan del cine europeo
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Natasha', 'Ivanova', 'natasha.ivanova@yandex.ru', 'hash_natasha', '1992-02-17', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Rusia' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='natasha.ivanova@yandex.ru');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Natasha', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='natasha.ivanova@yandex.ru' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='natasha.ivanova@yandex.ru' AND pf.nombre_perfil='Natasha');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 9.99, 'PayPal', 'Pausada'
FROM usuario u CROSS JOIN planes p
WHERE u.email='natasha.ivanova@yandex.ru' AND p.nombre_plan='Estandar' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='natasha.ivanova@yandex.ru');

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -40, GETDATE()), 150, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Solaris'
WHERE u.email='natasha.ivanova@yandex.ru' AND pf.nombre_perfil='Natasha' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -38, GETDATE()), 161, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Andrei Rublev'
WHERE u.email='natasha.ivanova@yandex.ru' AND pf.nombre_perfil='Natasha' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO [reseña] (id_usuario, id_contenido, valoracion, comentario)
SELECT u.id_usuario, c.id_contenido, 10, 'Tarkovsky''s genius. Slow but profound meditation on humanity.'
FROM usuario u JOIN contenido c ON c.titulo='Solaris'
WHERE u.email='natasha.ivanova@yandex.ru' AND NOT EXISTS (SELECT 1 FROM [reseña] r JOIN usuario u2 ON r.id_usuario=u2.id_usuario WHERE u2.email='natasha.ivanova@yandex.ru' AND r.id_contenido=c.id_contenido);

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Stalker'
WHERE u.email='natasha.ivanova@yandex.ru' AND pf.nombre_perfil='Natasha' AND NOT EXISTS (SELECT 1 FROM lista_contenido lc WHERE lc.id_perfil=pf.id_perfil AND lc.id_contenido=c.id_contenido);

-- Usuario 15: Ahmed Hassan (Turquía) - Usuario activo Premium, familia numerosa
INSERT INTO usuario (nombre, apellido, email, contraseña, fecha_nacimiento, id_pais, activo)
SELECT 'Ahmed', 'Hassan', 'ahmed.hassan@hotmail.com', 'hash_ahmed', '1984-11-22', p.id_pais, 1
FROM pais p WHERE p.nombre_pais = 'Turquía' AND NOT EXISTS (SELECT 1 FROM usuario WHERE email='ahmed.hassan@hotmail.com');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Ahmed', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='ahmed.hassan@hotmail.com' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Ahmed');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Fatima', 0, NULL, u.id_usuario FROM usuario u 
WHERE u.email='ahmed.hassan@hotmail.com' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Fatima');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Niños', 1, c.id_clasificacion, u.id_usuario FROM usuario u CROSS JOIN clasificacion c
WHERE u.email='ahmed.hassan@hotmail.com' AND c.codigo='PG' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Niños');

INSERT INTO perfil (nombre_perfil, es_infantil, id_clasificacion_max, id_usuario)
SELECT 'Adolescentes', 0, c.id_clasificacion, u.id_usuario FROM usuario u CROSS JOIN clasificacion c
WHERE u.email='ahmed.hassan@hotmail.com' AND c.codigo='PG-13' AND NOT EXISTS (SELECT 1 FROM perfil pf JOIN usuario u2 ON pf.id_usuario=u2.id_usuario WHERE u2.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Adolescentes');

INSERT INTO suscripcion (id_usuario, id_plan, precio_pagado, metodo_pago, estado)
SELECT u.id_usuario, p.id_plan, 14.99, 'Tarjeta', 'Activa'
FROM usuario u CROSS JOIN planes p
WHERE u.email='ahmed.hassan@hotmail.com' AND p.nombre_plan='Premium' AND NOT EXISTS (SELECT 1 FROM suscripcion s JOIN usuario u2 ON s.id_usuario=u2.id_usuario WHERE u2.email='ahmed.hassan@hotmail.com');

-- Ahmed y su familia ven contenido variado
INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -4, GETDATE()), 162, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='The Return of the King'
WHERE u.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Ahmed' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -3, GETDATE()), 125, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Spirited Away'
WHERE u.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Niños' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -2, GETDATE()), 151, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Avatar'
WHERE u.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Fatima' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO reproduccion (id_perfil, id_contenido, fecha_reproduccion, progreso_minutos, completado)
SELECT pf.id_perfil, c.id_contenido, DATEADD(day, -1, GETDATE()), 127, 1
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Jurassic Park'
WHERE u.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Adolescentes' AND NOT EXISTS (SELECT 1 FROM reproduccion r WHERE r.id_perfil=pf.id_perfil AND r.id_contenido=c.id_contenido);

INSERT INTO [reseña] (id_usuario, id_contenido, valoracion, comentario)
SELECT u.id_usuario, c.id_contenido, 10, 'Epic conclusion to the trilogy. Perfect for family viewing.'
FROM usuario u JOIN contenido c ON c.titulo='The Return of the King'
WHERE u.email='ahmed.hassan@hotmail.com' AND NOT EXISTS (SELECT 1 FROM [reseña] r JOIN usuario u2 ON r.id_usuario=u2.id_usuario WHERE u2.email='ahmed.hassan@hotmail.com' AND r.id_contenido=c.id_contenido);

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Princess Mononoke'
WHERE u.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Niños' AND NOT EXISTS (SELECT 1 FROM lista_contenido lc WHERE lc.id_perfil=pf.id_perfil AND lc.id_contenido=c.id_contenido);

INSERT INTO lista_contenido (id_perfil, id_contenido)
SELECT pf.id_perfil, c.id_contenido
FROM perfil pf JOIN usuario u ON pf.id_usuario=u.id_usuario JOIN contenido c ON c.titulo='Titanic'
WHERE u.email='ahmed.hassan@hotmail.com' AND pf.nombre_perfil='Fatima' AND NOT EXISTS (SELECT 1 FROM lista_contenido lc WHERE lc.id_perfil=pf.id_perfil AND lc.id_contenido=c.id_contenido);
