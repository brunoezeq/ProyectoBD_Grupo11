-- =============================================
-- BASE DE DATOS: FILMSTREAM
-- Descripcion: Base de datos para gestionar contenido audiovisual, usuarios, suscripciones y reproducción de contenido.
-- =============================================

CREATE DATABASE filmstream;
GO

USE filmstream;
GO

-- =============================================
-- TABLAS DE CATÁLOGO Y CONFIGURACIÓN
-- =============================================

-- Tabla: tipo_contenido
-- Propósito: Clasificar el contenido (Película, Serie, Documental, etc.)
CREATE TABLE tipo_contenido
(
  id_tipo_contenido INT IDENTITY(1,1) NOT NULL, 
  nombre_contenido VARCHAR(50) NOT NULL,
  CONSTRAINT pk_tipo_contenido PRIMARY KEY (id_tipo_contenido),
  CONSTRAINT uq_tipo_contenido_nombre UNIQUE (nombre_contenido)  -- restriccion para evitar duplicados
);

-- Tabla: clasificacion
-- Propósito: Rating de contenido (G, PG, PG-13, R, etc.)
CREATE TABLE clasificacion
(
  id_clasificacion INT IDENTITY(1,1) NOT NULL,
  codigo VARCHAR(10) NOT NULL,              -- Ej: "PG-13", "R", "TV-MA"
  descripcion VARCHAR(100) NOT NULL,        -- Descripción del rating
  edad_minima INT NOT NULL,                 -- Edad mínima recomendada
  CONSTRAINT pk_clasificacion PRIMARY KEY (id_clasificacion),
  CONSTRAINT uq_clasificacion_codigo UNIQUE (codigo),
  CONSTRAINT chk_clasificacion_edad CHECK (edad_minima >= 0 AND edad_minima <= 21)
);

-- =============================================
-- TABLAS DE GEOGRAFÍA
-- =============================================

-- Tabla: continente
-- Propósito: Almacenar continentes para jerarquía geográfica
CREATE TABLE continente
(
  id_continente INT IDENTITY(1,1) NOT NULL,
  nombre_continente VARCHAR(20) NOT NULL,
  CONSTRAINT pk_continente PRIMARY KEY (id_continente),
  CONSTRAINT uq_continente_nombre UNIQUE (nombre_continente)
);

-- Tabla: pais
-- Propósito: Almacenar países asociados a continentes
CREATE TABLE pais
(
  id_pais INT IDENTITY(1,1) NOT NULL,
  nombre_pais VARCHAR(50) NOT NULL,
  id_continente INT NOT NULL,
  CONSTRAINT pk_pais PRIMARY KEY (id_pais),
  CONSTRAINT fk_pais_continente FOREIGN KEY (id_continente) REFERENCES continente(id_continente),
  CONSTRAINT uq_nombre_pais UNIQUE (nombre_pais)
);

-- =============================================
-- TABLAS DE PERSONAS (ACTORES Y DIRECTORES)
-- =============================================

-- Tabla: director
-- Propósito: Información de directores de contenido
CREATE TABLE director
(
  id_director INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  biografia VARCHAR(500) NOT NULL,          
  id_pais INT NOT NULL,
  CONSTRAINT pk_director PRIMARY KEY (id_director),
  CONSTRAINT fk_director_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais),
  CONSTRAINT chk_director_fecha CHECK (fecha_nacimiento <= GETDATE())
);

-- Tabla: actor
-- Propósito: Información de actores
CREATE TABLE actor
(
  id_actor INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  biografia VARCHAR(500) NOT NULL,          
  id_pais INT NOT NULL,
  CONSTRAINT pk_actor PRIMARY KEY (id_actor),
  CONSTRAINT fk_actor_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais),
  CONSTRAINT chk_actor_fecha CHECK (fecha_nacimiento <= GETDATE())
);

-- =============================================
-- TABLAS DE CONTENIDO PRINCIPAL
-- =============================================

-- Tabla: genero
-- Propósito: Géneros de contenido (Acción, Drama, Comedia, etc.)
CREATE TABLE genero
(
  id_genero INT IDENTITY(1,1) NOT NULL,
  nombre_genero VARCHAR(50) NOT NULL,       
  CONSTRAINT pk_genero PRIMARY KEY (id_genero),
  CONSTRAINT uq_genero_nombre UNIQUE (nombre_genero)
);

