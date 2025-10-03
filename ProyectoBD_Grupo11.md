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

