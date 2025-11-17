## Diccionario de datos - FilmStream

### Características de la Tabla
- **Nombre**: tipo_contenido
- **Descripción**: Almacena los tipos de contenido disponibles (película, serie, documental, etc.)

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_tipo_contenido | int | - | Identificación única del tipo de contenido |
| nombre_contenido | varchar | 50 | Nombre del tipo de contenido |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_tipo_contenido | PRIMARY KEY |
| nombre_contenido | UNIQUE |

---

### Características de la Tabla
- **Nombre**: clasificacion
- **Descripción**: Almacena los ratings de contenido (G, PG, PG-13, R, etc.)

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_clasificacion | int | - | Identificación única de clasificación |
| codigo | varchar | 10 | Código del rating (ej: "PG-13") |
| descripcion | varchar | 100 | Descripción del rating |
| edad_minima | int | - | Edad mínima recomendada |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_clasificacion | PRIMARY KEY |
| codigo | UNIQUE |
| edad_minima | CHECK (0-21) |

---

### Características de la Tabla
- **Nombre**: continente
- **Descripción**: Almacena los continentes para la jerarquía geográfica

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_continente | int | - | Identificación única de continente |
| nombre_continente | varchar | 20 | Nombre del continente |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_continente | PRIMARY KEY |
| nombre_continente | UNIQUE |

---

### Características de la Tabla
- **Nombre**: pais
- **Descripción**: Almacena los países asociados a continentes

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_pais | int | - | Identificación única de país |
| nombre_pais | varchar | 50 | Nombre del país |
| id_continente | int | - | Continente al que pertenece |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_pais | PRIMARY KEY |
| nombre_pais | UNIQUE |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_continente | continente |

---

### Características de la Tabla
- **Nombre**: director
- **Descripción**: Almacena información de los directores de contenido

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_director | int | - | Identificación única de director |
| nombre | varchar | 50 | Nombre del director |
| apellido | varchar | 50 | Apellido del director |
| fecha_nacimiento | date | - | Fecha de nacimiento |
| biografia | varchar | 500 | Biografía del director |
| id_pais | int | - | País de origen |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_director | PRIMARY KEY |
| nombre, apellido, fecha_nacimiento, id_pais | UNIQUE |
| fecha_nacimiento | CHECK (fecha <= actual) |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_pais | pais |

---

### Características de la Tabla
- **Nombre**: actor
- **Descripción**: Almacena información de los actores

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_actor | int | - | Identificación única de actor |
| nombre | varchar | 50 | Nombre del actor |
| apellido | varchar | 50 | Apellido del actor |
| fecha_nacimiento | date | - | Fecha de nacimiento |
| biografia | varchar | 500 | Biografía del actor |
| id_pais | int | - | País de origen |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_actor | PRIMARY KEY |
| nombre, apellido, fecha_nacimiento, id_pais | UNIQUE |
| fecha_nacimiento | CHECK (fecha <= actual) |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_pais | pais |

---

### Características de la Tabla
- **Nombre**: genero
- **Descripción**: Almacena los géneros de contenido (Acción, Drama, Comedia, etc.)

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_genero | int | - | Identificación única de género |
| nombre_genero | varchar | 50 | Nombre del género |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_genero | PRIMARY KEY |
| nombre_genero | UNIQUE |

---

### Características de la Tabla
- **Nombre**: contenido
- **Descripción**: Tabla principal de películas y series

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_contenido | int | - | Identificación única de contenido |
| titulo | varchar | 150 | Título del contenido |
| sinopsis | varchar | 500 | Sinopsis del contenido |
| año_lanzamiento | int | - | Año de lanzamiento |
| duracion | int | - | Duración en minutos (NULL para series) |
| id_tipo_contenido | int | - | Tipo de contenido |
| id_clasificacion | int | - | Clasificación por edad |
| fecha_agregado | datetime | - | Fecha de agregado a plataforma |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_contenido | PRIMARY KEY |
| titulo, año_lanzamiento, id_tipo_contenido | UNIQUE |
| año_lanzamiento | CHECK (1888-año actual+2) |
| duracion | CHECK (NULL o >0) |
| titulo | CHECK (no vacío) |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_tipo_contenido | tipo_contenido |
| id_clasificacion | clasificacion |

---

### Características de la Tabla
- **Nombre**: director_contenido
- **Descripción**: Relación muchos a muchos entre directores y contenido

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_director | int | - | Identificación única de director |
| id_contenido | int | - | Identificación única de contenido |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_director, id_contenido | PRIMARY KEY COMPUESTA |

#### Claves Foráneas
| Campo | Entidad asociada | Eliminación |
|---|---|---|
| id_director | director | CASCADE |
| id_contenido | contenido | CASCADE |

---

### Características de la Tabla
- **Nombre**: reparto
- **Descripción**: Relación entre actores y contenido con información del personaje

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_actor | int | - | Identificación única de actor |
| id_contenido | int | - | Identificación única de contenido |
| nombre_personaje | varchar | 100 | Nombre del personaje |
| es_protagonista | bit | - | Indica si es protagonista |
| orden_creditos | int | - | Orden de aparición en créditos |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_actor, id_contenido | PRIMARY KEY COMPUESTA |
| orden_creditos | CHECK (>0) |
| nombre_personaje | CHECK (no vacío) |