-- Tabla: contenido
-- Propósito: Tabla principal de películas y series
CREATE TABLE contenido
(
  id_contenido INT IDENTITY(1,1) NOT NULL,
  titulo VARCHAR(150) NOT NULL,
  sinopsis VARCHAR(500) NOT NULL,           
  año_lanzamiento INT NOT NULL,
  duracion INT NULL,                    -- En minutos (para películas o NULL para las series)
  id_tipo_contenido INT NOT NULL,
  id_clasificacion INT NULL,                
  fecha_agregado DATETIME DEFAULT GETDATE(),
  CONSTRAINT pk_contenido PRIMARY KEY (id_contenido),
  CONSTRAINT fk_contenido_tipo_contenido FOREIGN KEY (id_tipo_contenido) 
    REFERENCES tipo_contenido(id_tipo_contenido),
  CONSTRAINT fk_contenido_clasificacion FOREIGN KEY (id_clasificacion) 
    REFERENCES clasificacion(id_clasificacion),
  CONSTRAINT chk_contenido_año CHECK (año_lanzamiento BETWEEN 1888 AND YEAR(GETDATE()) + 2),
  CONSTRAINT chk_contenido_duracion CHECK (duracion IS NULL OR duracion > 0)
);

-- =============================================
-- TABLAS DE RELACIÓN MANY-TO-MANY
-- =============================================

-- Tabla: director_contenido
-- Propósito: Relación entre directores y contenido (un contenido puede tener varios directores)
CREATE TABLE director_contenido
(
  id_director INT NOT NULL,
  id_contenido INT NOT NULL,
  CONSTRAINT pk_director_contenido PRIMARY KEY (id_director, id_contenido),
  CONSTRAINT fk_director_contenido_director FOREIGN KEY (id_director) 
    REFERENCES director(id_director),
  CONSTRAINT fk_director_contenido_contenido FOREIGN KEY (id_contenido) 
    REFERENCES contenido(id_contenido)
);

-- Tabla: reparto
-- Propósito: Relación entre actores y contenido con información del personaje
CREATE TABLE reparto
(
  id_actor INT NOT NULL,
  id_contenido INT NOT NULL,
  nombre_personaje VARCHAR(100) NOT NULL,   
  es_protagonista BIT NOT NULL DEFAULT 0,
  orden_creditos INT NULL,                  
  CONSTRAINT pk_reparto PRIMARY KEY (id_actor, id_contenido),
  CONSTRAINT fk_reparto_actor FOREIGN KEY (id_actor) REFERENCES actor(id_actor),
  CONSTRAINT fk_reparto_contenido FOREIGN KEY (id_contenido) 
    REFERENCES contenido(id_contenido),
  CONSTRAINT chk_reparto_orden CHECK (orden_creditos > 0)
);

-- Tabla: genero_contenido
-- Propósito: Relación entre géneros y contenido (un contenido puede tener varios géneros)
CREATE TABLE genero_contenido
(
  id_genero INT NOT NULL,
  id_contenido INT NOT NULL,
  CONSTRAINT pk_genero_contenido PRIMARY KEY (id_genero, id_contenido), 
  CONSTRAINT fk_genero_contenido_genero FOREIGN KEY (id_genero) 
    REFERENCES genero(id_genero),
  CONSTRAINT fk_genero_contenido_contenido FOREIGN KEY (id_contenido) 
    REFERENCES contenido(id_contenido)
);

-- =============================================
-- TABLAS DE SERIES (TEMPORADAS Y EPISODIOS)
-- =============================================

-- Tabla: temporada
-- Propósito: Temporadas de series
CREATE TABLE temporada
(
  id_temporada INT IDENTITY(1,1) NOT NULL, 
  nro_temporada INT NOT NULL,
  resumen VARCHAR(500) NOT NULL,           
  fecha_lanzamiento DATE NULL,              
  id_contenido INT NOT NULL,
  CONSTRAINT pk_temporada PRIMARY KEY (id_temporada),  
  CONSTRAINT fk_temporada_contenido FOREIGN KEY (id_contenido) 
    REFERENCES contenido(id_contenido),
  CONSTRAINT uq_temporada_nro UNIQUE (nro_temporada, id_contenido),  -- restriccion para evitar duplicados
  CONSTRAINT chk_temporada_nro CHECK (nro_temporada > 0)
);

