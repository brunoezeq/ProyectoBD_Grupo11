## Nombre: Base de Datos para un servicio de Streaming

**Alumnos:**
  - Fernández, Néstor 
  - Montecino, Franco
  - Pérez, Bruno

**Profesores:**
  - Villegas, Darío
  - Cuzziol, Juan José
  - Vallejos, Walter
  - Badaracco, Numa

**Institución Educativa:** Universidad Nacional del Nordeste - Facultad de Ciencias Exactas y Naturales y Agrimensura 

**Carrera:** Licenciatura en Sistemas de Información 

**Fecha de Entrega:** 29/09/2025

**Año:** 2025

<div style="page-break-after: always;"></div> 

## Indice 

[Capítulo I: Introducción](#capítulo-i-introducción)

  - Tema
  - Planteamiento del Problema
  - Objetivos del Trabajo
      - Objetivos Generales
      - Objetivos Específicos
        
[Capítulo II: Marco Conceptual](#capítulo-ii-marco-conceptual)

[Capítulo III: Metodología Seguida](#capítulo-iii-metodología-seguida)

[Capítulo IV: Desarrollo del Tema / Presentación de Resultados](#capítulo-iV-desarrollo-del-tema--presentación-de-resultados)

   - Modelo relacional
     
[Capítulo V: Conclusiones](#capítulo-v-conclusiones)

[Capítulo VI: Bibliografía](#capítulo-vi-bibliografía)

## Capítulo I: Introducción

El presente capítulo introduce el tema del proyecto de estudio, el cual consiste en el desarrollo de una base de datos funcional para un servicio de streaming "FilmStream".
A continuación, se detallarán el tema de estudio, el planteamiento del problema de investigación y los objetivos propuestos, tanto generales como específicos.

### Tema

El trabajo se enfoca en el diseño, modelado e implementación de una base de datos relacional para una plataforma de streaming "FilmStream". El propósito es gestionar de manera eficiente diversos contenidos audiovisuales (series, películas y documentales), incluyendo información detallada sobre su género, los actores y directores participantes, y sus valoraciones. Además, se busca gestionar la información referente a los usuarios del servicio, sus suscripciones y su historial de visualización.

### Planteamiento del Problema 

Actualmente, los servicios de streaming constituyen la principal forma de consumo de contenido audiovisual. Por ello, se requiere de una correcta organización y gestión de los datos que permita asegurar la implementación de una base de datos robusta y eficiente. El problema de investigación se centra en la siguiente pregunta:
¿Cómo estructuramos una base de datos que nos permita gestionar de manera ordenada el contenido de la plataforma y la manera en la que sus usuarios interactúan con esta?
A partir de esta pregunta principal, se desprenden los siguientes interrogantes específicos que guiarán el desarrollo del proyecto:
- ¿Qué entidades y relaciones se precisan para garantizar la representación del dominio del problema?
- ¿Cómo garantizamos la integridad referencial y evitamos la redundancia de datos (mediante la normalización)?
- ¿Cómo logramos mayor eficiencia en las consultas, asegurando un acceso a la información rápido y consistente?

### Objetivos del Trabajo

  ### Objetivos generales

  Diseñar y modelar una base de datos relacional normalizada, que permita gestionar de manera integral el catálogo de contenidos audiovisuales y las interacciones de los usuarios en una plataforma de streaming.

  ### Objetivos específicos 

  - Definir las entidades claves del sistema: contenido, actores, directores, valoraciones, usuarios, reseñas, y establecer sus respectivas relaciones.
  - Aplicar el correcto manejo de claves primarias, foráneas y distintas restricciones para asegurar la integridad de los datos.
  - Proponer mecanismos de seguridad básicos, como la encriptación de contraseñas y las restricciones de acceso.
  - Proveer una estructura flexible que permita la escalabilidad del sistema ante el crecimiento futuro del catálogo y la base de usuarios.

## Capítulo IV: Desarrollo del Tema / Presentación de Resultados 

### Modelo Relacional 
![modelo_relacional](https://github.com/brunoezeq/ProyectoBD_Grupo11/blob/main/ProyectoBD_ModeloRelacional.png)

### Diccionario de datos

Aquí el vínculo al [diccionario de datos](./diccionario_datos.pdf)

---

### Características de la Tabla
- **Nombre**: continente
- **Descripción**: contiene los nombres de los continentes.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_continente | int | - | identificación única de continente |
| nombre_continente | varchar | 50 | identifica nombre del continente |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_continente | PRIMARY KEY |

---

### Características de la Tabla
- **Nombre**: pais
- **Descripción**: contiene los nombres de los países.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_pais | int | - | identificación única de país |
| id_continente | int | - | identificación única de continente |
| nombre_pais | varchar | 50 | identifica nombre del país |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_pais | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_continente | continente |

---

### Características de la Tabla
- **Nombre**: director
- **Descripción**: contiene los datos de los directores.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_director | int | - | identificación única de director |
| id_pais | int | - | identificación única de pais |
| nombre | varchar | 50 | identifica nombre del director |
| apellido | varchar | 50 | identifica apellido del director |
| fecha_nacimiento | date | - | identifica la fecha de nacimiento del director |
| biografia | varchar | 200 | indica la biografía del director |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_director | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_pais | pais |

---

### Características de la Tabla
- **Nombre**: actor
- **Descripción**: contiene los datos de los actores.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_actor | int | - | identificación única de actor |
| id_pais | int | - | identificación única de pais |
| nombre | varchar | 50 | identifica nombre del actor |
| apellido | varchar | 50 | identifica apellido del actor |
| año_nacimiento | int | - | identifica el año de nacimiento del actor |
| biografia | varchar | 200 | indica la biografía del actor |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_actor | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_pais | pais |

---

### Características de la Tabla
- **Nombre**: usuario
- **Descripción**: contiene los datos de los usuarios.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_usuario | int | - | identificación única de usuario |
| id_pais | int | - | identificación única de pais |
| nombre | varchar | 50 | identifica nombre del usuario |
| apellido | varchar | 50 | identifica apellido del usuario |
| email | varchar | 100 | indica el email del usuario |
| fecha_registro | date | - | indica la fecha en la que el usuario se registró |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_usuario | PRIMARY KEY |
| email | UNIQUE |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_pais | pais |

---

### Características de la Tabla
- **Nombre**: plan
- **Descripción**: contiene los datos de los planes de suscripción.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_plan | int | - | identificación única de plan |
| nombre_plan | varchar | 100 | indica el nombre del plan |
| precio | float | - | indica el precio del plan |
| cantidad_pantallas | int | - | indica la cantidad de pantallas que permite utilizar el plan |
| resolucion_permitida | varchar | 10 | indica la resolución máxima en que se pueden reproducir los contenidos |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_plan | PRIMARY KEY |

---

### Características de la Tabla
- **Nombre**: suscripcion
- **Descripción**: contiene las fechas en que se estuvo suscripto a un plan.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_suscripcion | int | - | identificación única de suscripcion |
| id_usuario | int | - | identificación única de usuario |
| id_plan | int | - | identificación única de plan |
| fecha_inicio | date | - | identifica la fecha en que se inició un plan |
| fecha_fin | date | - | identifica la fecha en que se terminó un plan |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_suscripcion | PRIMARY KEY |
| id_usuario | PRIMARY KEY |
| fecha_fin | OPTIONAL |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_usuario | usuario |
| id_plan | plan |

---

### Características de la Tabla
- **Nombre**: perfil
- **Descripción**: contiene los perfiles del usuario.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_perfil | int | - | identificación única de perfil |
| id_usuario | int | - | identificación única de usuario |
| nombre_perfil | varchar | 100 | indica el nombre del perfil del usuario |
| restriccion | bit | - | indica el tipo de restricción que tiene ese perfil |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_perfil | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_usuario | usuario |

---

### Características de la Tabla
- **Nombre**: tipo_contenido
- **Descripción**: contiene el género no narrativo de los contenidos.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_tipo_contenido | int | - | identificación única de tipo_contenido |
| nombre_contenido | varchar | 100 | indica el nombre del género no narrativo del contenido |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_tipo_contenido | PRIMARY KEY |

---

### Características de la Tabla
- **Nombre**: contenido
- **Descripción**: contiene los datos de los contenidos.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_contenido | int | - | identificación única de contenido |
| id_tipo_contenido | int | - | identificación única de tipo_contenido |
| titulo | varchar | 100 | indica el título del contenido |
| sinopsis | varchar | 200 | indica una sinopsis del contenido |
| año_lanzamiento | int | - | indica año de lanzamiento del contenido |
| duracion | varchar | 10 | indica duración en horas, minutos y segundos del contenido |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_contenido | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_tipo_contenido | tipo_contenido |

---

### Características de la Tabla
- **Nombre**: genero
- **Descripción**: contiene los nombres de los géneros.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_genero | int | - | identificación única de genero |
| nombre_genero | varchar | 50 | identifica nombre del genero |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_genero | PRIMARY KEY |

---

### Características de la Tabla
- **Nombre**: genero_contenido
- **Descripción**: tabla intermedia entre genero y contenido.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_genero | int | - | identificación única de genero |
| id_contenido | int | - | identifica nombre del contenido |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_genero | PRIMARY KEY |
| id_contenido | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_genero | genero |
| id_contenido | contenido |

---

### Características de la Tabla
- **Nombre**: director_contenido
- **Descripción**: tabla intermedia entre director y contenido.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_director | int | - | identificación única de director |
| id_contenido | int | - | identifica nombre del contenido |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_director | PRIMARY KEY |
| id_contenido | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_director | director |
| id_contenido | contenido |

---

### Características de la Tabla
- **Nombre**: reparto
- **Descripción**: tabla intermedia entre actor y contenido.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_actor | int | - | identificación única de actor |
| id_contenido | int | - | identificación única de contenido |
| es_protagonista | bit | - | indica si es protagonista o no del contenido |
| nombre_personaje | varchar | 50 | indica nombre del protagonista |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_actor | PRIMARY KEY |
| id_contenido | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_actor | actor |
| id_contenido | contenido |

---

### Características de la Tabla
- **Nombre**: temporadas
- **Descripción**: contiene los datos de las temporadas de los contenidos.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_temporada | int | - | identificación única de temporada |
| id_contenido | int | - | identificación única de contenido |
| nro_temporada | int | - | indica el número de temporadas del contenido |
| resumen | varchar | 200 | indica un resumen de la temporada |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_temporada | PRIMARY KEY |
| id_contenido | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_contenido | contenido |

---

### Características de la Tabla
- **Nombre**: episodio
- **Descripción**: contiene los datos de los episodios.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_episodio | int | - | identificación única de episodio |
| id_contenido | int | - | identificación única de contenido |
| id_temporada | int | - | identificación única de temporada |
| titulo | varchar | 100 | indica el título del episodio |
| nro_episodio | int | - | indica el número del episodio |
| duracion | varchar | 10 | indica duración en horas, minutos y segundos del contenido |
| resumen | varchar | 200 | indica un resumen del episodio |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_contenido | PRIMARY KEY |
| nro_episodio | UNIQUE |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_contenido | contenido |
| id_temporada | temporadas |

---

### Características de la Tabla
- **Nombre**: reproduccion
- **Descripción**: contiene los datos de reproducción de los usuarios.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_reproduccion | int | - | identificación única de reproduccion |
| id_contenido | int | - | identificación única de contenido |
| id_usuario | int | - | identificación única de usuario |
| fecha_reproduccion | date | - | indica la fecha en que se reprodujo un contenido |
| progreso_minutos | int | - | indica en donde el usuario dejó un episodio |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_reproduccion | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_contenido | contenido |
| id_usuario | usuario |

---

### Características de la Tabla
- **Nombre**: reseña
- **Descripción**: contiene las reseñas de los usuarios.

### Características de los Datos
| Campo | Tipo | Long | Significado |
|---|---|---|---|
| id_reseña | int | - | identificación única de reseña |
| id_contenido | int | - | identificación única de contenido |
| id_usuario | int | - | identificación única de usuario |
| fecha_reseña | date | - | indica la fecha en que se publicó una reseña |
| valoracion | float | - | indica la valoración de la reseña |

#### Restricciones
| Campo | Tipo restricción |
|---|---|
| id_reseña | PRIMARY KEY |

#### Claves Foráneas
| Campo | Entidad asociada |
|---|---|
| id_contenido | contenido |
| id_usuario | usuario |