#### Claves Foráneas
| Campo | Entidad asociada | Eliminación |
|---|---|---|
| id_actor | actor | CASCADE |
| id_contenido | contenido | CASCADE |

---

### Características de la Tabla
- **Nombre**: genero_contenido
- **Descripción**: Relación muchos a muchos entre géneros y contenido

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_genero | int | - | Identificación única de género |
| id_contenido | int | - | Identificación única de contenido |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_genero, id_contenido | PRIMARY KEY COMPUESTA |

#### Claves Foráneas
| Campo | Entidad asociada | Eliminación |
|---|---|---|
| id_genero | genero | CASCADE |
| id_contenido | contenido | CASCADE |

---

### Características de la Tabla
- **Nombre**: temporada
- **Descripción**: Almacena las temporadas de las series

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_temporada | int | - | Identificación única de temporada |
| nro_temporada | int | - | Número de temporada |
| resumen | varchar | 500 | Resumen de la temporada |
| fecha_lanzamiento | date | - | Fecha de lanzamiento |
| id_contenido | int | - | Serie a la que pertenece |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_temporada | PRIMARY KEY |
| nro_temporada, id_contenido | UNIQUE |
| nro_temporada | CHECK (>0) |

#### Claves Foráneas
| Campo | Entidad asociada | Eliminación |
|---|---|---|
| id_contenido | contenido | CASCADE |

---

### Características de la Tabla
- **Nombre**: episodio
- **Descripción**: Almacena los episodios de cada temporada

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_episodio | int | - | Identificación única de episodio |
| titulo | varchar | 150 | Título del episodio |
| nro_episodio | int | - | Número del episodio |
| duracion | int | - | Duración en minutos |
| resumen | varchar | 500 | Resumen del episodio |
| fecha_lanzamiento | date | - | Fecha de lanzamiento |
| id_temporada | int | - | Temporada a la que pertenece |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_episodio | PRIMARY KEY |
| nro_episodio, id_temporada | UNIQUE |
| nro_episodio | CHECK (>0) |
| duracion | CHECK (>0) |

#### Claves Foráneas
| Campo | Entidad asociada | Eliminación |
|---|---|---|
| id_temporada | temporada | CASCADE |

---

### Características de la Tabla
- **Nombre**: usuario
- **Descripción**: Almacena información de los usuarios de la plataforma

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_usuario | int | - | Identificación única de usuario |
| nombre | varchar | 50 | Nombre del usuario |
| apellido | varchar | 50 | Apellido del usuario |
| email | varchar | 150 | Email del usuario |
| contraseña | varchar | 255 | Hash de contraseña |
| fecha_registro | datetime | - | Fecha de registro |
| fecha_nacimiento | date | - | Fecha de nacimiento |
| id_pais | int | - | País de residencia |
| activo | bit | - | Estado de la cuenta |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_usuario | PRIMARY KEY |
| email | UNIQUE |
| email | CHECK (formato válido) |
| email | CHECK (sin espacios) |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_pais | pais |

---

### Características de la Tabla
- **Nombre**: perfil
- **Descripción**: Almacena los perfiles dentro de una cuenta de usuario

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_perfil | int | - | Identificación única de perfil |
| nombre_perfil | varchar | 50 | Nombre del perfil |
| es_infantil | bit | - | Indica si es perfil infantil |
| id_clasificacion_max | int | - | Clasificación máxima permitida |
| id_usuario | int | - | Usuario dueño del perfil |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_perfil | PRIMARY KEY |
| id_usuario, nombre_perfil | UNIQUE |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_usuario | usuario |
| id_clasificacion_max | clasificacion |

---

### Características de la Tabla
- **Nombre**: planes
- **Descripción**: Almacena los planes de suscripción disponibles

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_plan | int | - | Identificación única de plan |
| nombre_plan | varchar | 50 | Nombre del plan |
| descripcion | varchar | 200 | Descripción del plan |
| precio | decimal | 10,2 | Precio del plan |
| cantidad_pantallas | int | - | Cantidad de pantallas permitidas |
| resolucion_permitida | varchar | 20 | Resolución máxima permitida |
| activo | bit | - | Estado del plan |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_plan | PRIMARY KEY |
| nombre_plan | UNIQUE |
| precio | CHECK (>0) |
| cantidad_pantallas | CHECK (1-10) |
| resolucion_permitida | CHECK (480p,720p,1080p,2160p) |

---