-- Tabla: episodio
-- Propósito: Episodios de cada temporada
CREATE TABLE episodio
(
  id_episodio INT IDENTITY(1,1) NOT NULL,   
  titulo VARCHAR(150) NOT NULL,
  nro_episodio INT NOT NULL,
  duracion INT NOT NULL,                    -- en minutos
  resumen VARCHAR(500) NOT NULL,            
  fecha_lanzamiento DATE NULL,              
  id_temporada INT NOT NULL,
  CONSTRAINT pk_episodio PRIMARY KEY (id_episodio),
  CONSTRAINT fk_episodio_temporada FOREIGN KEY (id_temporada)  
    REFERENCES temporada(id_temporada),
  CONSTRAINT uq_episodio_nro_temporada UNIQUE (nro_episodio, id_temporada),  
  CONSTRAINT chk_episodio_nro CHECK (nro_episodio > 0),
  CONSTRAINT chk_episodio_duracion CHECK (duracion > 0)
);

-- =============================================
-- TABLAS DE USUARIOS Y PERFILES
-- =============================================

-- Tabla: usuario
-- Propósito: Información de usuarios de la plataforma
CREATE TABLE usuario
(
  id_usuario INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  email VARCHAR(150) NOT NULL,
  contraseña VARCHAR(255) NOT NULL,          
  fecha_registro DATETIME NOT NULL DEFAULT GETDATE(),   
  fecha_nacimiento DATE NULL,                
  id_pais INT NOT NULL,
  activo BIT NOT NULL DEFAULT 1,             
  CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT fk_usuario_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais),
  CONSTRAINT uq_usuario_email UNIQUE (email),
  CONSTRAINT chk_usuario_email CHECK (email LIKE '%@%.%')
);

-- Tabla: perfil
-- Propósito: Perfiles dentro de una cuenta de usuario
CREATE TABLE perfil
(
  id_perfil INT IDENTITY(1,1) NOT NULL,
  nombre_perfil VARCHAR(50) NOT NULL,        
  es_infantil BIT NOT NULL DEFAULT 0,       
  id_clasificacion_max INT NULL,             
  id_usuario INT NOT NULL,
  CONSTRAINT pk_perfil PRIMARY KEY (id_perfil),
  CONSTRAINT fk_perfil_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT fk_perfil_clasificacion FOREIGN KEY (id_clasificacion_max) 
    REFERENCES clasificacion(id_clasificacion)
);

-- =============================================
-- TABLAS DE PLANES Y SUSCRIPCIONES
-- =============================================

-- Tabla: planes
-- Propósito: Planes de suscripción disponibles
CREATE TABLE planes
(
  id_plan INT IDENTITY(1,1) NOT NULL,
  nombre_plan VARCHAR(50) NOT NULL,         
  descripcion VARCHAR(200) NULL,            
  precio DECIMAL(10, 2) NOT NULL,            
  cantidad_pantallas INT NOT NULL,
  resolucion_permitida VARCHAR(20) NOT NULL,  
  activo BIT NOT NULL DEFAULT 1,             -- para indicar si el plan esta disponible
  CONSTRAINT pk_plan PRIMARY KEY (id_plan),
  CONSTRAINT uq_plan_nombre UNIQUE (nombre_plan),
  CONSTRAINT chk_planes_precio CHECK (precio > 0),
  CONSTRAINT chk_planes_pantallas CHECK (cantidad_pantallas > 0 AND cantidad_pantallas <= 10)
);

-- Tabla: suscripcion
-- Propósito: Historial de suscripciones de usuarios
CREATE TABLE suscripcion
(
  id_suscripcion INT IDENTITY(1,1) NOT NULL,  
  id_usuario INT NOT NULL,
  id_plan INT NOT NULL,
  fecha_inicio DATETIME NOT NULL DEFAULT GETDATE(),   
  fecha_fin DATETIME NULL,                  -- NULL = suscripción activa
  precio_pagado DECIMAL(10, 2) NOT NULL,
  metodo_pago VARCHAR(50) NULL,             -- Tarjeta, PayPal, etc.
  estado VARCHAR(20) NOT NULL DEFAULT 'Activa',  
  CONSTRAINT pk_suscripcion PRIMARY KEY (id_suscripcion),   
  CONSTRAINT fk_suscripcion_usuario FOREIGN KEY (id_usuario) 
    REFERENCES usuario(id_usuario),
  CONSTRAINT fk_suscripcion_plan FOREIGN KEY (id_plan) REFERENCES planes(id_plan),
  CONSTRAINT chk_suscripcion_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
  CONSTRAINT chk_suscripcion_precio CHECK (precio_pagado >= 0),
  CONSTRAINT chk_suscripcion_estado CHECK (estado IN ('Activa', 'Cancelada', 'Expirada', 'Pausada'))
);

