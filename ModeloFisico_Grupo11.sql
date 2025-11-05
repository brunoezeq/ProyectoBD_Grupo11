CREATE DATABASE FilmStream;
GO

USE FilmStream;
GO

CREATE TABLE tipo_contenido
(
  id_tipo_contenido INT NOT NULL,
  nombre_contenido VARCHAR(50) NOT NULL,
  CONSTRAINT pk_tipo_contenido PRIMARY KEY (id_tipo_contenido)
);

CREATE TABLE contenido
(
  id_contenido INT IDENTITY(1,1) NOT NULL,
  titulo VARCHAR(150) NOT NULL,
  sinopsis VARCHAR(300) NOT NULL,
  año_lanzamiento INT NOT NULL,
  duracion INT NOT NULL,
  id_tipo_contenido INT NOT NULL,
  CONSTRAINT pk_contenido PRIMARY KEY (id_contenido),
  CONSTRAINT fk_contenido_tipo_contenido FOREIGN KEY (id_tipo_contenido) REFERENCES tipo_contenido(id_tipo_contenido)
);

CREATE TABLE continente
(
  id_continente INT NOT NULL,
  nombre_continente VARCHAR(20) NOT NULL,
  CONSTRAINT pk_continente PRIMARY KEY (id_continente)
);

CREATE TABLE pais
(
  id_pais INT NOT NULL,
  nombre_pais VARCHAR(50) NOT NULL,
  id_continente INT NOT NULL,
  CONSTRAINT pk_pais PRIMARY KEY (id_pais),
  CONSTRAINT fk_pais_continente FOREIGN KEY (id_continente) REFERENCES continente(id_continente),
  CONSTRAINT uq_nombre_pais UNIQUE (nombre_pais)
);

CREATE TABLE director
(
  id_director INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  biografia VARCHAR(200) NOT NULL,
  id_pais INT NOT NULL,
  CONSTRAINT pk_director PRIMARY KEY (id_director),
  CONSTRAINT fk_director_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE actor
(
  id_actor INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  año_nacimiento DATE NOT NULL,
  biografia VARCHAR(200) NOT NULL,
  id_pais INT NOT NULL,
  CONSTRAINT pk_actor PRIMARY KEY (id_actor),
  CONSTRAINT fk_actor_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE genero
(
  id_genero INT IDENTITY(1,1) NOT NULL,
  nombre_genero VARCHAR(150) NOT NULL,
  CONSTRAINT pk_genero PRIMARY KEY (id_genero)
);

CREATE TABLE director_contenido
(
  id_director INT NOT NULL,
  id_contenido INT NOT NULL,
  CONSTRAINT pk_director_contenido PRIMARY KEY (id_director, id_contenido),
  CONSTRAINT fk_director_contenido_director FOREIGN KEY (id_director) REFERENCES director(id_director),
  CONSTRAINT fk_director_cotnenido_contenido FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido)
);

CREATE TABLE reparto
(
  es_protagonista BIT NOT NULL,
  nombre_personaje VARCHAR(50) NOT NULL,
  id_actor INT NOT NULL,
  id_contenido INT NOT NULL,
  CONSTRAINT pk_reparto PRIMARY KEY (id_actor, id_contenido),
  CONSTRAINT fk_reparto_actor FOREIGN KEY (id_actor) REFERENCES actor(id_actor),
  CONSTRAINT fk_reparto_cotenido FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido)
);

CREATE TABLE genero_contenido
(
  id_genero INT NOT NULL,
  id_contenido INT NOT NULL,
  CONSTRAINT pk_genero_contendio PRIMARY KEY (id_genero, id_contenido),
  CONSTRAINT fk_genero_contenido_genero FOREIGN KEY (id_genero) REFERENCES genero(id_genero),
  CONSTRAINT fk_genero_cotenido_contenido FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido)
);

CREATE TABLE usuario
(
  id_usuario INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  email VARCHAR(150) NOT NULL,
  fecha_registro DATE NOT NULL,
  id_pais INT NOT NULL,
  CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT fk_usuario_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais),
  CONSTRAINT uq_usuario_email UNIQUE (email)
);

CREATE TABLE reproduccion
(
  id_reproduccion INT IDENTITY(1,1) NOT NULL,
  fecha_reproduccion DATE NOT NULL,
  progreso_minutos INT NOT NULL,
  id_contenido INT NOT NULL,
  id_usuario INT NOT NULL,
  CONSTRAINT pk_reproduccion PRIMARY KEY (id_reproduccion),
  CONSTRAINT fk_reproduccion_contenido FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido),
  CONSTRAINT fk_reproduccion_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE reseña
(
  id_reseña INT IDENTITY(1,1) NOT NULL,
  fecha_reseña DATE NOT NULL,
  valoracion INT NOT NULL,
  id_contenido INT NOT NULL,
  id_usuario INT NOT NULL,
  CONSTRAINT pk_reseña PRIMARY KEY (id_reseña),
  CONSTRAINT fk_reseña_contenido FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido),
  CONSTRAINT fk_reseña_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE planes
(
  id_plan INT IDENTITY(1,1) NOT NULL,
  nombre_plan VARCHAR(150) NOT NULL,
  precio DECIMAL(5, 2) NOT NULL,
  cantidad_pantallas INT NOT NULL,
  resolucion_permitida VARCHAR(50) NOT NULL,
  CONSTRAINT pk_plan PRIMARY KEY (id_plan)
);

CREATE TABLE suscripcion
(
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  precio_pagado DECIMAL(10, 2) NOT NULL,
  id_usuario INT NOT NULL,
  id_plan INT NOT NULL,
  CONSTRAINT pk_suscripcion PRIMARY KEY (fecha_inicio, id_usuario),
  CONSTRAINT fk_suscripcion_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT fk_suscripcion_plan FOREIGN KEY (id_plan) REFERENCES planes(id_plan)
);

CREATE TABLE temporada
(
  id_temporada INT NOT NULL,
  nro_temporada INT NOT NULL,
  resumen VARCHAR(200) NOT NULL,
  id_contenido INT NOT NULL,
  CONSTRAINT pk_temporada PRIMARY KEY (id_temporada, id_contenido),
  CONSTRAINT fk_temporada_contenido FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido)
);

CREATE TABLE episodio
(
  id_episodio INT NOT NULL,
  titulo VARCHAR(150) NOT NULL,
  nro_episodio INT NOT NULL,
  duracion INT NOT NULL,
  resumen VARCHAR(200) NOT NULL,
  id_temporada INT NOT NULL,
  id_contenido INT NOT NULL,
  CONSTRAINT pk_episodio PRIMARY KEY (id_episodio),
  CONSTRAINT pk_episodio_temporada_contenido FOREIGN KEY (id_temporada, id_contenido) REFERENCES temporada(id_temporada, id_contenido),
  CONSTRAINT uq_episodio_numero UNIQUE (nro_episodio),
  CONSTRAINT uq_episodio_temporada_contenido UNIQUE (id_temporada, id_contenido)
);

CREATE TABLE perfil
(
  id_perfil INT IDENTITY(1,1) NOT NULL,
  nombre_perfil VARCHAR(150) NOT NULL,
  restriccion VARCHAR(150) NOT NULL,
  id_usuario INT NOT NULL,
  CONSTRAINT pk_perfil PRIMARY KEY (id_perfil),
  CONSTRAINT fk_perfil_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);