### Características de la Tabla
- **Nombre**: suscripcion
- **Descripción**: Almacena el historial de suscripciones de usuarios

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_suscripcion | int | - | Identificación única de suscripción |
| id_usuario | int | - | Usuario suscripto |
| id_plan | int | - | Plan contratado |
| fecha_inicio | datetime | - | Fecha de inicio |
| fecha_fin | datetime | - | Fecha de fin (NULL si activa) |
| precio_pagado | decimal | 10,2 | Precio pagado |
| metodo_pago | varchar | 50 | Método de pago |
| estado | varchar | 20 | Estado de suscripción |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_suscripcion | PRIMARY KEY |
| estado | CHECK (Activa,Cancelada,Expirada,Pausada) |
| precio_pagado | CHECK (>=0) |
| fecha_fin | CHECK (NULL o >= fecha_inicio) |
| estado, fecha_fin | CHECK (coherencia) |

#### Claves Foráneas
| Campo | Entidad asociada | Eliminación |
|---|---|---|
| id_usuario | usuario | CASCADE |
| id_plan | planes | - |

---

### Características de la Tabla
- **Nombre**: auditoria_suscripcion
- **Descripción**: Registra los cambios en las suscripciones

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_auditoria | int | - | Identificación única de auditoría |
| id_usuario | int | - | Usuario auditado |
| id_plan_anterior | int | - | Plan anterior |
| id_plan_nuevo | int | - | Plan nuevo |
| fecha_cambio | datetime | - | Fecha del cambio |
| motivo | varchar | 200 | Motivo del cambio |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_auditoria | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_usuario | usuario |
| id_plan_anterior | planes |
| id_plan_nuevo | planes |

---

### Características de la Tabla
- **Nombre**: reproduccion
- **Descripción**: Registra las reproducciones de contenido

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_reproduccion | int | - | Identificación única de reproducción |
| id_perfil | int | - | Perfil que reprodujo |
| id_contenido | int | - | Contenido reproducido (película) |
| id_episodio | int | - | Episodio reproducido (serie) |
| fecha_reproduccion | datetime | - | Fecha de reproducción |
| progreso_minutos | int | - | Minutos vistos |
| completado | bit | - | Indica si se completó |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_reproduccion | PRIMARY KEY |
| progreso_minutos | CHECK (>=0) |
| id_contenido, id_episodio | CHECK (solo uno no nulo) |

#### Claves Foráneas
| Campo | Entidad asociada | Eliminación |
|---|---|---|
| id_perfil | perfil | NO ACTION |
| id_contenido | contenido | NO ACTION |
| id_episodio | episodio | NO ACTION |

---

### Características de la Tabla
- **Nombre**: reseña
- **Descripción**: Almacena las reseñas y valoraciones de usuarios

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_reseña | int | - | Identificación única de reseña |
| id_usuario | int | - | Usuario que reseña |
| id_contenido | int | - | Contenido reseñado |
| valoracion | int | - | Valoración (1-10) |
| comentario | varchar | 1000 | Comentario opcional |
| fecha_reseña | datetime | - | Fecha de reseña |
| util_positivos | int | - | Votos "útil" |
| util_negativos | int | - | Votos "no útil" |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_reseña | PRIMARY KEY |
| id_usuario, id_contenido | UNIQUE |
| valoracion | CHECK (1-10) |
| util_positivos, util_negativos | CHECK (>=0) |

#### Claves Foráneas
| Campo | Entidad asociada | Eliminación |
|---|---|---|
| id_usuario | usuario | CASCADE |
| id_contenido | contenido | CASCADE |

---

### Características de la Tabla
- **Nombre**: lista_contenido
- **Descripción**: Almacena las listas de favoritos/watchlist

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_lista | int | - | Identificación única de lista |
| id_perfil | int | - | Perfil dueño de la lista |
| id_contenido | int | - | Contenido en la lista |
| fecha_agregado | datetime | - | Fecha de agregado |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_lista | PRIMARY KEY |
| id_perfil, id_contenido | UNIQUE |

#### Claves Foráneas
| Campo | Entidad asociada | Eliminación |
|---|---|---|
| id_perfil | perfil | CASCADE |
| id_contenido | contenido | CASCADE |

---

### 🔗 Resumen de Relaciones

#### Relaciones con Eliminación en CASCADE:
- **temporada** → contenido
- **episodio** → temporada  
- **director_contenido** → director, contenido
- **genero_contenido** → genero, contenido
- **reparto** → actor, contenido
- **reseña** → usuario, contenido
- **lista_contenido** → perfil, contenido
- **suscripcion** → usuario

#### Relaciones con Eliminación en NO ACTION:
- **reproduccion** → perfil, contenido, episodio

#### Restricciones de Unicidad Clave:
- Contenido: título + año + tipo
- Actor/Director: nombre + apellido + fecha_nacimiento + país
- Perfil: usuario + nombre_perfil
- Reseña: usuario + contenido
- Lista: perfil + contenido

#### Validaciones de Dominio:
- Edades: 0-21 años
- Valoraciones: 1-10
- Resoluciones: 480p, 720p, 1080p, 2160p
- Estados: Activa, Cancelada, Expirada, Pausada
- Fechas: coherentes y realistas
- Textos: no vacíos y formatos válidos
- Emails: sin espacios y formato válido
- Estados de suscripción: coherentes con fechas_fin