-- Tabla: auditoria_suscripcion
-- Propósito: Registro de cambios en suscripciones
CREATE TABLE auditoria_suscripcion
(
  id_auditoria INT IDENTITY(1,1) NOT NULL,
  id_usuario INT NOT NULL,
  id_plan_anterior INT NULL,
  id_plan_nuevo INT NOT NULL,
  fecha_cambio DATETIME NOT NULL DEFAULT GETDATE(),
  motivo VARCHAR(200) NULL,
  CONSTRAINT pk_auditoria_suscripcion PRIMARY KEY (id_auditoria),
  CONSTRAINT fk_auditoria_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT fk_auditoria_plan_anterior FOREIGN KEY (id_plan_anterior) REFERENCES planes(id_plan),
  CONSTRAINT fk_auditoria_plan_nuevo FOREIGN KEY (id_plan_nuevo) REFERENCES planes(id_plan)
);

-- =============================================
-- TABLAS DE INTERACCIÓN CON CONTENIDO
-- =============================================

-- Tabla: reproduccion
-- Propósito: Registro de reproducciones de contenido
CREATE TABLE reproduccion
(
  id_reproduccion INT IDENTITY(1,1) NOT NULL,
  id_perfil INT NOT NULL,                    
  id_contenido INT NULL,                    -- Para películas
  id_episodio INT NULL,                     -- Para episodios de series
  fecha_reproduccion DATETIME NOT NULL DEFAULT GETDATE(),   
  progreso_minutos INT NOT NULL DEFAULT 0,
  completado BIT NOT NULL DEFAULT 0,         -- indica si el usuario termino de ver el contenido
  CONSTRAINT pk_reproduccion PRIMARY KEY (id_reproduccion),
  CONSTRAINT fk_reproduccion_perfil FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil),
  CONSTRAINT fk_reproduccion_contenido FOREIGN KEY (id_contenido) 
    REFERENCES contenido(id_contenido),
  CONSTRAINT fk_reproduccion_episodio FOREIGN KEY (id_episodio) 
    REFERENCES episodio(id_episodio),
  CONSTRAINT chk_reproduccion_progreso CHECK (progreso_minutos >= 0),
  CONSTRAINT chk_reproduccion_tipo CHECK (
    (id_contenido IS NOT NULL AND id_episodio IS NULL) OR 
    (id_contenido IS NULL AND id_episodio IS NOT NULL)
  )
);

-- Tabla: reseña
-- Propósito: Reseñas y valoraciones de usuarios
CREATE TABLE reseña
(
  id_reseña INT IDENTITY(1,1) NOT NULL,
  id_usuario INT NOT NULL,
  id_contenido INT NOT NULL,
  valoracion INT NOT NULL,                  -- escala 1-10
  comentario VARCHAR(1000) NULL,             
  fecha_reseña DATETIME NOT NULL DEFAULT GETDATE(),   
  util_positivos INT NOT NULL DEFAULT 0,    -- voto "like"
  util_negativos INT NOT NULL DEFAULT 0,    -- voto "dislike"
  CONSTRAINT pk_reseña PRIMARY KEY (id_reseña),
  CONSTRAINT fk_reseña_contenido FOREIGN KEY (id_contenido) 
    REFERENCES contenido(id_contenido),
  CONSTRAINT fk_reseña_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT uq_reseña_usuario_contenido UNIQUE (id_usuario, id_contenido),  -- restriccion que permite una reseña por usuario para un mismo contenido
  CONSTRAINT chk_reseña_valoracion CHECK (valoracion BETWEEN 1 AND 10),
  CONSTRAINT chk_reseña_util CHECK (util_positivos >= 0 AND util_negativos >= 0)
);

-- Tabla: lista_contenido
-- Propósito: Lista de favoritos/watchlist de usuarios
CREATE TABLE lista_contenido
(
  id_lista INT IDENTITY(1,1) NOT NULL,       
  id_perfil INT NOT NULL,                   -- identificamos por perfil, no por usuario
  id_contenido INT NOT NULL,
  fecha_agregado DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT pk_lista_contenido PRIMARY KEY (id_lista),
  CONSTRAINT fk_lista_perfil FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil),
  CONSTRAINT fk_lista_contenido FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido),
  CONSTRAINT uq_lista_perfil_contenido UNIQUE (id_perfil, id_contenido)
);

-- ===== Restricciones Adicionales =====

-- Evita duplicar un contenido con mismo título, año y tipo (p.ej.,
-- permite por ej; "It" película 2017 y "It" serie 2017 solo si cambia el tipo).
ALTER TABLE contenido
ADD CONSTRAINT uq_contenido_titulo_anio_tipo UNIQUE (titulo, [año_lanzamiento], id_tipo_contenido);

-- Define identidad única de actores por nombre+apellido+fecha+pais para
-- evitar duplicar la misma persona con pequeñas variaciones.
ALTER TABLE actor
ADD CONSTRAINT uq_actor_identidad UNIQUE (nombre, apellido, fecha_nacimiento, id_pais);

-- Define identidad única de directores por nombre+apellido+fecha+pais
-- previniendo registros duplicados de la misma persona.
ALTER TABLE director
ADD CONSTRAINT uq_director_identidad UNIQUE (nombre, apellido, fecha_nacimiento, id_pais);

-- Impide que un usuario tenga dos perfiles con el mismo nombre.
ALTER TABLE perfil
ADD CONSTRAINT uq_perfil_nombre_por_usuario UNIQUE (id_usuario, nombre_perfil);

-- ===== Checks de dominio =====

-- Restringe los valores posibles de la resolución a un conjunto conocido.
ALTER TABLE planes
ADD CONSTRAINT chk_planes_resolucion CHECK (resolucion_permitida IN ('480p', '720p', '1080p', '2160p'));

-- Evita títulos vacíos o con solo espacios.
ALTER TABLE contenido
ADD CONSTRAINT chk_contenido_titulo_no_vacio CHECK (LEN(LTRIM(RTRIM(titulo))) > 0);

-- Evita nombres de personaje vacíos o con solo espacios en el reparto.
ALTER TABLE reparto
ADD CONSTRAINT chk_reparto_personaje_no_vacio CHECK (LEN(LTRIM(RTRIM(nombre_personaje))) > 0);

-- Garantiza coherencia entre el estado de la suscripción y su fecha_fin:
-- Activa/Pausada no deben tener fecha_fin; Cancelada/Expirada sí deben tenerla.
ALTER TABLE suscripcion
ADD CONSTRAINT chk_suscripcion_estado_fechafin CHECK (
  (estado IN ('Activa','Pausada') AND fecha_fin IS NULL)
  OR
  (estado IN ('Cancelada','Expirada') AND fecha_fin IS NOT NULL)
);

-- Evita espacios dentro del email, que son inválidos.
ALTER TABLE usuario
ADD CONSTRAINT chk_usuario_email_sin_espacios CHECK (CHARINDEX(' ', email) = 0);

-- ===== Cascadas para evitar huerfanos (relaciones dependientes) =====

-- temporada -> contenido
-- Si se elimina un contenido (serie), elimina automáticamente sus temporadas
-- asociadas, evitando registros temporada huérfanos.
ALTER TABLE temporada DROP CONSTRAINT fk_temporada_contenido;
ALTER TABLE temporada
  ADD CONSTRAINT fk_temporada_contenido
  FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido) ON DELETE CASCADE;

-- episodio -> temporada
-- Si se elimina una temporada, se eliminan automáticamente sus episodios.
ALTER TABLE episodio DROP CONSTRAINT fk_episodio_temporada;
ALTER TABLE episodio
  ADD CONSTRAINT fk_episodio_temporada
  FOREIGN KEY (id_temporada) REFERENCES temporada(id_temporada) ON DELETE CASCADE;

-- director_contenido -> director/contenido
-- Si se elimina un director o un contenido, elimina la fila puente correspondiente
-- para evitar relaciones many-to-many huérfanas.
ALTER TABLE director_contenido DROP CONSTRAINT fk_director_contenido_director;
ALTER TABLE director_contenido DROP CONSTRAINT fk_director_contenido_contenido;
ALTER TABLE director_contenido
  ADD CONSTRAINT fk_director_contenido_director
  FOREIGN KEY (id_director) REFERENCES director(id_director) ON DELETE CASCADE;
ALTER TABLE director_contenido
  ADD CONSTRAINT fk_director_contenido_contenido
  FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido) ON DELETE CASCADE;

-- genero_contenido -> genero/contenido
-- Si se elimina un género o un contenido, elimina la fila puente correspondiente
-- evitando combinaciones género-contenido huérfanas.
ALTER TABLE genero_contenido DROP CONSTRAINT fk_genero_contenido_genero;
ALTER TABLE genero_contenido DROP CONSTRAINT fk_genero_contenido_contenido;
ALTER TABLE genero_contenido
  ADD CONSTRAINT fk_genero_contenido_genero
  FOREIGN KEY (id_genero) REFERENCES genero(id_genero) ON DELETE CASCADE;
ALTER TABLE genero_contenido
  ADD CONSTRAINT fk_genero_contenido_contenido
  FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido) ON DELETE CASCADE;

-- reparto -> actor/contenido
-- Si se elimina un actor o un contenido, remueve la participación correspondiente
-- en el reparto para no dejar referencias inválidas.
ALTER TABLE reparto DROP CONSTRAINT fk_reparto_actor;
ALTER TABLE reparto DROP CONSTRAINT fk_reparto_contenido;
ALTER TABLE reparto
  ADD CONSTRAINT fk_reparto_actor
  FOREIGN KEY (id_actor) REFERENCES actor(id_actor) ON DELETE CASCADE;
ALTER TABLE reparto
  ADD CONSTRAINT fk_reparto_contenido
  FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido) ON DELETE CASCADE;

-- reseña -> usuario/contenido
-- Si se elimina un usuario o un contenido, elimina su reseña asociada para
-- mantener la integridad (una reseña no puede existir sin su autor ni su contenido).
ALTER TABLE [reseña] DROP CONSTRAINT [fk_reseña_usuario];
ALTER TABLE [reseña] DROP CONSTRAINT [fk_reseña_contenido];
ALTER TABLE [reseña]
  ADD CONSTRAINT fk_resena_usuario
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE;
ALTER TABLE [reseña]
  ADD CONSTRAINT fk_resena_contenido
  FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido) ON DELETE CASCADE;

-- lista_contenido -> perfil/contenido
-- Si se elimina un perfil o un contenido, elimina la entrada de la lista
-- correspondiente para no dejar ítems favoritos/watchlist huérfanos.
ALTER TABLE lista_contenido DROP CONSTRAINT fk_lista_perfil;
ALTER TABLE lista_contenido DROP CONSTRAINT fk_lista_contenido;
ALTER TABLE lista_contenido
  ADD CONSTRAINT fk_lista_perfil
  FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil) ON DELETE CASCADE;
ALTER TABLE lista_contenido
  ADD CONSTRAINT fk_lista_contenido
  FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido) ON DELETE CASCADE;

-- reproduccion -> perfil/contenido/episodio
-- Aqui usamos NO ACTION para evitar ciclos de cascada múltiple.
-- 
-- Explicacion del problema:
-- - Si eliminamos un 'contenido' (película o serie), SQL Server detecta DOS rutas hacia 'reproduccion':
--   1. Directa: contenido → reproduccion
--   2. Indirecta: contenido → temporada → episodio → reproduccion
-- 
-- - Esto genera un conflicto de "multiple cascade paths" que SQL Server rechaza.

ALTER TABLE reproduccion DROP CONSTRAINT fk_reproduccion_perfil;
ALTER TABLE reproduccion DROP CONSTRAINT fk_reproduccion_contenido;
ALTER TABLE reproduccion DROP CONSTRAINT fk_reproduccion_episodio;

ALTER TABLE reproduccion
  ADD CONSTRAINT fk_reproduccion_perfil
  FOREIGN KEY (id_perfil) REFERENCES perfil(id_perfil) ON DELETE NO ACTION;

ALTER TABLE reproduccion
  ADD CONSTRAINT fk_reproduccion_contenido
  FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido) ON DELETE NO ACTION;

ALTER TABLE reproduccion
  ADD CONSTRAINT fk_reproduccion_episodio
  FOREIGN KEY (id_episodio) REFERENCES episodio(id_episodio) ON DELETE NO ACTION;

-- suscripcion -> usuario (cascade), plan (restrict)
-- Si se elimina un usuario, también se eliminan sus suscripciones.
-- El vínculo a plan se mantiene sin cascada para preservar el catálogo de planes
-- aunque existan suscripciones históricas que lo referencien.
ALTER TABLE suscripcion DROP CONSTRAINT fk_suscripcion_usuario;
ALTER TABLE suscripcion
  ADD CONSTRAINT fk_suscripcion_usuario
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE;

