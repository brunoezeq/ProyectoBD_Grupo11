GO
USE FilmStream;

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
('Chile', 1),
('Perú', 1),
('Estados Unidos', 1),
('España', 2),
('Alemania', 2),
('Inglaterra', 2),
('Italia', 2),
('Francia', 2),
('Corea del Sur', 3),
('China', 3),
('India', 3),
('Japón', 3),
('Mexico', 1),
('Suecia', 2),
('Australia', 2),
('Canada', 1);


-- ==============================
-- DATOS PARA LA TABLA TIPO_CONTENIDO
-- ==============================

INSERT INTO tipo_contenido (nombre_contenido) VALUES
('Película'),
('Serie'),
('Documental');


-- ==============================
-- DATOS PARA LA TABLA GENERO
-- ==============================

INSERT INTO genero (nombre_genero) VALUES
('Acción'),
('Comedia'),
('Drama'),
('Ciencia Ficción'),
('Fantasía'),
('Animación'),
('Terror'),
('Documental');


-- ==============================
-- DATOS PARA LA TABLA DIRECTOR
-- ==============================

INSERT INTO director (nombre, apellido, fecha_nacimiento, biografia, id_pais) VALUES
('Francis Ford', 'Coppola', '1939-04-07', 'Director estadounidense, autor de El Padrino y cine de autor.', 4),
('Robert', 'Zemeckis', '1952-05-14', 'Director estadounidense, conocido por Forrest Gump e innovaciones técnicas.', 4),
('Christopher', 'Nolan', '1970-07-30', 'Director británico-estadounidense, famoso por estructuras narrativas complejas.', 7),
('Vince', 'Gilligan', '1967-02-10', 'Creador y showrunner de Breaking Bad.', 4),
('Matt', 'Duffer', '1984-02-15', 'Coguionista y codirector (Duffer Brothers) de Stranger Things.', 4),
('Johan', 'Renck', '1966-12-05', 'Director sueco que dirigió la miniserie Chernobyl.', 15),
('Chuck', 'Lorre', '1952-06-18', 'Productor/creador y figura clave en comedias dramáticas de TV como El Método Kominsky.', 4),
('David', 'Fincher', '1962-08-28', 'Director estadounidense, conocido por thrillers y dramas (The Social Network, Fight Club, Mindhunter).', 4),
('Damien', 'Chazelle', '1985-01-19', 'Director estadounidense, ganador por La La Land y Whiplash.', 4),
('Guillermo', 'del Toro', '1964-10-09', 'Director mexicano, autor de El laberinto del fauno.', 14),
('Park', 'Chan-wook', '1963-08-23', 'Director surcoreano, conocido por Oldboy y su estilo visual potente.', 10),
('Wes', 'Anderson', '1969-05-01', 'Director estadounidense con estilo visual distintivo (El Gran Hotel Budapest).', 4),
('Joel', 'Coen', '1954-11-29', 'Co-director junto a su hermano; cineasta clave (Fargo, The Big Lebowski).', 4),
('Cary', 'Fukunaga', '1977-07-10', 'Director estadounidense de True Detective (temporada 1) y cine contemporáneo.', 4),
('Steven', 'Spielberg', '1946-12-18', 'Director y productor estadounidense, uno de los cineastas más influyentes del siglo XX.', 4),
('Ridley', 'Scott', '1937-11-30', 'Director inglés, autor de clásicos como Alien y Gladiador.', 7),
('Tony', 'Kaye', '1952-07-05', 'Director británico, dirigió American History X.', 7),
('Martin', 'Scorsese', '1942-11-17', 'Director estadounidense icónico del cine de autor y policial (Goodfellas, The Departed).', 4),
('David', 'Attenborough', '1926-05-08', 'Naturalista y narrador británico de documentales emblemáticos (Planet Earth).', 7),
('Jason', 'Hehir', '1976-07-25', 'Director y productor estadounidense, conocido por documentales deportivos como The Last Dance.', 4),
('Luc', 'Jacquet', '1967-12-01', 'Director francés, autor de March of the Penguins.', 9),
('Joshua', 'Oppenheimer', '1974-06-23', 'Director estadounidense, creador de The Act of Killing.', 4),
('Jean-Pierre', 'Jeunet', '1953-09-03', 'Director francés, conocido por Amélie y estilo visual singular.', 9),
('Giuseppe', 'Tornatore', '1956-05-27', 'Director italiano, autor de Cinema Paradiso.', 8),
('Hayao', 'Miyazaki', '1941-01-05', 'Director japonés legendario, fundador de Studio Ghibli.', 13),
('Makoto', 'Shinkai', '1973-02-09', 'Director japonés contemporáneo, creador de Your Name.', 13),
('Reed', 'Morano', '1977-08-15', 'Directora estadounidense que dirigió episodios pilotos como The Handmaid''s Tale.', 4),
('Charlie', 'Brooker', '1971-03-03', 'Creador británico de Black Mirror.', 7),
('Alastair', 'Fothergill', '1960-07-10', 'Productor/director británico de series documentales de naturaleza (Planet Earth).', 7),
('Michael', 'Moore', '1954-04-23', 'Documentalista estadounidense, autor de Bowling for Columbine.', 4),
('Roberto', 'Benigni', '1952-10-27', 'Actor y director italiano, autor de La Vita è Bella.', 8),
('Michael', 'Radford', '1946-02-24', 'Director inglés de Il Postino y diversos dramas.', 7),
('Davis', 'Guggenheim', '1963-02-04', 'Director estadounidense de documentales como An Inconvenient Truth y He Named Me Malala.', 4),
('Spike', 'Jonze', '1969-10-22', 'Director estadounidense, autor de Her y cine original y experimental.', 4),
('Barry', 'Jenkins', '1979-11-19', 'Director estadounidense, ganador por Moonlight.', 4),
('Alan', 'Ball', '1957-05-20', 'Creador y showrunner estadounidense de Six Feet Under.', 4),
('Betsy', 'West', '1956-07-11', 'Directora estadounidense, coautora del documental RBG.', 4),
('George', 'Miller', '1945-03-03', 'Director australiano, autor de la saga Mad Max.', 16),
('David', 'Gelb', '1975-06-12', 'Director estadounidense de documentales como Jiro Dreams of Sushi.', 4),
('Quentin', 'Tarantino', '1963-03-27', 'Director estadounidense, autor de Pulp Fiction y Django Unchained.', 4),
('Lana', 'Wachowski', '1965-06-21', 'Directora estadounidense, coautora de The Matrix (Wachowski Sisters).', 4),
('Frank', 'Darabont', '1959-01-28', 'Director estadounidense, conocido por The Shawshank Redemption y The Green Mile.', 4),
('Jonathan', 'Demme', '1944-02-22', 'Director estadounidense conocido por The Silence of the Lambs.', 4),
('James', 'Cameron', '1954-08-16', 'Director canadiense de grandes éxitos comerciales como Titanic y Avatar.', 17),
('Alejandro González', 'Iñárritu', '1963-08-15', 'Director mexicano ganador de múltiples premios, autor de The Revenant.', 14),
('Bryan', 'Singer', '1965-09-17', 'Director estadounidense conocido por The Usual Suspects.', 4),
('Denis', 'Villeneuve', '1967-10-03', 'Director canadiense de ciencia ficción contemporánea (Blade Runner 2049, Dune).', 17),
('Todd', 'Phillips', '1970-12-20', 'Director estadounidense de Joker y comedias dramáticas.', 4),
('Sidney', 'Lumet', '1924-06-25', 'Director estadounidense clásico (12 Angry Men).', 4),
('Roman', 'Polanski', '1933-08-18', 'Director nacido en Polonia con carrera internacional (The Pianist).', 9),
('Ron', 'Howard', '1954-03-01', 'Director y actor estadounidense, autor de A Beautiful Mind.', 4),
('Michael', 'Curtiz', '1886-12-24', 'Director húngaro-estadounidense, dirigió Casablanca.', 4),
('Orson', 'Welles', '1915-05-06', 'Director, actor y guionista estadounidense, autor de Citizen Kane.', 4),
('Alfred', 'Hitchcock', '1899-08-13', 'Director británico pionero del suspense clásico.', 7),
('Stanley', 'Kubrick', '1928-07-26', 'Director estadounidense, autor de 2001, The Shining y Full Metal Jacket.', 4),
('Roger', 'Allers', '1959-11-26', 'Director y animador estadounidense, codirector de The Lion King.', 4),
('John', 'Lasseter', '1957-01-12', 'Director y animador estadounidense, figura clave en Pixar (Toy Story).', 4),
('Andrew', 'Stanton', '1965-12-03', 'Director y guionista estadounidense en Pixar (Finding Nemo, WALL·E).', 4),
('Pete', 'Docter', '1968-10-09', 'Director de animación estadounidense, autor de Up, Inside Out y Soul.', 4),
('Lee', 'Unkrich', '1967-08-08', 'Director estadounidense de Coco y cine de animación.', 4),
('Brad', 'Bird', '1957-09-24', 'Director estadounidense, responsable de Ratatouille y The Incredibles.', 4);


-- ==============================
-- DATOS PARA LA TABLA ACTOR
-- ==============================

INSERT INTO actor (nombre, apellido, año_nacimiento, biografia, id_pais) VALUES
('Tom', 'Hanks', '1956-07-09', 'Actor estadounidense ganador del Oscar.', 4),
('Natalie', 'Portman', '1981-06-09', 'Actriz estadounidense-israelí.', 4),
('Ricardo', 'Darín', '1957-01-16', 'Actor argentino muy reconocido.', 1),
('Jean', 'Reno', '1948-07-30', 'Actor francés de cine internacional.', 9),
('Érica', 'Rivas', '1974-12-01', 'Actriz argentina conocida por Casados con hijos y Relatos salvajes.', 1),
('Javier', 'Bardem', '1969-03-01', 'Actor español ganador del Oscar por No Country for Old Men.', 5),
('Penélope', 'Cruz', '1974-04-28', 'Actriz española galardonada con el Oscar por Vicky Cristina Barcelona.', 5),
('Marion', 'Cotillard', '1975-09-30', 'Actriz francesa ganadora del Oscar por La Vie en Rose.', 9),
('Toshiro', 'Mifune', '1920-04-01', 'Actor japonés legendario.', 13),
('Ken', 'Watanabe', '1959-10-21', 'Actor japonés conocido por El último samurái y Origen.', 13),
('Gael', 'García Bernal', '1978-11-30', 'Actor chileno-mexicano reconocido internacionalmente.', 14),
('Daniela', 'Vega', '1989-06-03', 'Actriz chilena reconocida por Una mujer fantástica.', 2),
('Christian', 'Meier', '1970-06-23', 'Actor y músico peruano con trayectoria internacional.', 3),
('Magaly', 'Solier', '1986-06-11', 'Actriz peruana destacada por La teta asustada.', 3),
('Daniel', 'Brühl', '1978-06-16', 'Actor alemán conocido por Goodbye Lenin! y Rush.', 6),
('Diane', 'Kruger', '1976-07-15', 'Actriz alemana reconocida por Bastardos sin gloria.', 6),
('Benedict', 'Cumberbatch', '1976-07-19', 'Actor inglés famoso por Sherlock y Doctor Strange.', 7),
('Emma', 'Watson', '1990-04-15', 'Actriz inglesa conocida por interpretar a Hermione Granger en Harry Potter.', 7),
('Roberto', 'Benigni', '1952-10-27', 'Actor italiano ganador del Oscar por La vida es bella.', 8),
('Monica', 'Bellucci', '1964-09-30', 'Actriz italiana reconocida por Malèna y Matrix Reloaded.', 8),
('Song', 'Kang-ho', '1967-03-17', 'Actor surcoreano protagonista de Parasite.', 10),
('Bae', 'Doona', '1979-10-11', 'Actriz surcoreana conocida por The Host y Sense8.', 10),
('Jackie', 'Chan', '1954-04-07', 'Actor chino famoso por sus películas de acción y comedia.', 11),
('Zhang', 'Ziyi', '1979-02-09', 'Actriz china reconocida por El tigre y el dragón.', 11),
('Aamir', 'Khan', '1965-03-14', 'Actor y productor indio reconocido por películas como Dangal y PK.', 12),
('Deepika', 'Padukone', '1986-01-05', 'Actriz india destacada en Bollywood.', 12),
('Salma', 'Hayek', '1966-09-02', 'Actriz mexicana nominada al Oscar por Frida.', 14),
('Al', 'Pacino', '1940-04-25', 'Actor estadounidense legendario, protagonista de El Padrino.', 4),
('Marlon', 'Brando', '1924-04-03', 'Actor estadounidense icónico, protagonista de El Padrino.', 4),
('Robert', 'De Niro', '1943-08-17', 'Actor estadounidense legendario.', 4),
('Leonardo', 'DiCaprio', '1974-11-11', 'Actor estadounidense ganador del Oscar.', 4),
('Morgan', 'Freeman', '1937-06-01', 'Actor estadounidense reconocido por su voz y actuación.', 4),
('Brad', 'Pitt', '1963-12-18', 'Actor y productor estadounidense.', 4),
('Johnny', 'Depp', '1963-06-09', 'Actor estadounidense conocido por personajes excéntricos.', 4),
('Meryl', 'Streep', '1949-06-22', 'Actriz estadounidense con múltiples premios Oscar.', 4),
('Denzel', 'Washington', '1954-12-28', 'Actor estadounidense ganador del Oscar.', 4),
('Anthony', 'Hopkins', '1937-12-31', 'Actor británico ganador del Oscar.', 7),
('Kate', 'Winslet', '1975-10-05', 'Actriz británica ganadora del Oscar.', 7),
('Cate', 'Blanchett', '1969-05-14', 'Actriz australiana ganadora del Oscar.', 16),
('Russell', 'Crowe', '1964-04-07', 'Actor neozelandés-australiano ganador del Oscar.', 16),
('Keanu', 'Reeves', '1964-09-02', 'Actor canadiense conocido por Matrix y John Wick.', 17),
('Ryan', 'Gosling', '1980-11-12', 'Actor canadiense conocido por La La Land y Drive.', 17);


-- ==============================
-- DATOS PARA LA TABLA CONTENIDO
-- ==============================

INSERT INTO contenido (titulo, sinopsis, año_lanzamiento, duracion, id_tipo_contenido) VALUES
('El Padrino', 'La historia de la familia Corleone y el poder en la mafia.', 1972, 175, 1),
('Forrest Gump', 'Un hombre sencillo presencia los grandes hitos de la historia reciente.', 1994, 142, 1),
('El Caballero Oscuro', 'Batman se enfrenta al caos encarnado por el Joker.', 2008, 152, 1),
('Inception', 'Un ladrón entra en los sueños para sembrar una idea.', 2010, 148, 1),
('Interstellar', 'Un equipo viaja por el espacio en busca de un nuevo hogar para la humanidad.', 2014, 169, 1),
('Breaking Bad', 'Un profesor de química se convierte en fabricante de metanfetamina.', 2008, NULL, 2),
('Stranger Things', 'Niños y fenómenos paranormales en un pueblo de los 80.', 2016, NULL, 2),
('Chernobyl', 'Recreación del desastre nuclear y sus consecuencias.', 2019, NULL, 2),
('El Método Kominsky', 'Un actor retirado navega la amistad y la vejez en Hollywood.', 2018, NULL, 2),
('The Social Network', 'La creación de una red social y sus conflictos legales.', 2010, 120, 1),
('La La Land', 'Dos artistas buscan el éxito y el amor en Los Ángeles.', 2016, 128, 1),
('El Laberinto del Fauno', 'Una niña descubre un mundo fantástico en la posguerra.', 2006, 119, 1),
('Oldboy', 'Un hombre busca venganza tras ser encarcelado sin motivo.', 2003, 120, 1),
('El Gran Hotel Budapest', 'Aventuras de un conserje y su protegido en un lujoso hotel europeo.', 2014, 99, 1),
('Fargo', 'Crímenes, mentiras y destino en el medio oeste.', 1996, 98, 1),
('Mindhunter', 'Agentes del FBI estudian la mente de asesinos en serie.', 2017, NULL, 2),
('True Detective', 'Detectives investigan crímenes complejos en historias antológicas.', 2014, NULL, 2),
('House of Cards', 'Política, ambición y manipulación en Washington D.C.', 2013, NULL, 2),
('La Lista de Schindler', 'Un empresario salva vidas durante el Holocausto.', 1993, 195, 1),
('Gladiador', 'Un general busca venganza en la arena del Imperio Romano.', 2000, 155, 1),
('American History X', 'Un joven enfrenta las consecuencias del odio y la redención.', 1998, 119, 1),
('Whiplash', 'La obsesión por la perfección musical entre maestro y alumno.', 2014, 107, 1),
('The Irishman', 'Crónica de la vida de un sicario en el crimen organizado.', 2019, 209, 1),
('Planet Earth II', 'Segunda entrega que explora paisajes y especies del planeta.', 2016, NULL, 3),
('The Last Dance', 'Documental que sigue la carrera de Michael Jordan y los Bulls.', 2020, NULL, 3),
('March of the Penguins', 'La migración anual y la vida de los pingüinos emperador.', 2005, 80, 3),
('The Act of Killing', 'Documental que confronta a verdugos con sus actos.', 2012, 115, 3),
('Amélie', 'Una joven decide cambiar la vida de los que la rodean en París.', 2001, 122, 1),
('Cinema Paradiso', 'Un niño y su amor por el cine en un pueblo italiano.', 1988, 155, 1),
('Spirited Away', 'Una niña entra en un mundo mágico y debe encontrar la manera de volver.', 2001, 125, 1),
('Your Name', 'Dos jóvenes conectados por un extraño intercambio de cuerpos.', 2016, 106, 1),
('The Handmaid''s Tale', 'Distopía en la que las mujeres son subyugadas por un régimen teocrático.', 2017, NULL, 2),
('Black Mirror', 'Antología sobre el lado oscuro de la tecnología en la sociedad.', 2011, NULL, 2),
('Planet Earth', 'Documental sobre la vida en la Tierra.', 2006, NULL, 3),
('Bowling for Columbine', 'Documental sobre violencia y cultura en Estados Unidos.', 2002, 120, 3),
('La Vita è Bella', 'Un padre utiliza el humor para proteger a su hijo en tiempos oscuros.', 1997, 116, 1),
('Il Postino', 'La amistad entre un cartero y un poeta en una isla italiana.', 1994, 108, 1),
('The Blue Planet', 'Documental sobre los océanos y sus ecosistemas.', 2001, NULL, 3),
('An Inconvenient Truth', 'Al Gore presenta evidencia sobre el cambio climático.', 2006, 96, 3),
('Her', 'Un hombre se enamora de una inteligencia artificial.', 2013, 126, 1),
('Moonlight', 'La vida y crecimiento de un joven en un ambiente difícil.', 2016, 111, 1),
('The Departed', 'Infiltrados en bandas y policía en Boston, traiciones y tensión.', 2006, 151, 1),
('Six Feet Under', 'Una familia que administra una funeraria enfrenta la vida y la muerte.', 2001, NULL, 2),
('He Named Me Malala', 'La historia de Malala Yousafzai y su defensa por la educación.', 2015, 88, 3),
('RBG', 'Documental sobre la vida y legado de la jueza Ruth Bader Ginsburg.', 2018, 98, 3),
('Mad Max: Fury Road', 'Aventura postapocalíptica con acción incesante en el desierto.', 2015, 120, 1),
('Jiro Dreams of Sushi', 'Documental sobre un maestro sushi y su búsqueda de la perfección.', 2011, 81, 3),
('Pulp Fiction', 'Historias entrelazadas de crimen y redención en Los Ángeles.', 1994, 154, 1),
('The Matrix', 'Un hacker descubre la verdad sobre la realidad y lidera una rebelión.', 1999, 136, 1),
('Fight Club', 'Un hombre crea un club clandestino que cambia su vida.', 1999, 139, 1),
('The Shawshank Redemption', 'Dos prisioneros forjan una amistad en una historia de esperanza.', 1994, 142, 1),
('Goodfellas', 'Ascenso y caída de un miembro de la mafia neoyorquina.', 1990, 146, 1),
('The Godfather Part II', 'La expansión del imperio Corleone y los orígenes de Vito.', 1974, 202, 1),
('The Silence of the Lambs', 'Una agente busca la ayuda de un asesino para atrapar a otro.', 1991, 118, 1),
('Saving Private Ryan', 'Soldados buscan a un paracaidista tras el Día D.', 1998, 169, 1),
('Titanic', 'Un romance trágico a bordo del transatlántico más famoso.', 1997, 195, 1),
('Avatar', 'Un exmarine se une a una raza alienígena en Pandora.', 2009, 162, 1),
('The Revenant', 'Un cazador lucha por sobrevivir en la naturaleza salvaje.', 2015, 156, 1),
('The Wolf of Wall Street', 'Un corredor de bolsa se deja llevar por la codicia y el exceso.', 2013, 180, 1),
('The Green Mile', 'Un guardia de prisión descubre a un reo con dones sobrenaturales.', 1999, 189, 1),
('Se7en', 'Dos detectives persiguen a un asesino serial inspirado en los pecados capitales.', 1995, 127, 1),
('Django Unchained', 'Un esclavo liberado busca rescatar a su esposa en el sur de EE.UU.', 2012, 165, 1),
('Once Upon a Time in Hollywood', 'Un actor en decadencia intenta adaptarse a una industria cambiante.', 2019, 161, 1),
('Parasite', 'Una familia pobre se infiltra en la vida de una familia rica.', 2019, 132, 1),
('The Truman Show', 'Un hombre descubre que su vida es un reality show.', 1998, 103, 1),
('The Prestige', 'Dos magos rivales llevan su obsesión hasta las últimas consecuencias.', 2006, 130, 1),
('Memento', 'Un hombre con pérdida de memoria intenta resolver un asesinato.', 2000, 113, 1),
('The Usual Suspects', 'Un grupo de criminales se ve envuelto en una misteriosa conspiración.', 1995, 106, 1),
('Blade Runner', 'Un cazador de replicantes enfrenta dilemas morales en un futuro distópico.', 1982, 117, 1),
('Blade Runner 2049', 'Un nuevo blade runner descubre secretos que amenazan la humanidad.', 2017, 164, 1),
('The Big Lebowski', 'Un hombre común se ve envuelto en un enredo criminal absurdo.', 1998, 117, 1),
('Joker', 'La historia del origen de uno de los villanos más icónicos.', 2019, 122, 1),
('12 Angry Men', 'Doce jurados debaten el destino de un acusado en un juicio tenso.', 1957, 96, 1),
('The Pianist', 'Un músico judío lucha por sobrevivir en la Segunda Guerra Mundial.', 2002, 150, 1),
('A Beautiful Mind', 'Un brillante matemático enfrenta los desafíos de su mente.', 2001, 135, 1),
('Casablanca', 'Un hombre debe decidir entre el amor y el deber en tiempos de guerra.', 1942, 102, 1),
('Citizen Kane', 'La vida y legado del magnate Charles Foster Kane.', 1941, 119, 1),
('Vertigo', 'Un detective obsesionado con una mujer se ve envuelto en un misterio.', 1958, 128, 1),
('Rear Window', 'Un fotógrafo sospecha que su vecino ha cometido un asesinato.', 1954, 112, 1),
('Psycho', 'Una secretaria huye con dinero y llega al siniestro motel Bates.', 1960, 109, 1),
('The Shining', 'Un escritor pierde la cordura en un hotel aislado.', 1980, 146, 1),
('2001: A Space Odyssey', 'Un viaje espacial hacia lo desconocido y los límites de la humanidad.', 1968, 149, 1),
('Apocalypse Now', 'Un capitán se adentra en la guerra de Vietnam en busca de un coronel renegado.', 1979, 153, 1),
('Full Metal Jacket', 'Soldados estadounidenses enfrentan la brutalidad de la guerra.', 1987, 116, 1),
('The Lion King', 'Un joven león aprende su papel en el ciclo de la vida.', 1994, 88, 1),
('Toy Story', 'Los juguetes cobran vida cuando los humanos no los ven.', 1995, 81, 1),
('Finding Nemo', 'Un pez padre busca a su hijo perdido en el océano.', 2003, 100, 1),
('Up', 'Un anciano viaja con su casa hacia Sudamérica acompañado por un niño explorador.', 2009, 96, 1),
('Inside Out', 'Las emociones de una niña cobran vida y guían su crecimiento.', 2015, 102, 1),
('Coco', 'Un niño viaja al mundo de los muertos para descubrir su legado familiar.', 2017, 105, 1),
('Ratatouille', 'Una rata con talento culinario sueña con ser chef en París.', 2007, 111, 1),
('WALL·E', 'Un robot limpia un planeta abandonado y encuentra el amor.', 2008, 98, 1),
('The Incredibles', 'Una familia de superhéroes intenta llevar una vida normal.', 2004, 115, 1),
('Soul', 'Un músico busca el verdadero propósito de su vida.', 2020, 100, 1),
('Oppenheimer', 'La historia del científico detrás de la bomba atómica.', 2023, 180, 1),
('Barbie', 'Una muñeca comienza a cuestionar su mundo perfecto.', 2023, 114, 1),
('Dune', 'El heredero de una noble familia lucha por controlar el planeta desértico Arrakis.', 2021, 155, 1);


-- ==============================
-- DATOS PARA LA TABLA DIRECTOR_CONTENIDO
-- ==============================

INSERT INTO director_contenido (id_director, id_contenido) VALUES
(1, 1),   -- Francis Ford Coppola -> El Padrino
(2, 2),   -- Robert Zemeckis -> Forrest Gump
(3, 3),   -- Christopher Nolan -> El Caballero Oscuro
(3, 4),   -- Christopher Nolan -> Inception
(3, 5),   -- Christopher Nolan -> Interstellar
(4, 6),   -- Vince Gilligan -> Breaking Bad
(5, 7),   -- Matt Duffer -> Stranger Things
(6, 8),   -- Johan Renck -> Chernobyl
(7, 9),   -- Chuck Lorre -> El Método Kominsky
(8, 10),  -- David Fincher -> The Social Network
(9, 11),  -- Damien Chazelle -> La La Land
(10, 12), -- Guillermo del Toro -> El Laberinto del Fauno
(11, 13), -- Park Chan-wook -> Oldboy
(12, 14), -- Wes Anderson -> El Gran Hotel Budapest
(13, 15), -- Joel Coen -> Fargo
(8, 16),  -- David Fincher -> Mindhunter
(14, 17), -- Cary Fukunaga -> True Detective
(15, 19), -- Steven Spielberg -> La Lista de Schindler
(16, 20), -- Ridley Scott -> Gladiador
(17, 21), -- Tony Kaye -> American History X
(9, 22),  -- Damien Chazelle -> Whiplash
(18, 23), -- Martin Scorsese -> The Irishman
(19, 24), -- David Attenborough -> Planet Earth II
(20, 25), -- Jason Hehir -> The Last Dance
(21, 26), -- Luc Jacquet -> March of the Penguins
(22, 27), -- Joshua Oppenheimer -> The Act of Killing
(23, 28), -- Jean-Pierre Jeunet -> Amélie
(24, 29), -- Giuseppe Tornatore -> Cinema Paradiso
(25, 30), -- Hayao Miyazaki -> Spirited Away
(26, 31), -- Makoto Shinkai -> Your Name
(27, 32), -- Reed Morano -> The Handmaid's Tale
(28, 33), -- Charlie Brooker -> Black Mirror
(29, 34), -- Alastair Fothergill -> Planet Earth
(30, 35), -- Michael Moore -> Bowling for Columbine
(31, 36), -- Roberto Benigni -> La Vita è Bella
(32, 37), -- Michael Radford -> Il Postino
(29, 38), -- Alastair Fothergill -> The Blue Planet
(33, 39), -- Davis Guggenheim -> An Inconvenient Truth
(34, 40), -- Spike Jonze -> Her
(35, 41), -- Barry Jenkins -> Moonlight
(18, 42), -- Martin Scorsese -> The Departed
(36, 43), -- Alan Ball -> Six Feet Under
(33, 45), -- Davis Guggenheim -> He Named Me Malala
(38, 46), -- Betsy West -> RBG
(39, 47), -- George Miller -> Mad Max: Fury Road
(40, 48), -- David Gelb -> Jiro Dreams of Sushi
(41, 49), -- Quentin Tarantino -> Pulp Fiction
(42, 50), -- Lana Wachowski -> The Matrix
(8, 51),  -- David Fincher -> Fight Club
(43, 52), -- Frank Darabont -> The Shawshank Redemption
(18, 53), -- Martin Scorsese -> Goodfellas
(1, 54),  -- Francis Ford Coppola -> The Godfather Part II
(44, 55), -- Jonathan Demme -> The Silence of the Lambs
(15, 56), -- Steven Spielberg -> Saving Private Ryan
(45, 57), -- James Cameron -> Titanic
(45, 58), -- James Cameron -> Avatar
(46, 59), -- Alejandro González Iñárritu -> The Revenant
(18, 60), -- Martin Scorsese -> The Wolf of Wall Street
(43, 61), -- Frank Darabont -> The Green Mile
(8, 62),  -- David Fincher -> Se7en
(41, 63), -- Quentin Tarantino -> Django Unchained
(41, 64), -- Quentin Tarantino -> Once Upon a Time in Hollywood
(47, 65), -- Bong Joon-ho -> Parasite
(2, 66),  -- Robert Zemeckis -> The Truman Show
(3, 67),  -- Christopher Nolan -> The Prestige
(3, 68),  -- Christopher Nolan -> Memento
(48, 69), -- Bryan Singer -> The Usual Suspects
(16, 70), -- Ridley Scott -> Blade Runner
(49, 71), -- Denis Villeneuve -> Blade Runner 2049
(13, 72), -- Joel Coen -> The Big Lebowski
(50, 73), -- Todd Phillips -> Joker
(51, 74), -- Sidney Lumet -> 12 Angry Men
(52, 75), -- Roman Polanski -> The Pianist
(53, 76), -- Ron Howard -> A Beautiful Mind
(54, 77), -- Michael Curtiz -> Casablanca
(55, 78), -- Orson Welles -> Citizen Kane
(56, 79), -- Alfred Hitchcock -> Vertigo
(56, 80), -- Alfred Hitchcock -> Rear Window
(56, 81), -- Alfred Hitchcock -> Psycho
(57, 82), -- Stanley Kubrick -> The Shining
(57, 83), -- Stanley Kubrick -> 2001: A Space Odyssey
(1, 84),  -- Francis Ford Coppola -> Apocalypse Now
(57, 85), -- Stanley Kubrick -> Full Metal Jacket
(58, 86), -- Roger Allers -> The Lion King
(59, 87), -- John Lasseter -> Toy Story
(60, 88), -- Andrew Stanton -> Finding Nemo
(61, 89), -- Pete Docter -> Up
(61, 90), -- Pete Docter -> Inside Out
(62, 91), -- Lee Unkrich -> Coco
(63, 92), -- Brad Bird -> Ratatouille
(60, 93), -- Andrew Stanton -> WALL·E
(63, 94), -- Brad Bird -> The Incredibles
(61, 95), -- Pete Docter -> Soul
(3, 96),  -- Christopher Nolan -> Oppenheimer
(64, 97), -- Greta Gerwig -> Barbie
(49, 98); -- Denis Villeneuve -> Dune


-- ==============================
-- DATOS PARA LA TABLA GENERO_CONTENIDO
-- ==============================

INSERT INTO genero_contenido (id_genero, id_contenido) VALUES
(3, 1),   -- Drama -> El Padrino
(3, 2),   -- Drama -> Forrest Gump
(1, 3),   -- Acción -> El Caballero Oscuro
(4, 3),   -- Ciencia Ficción -> El Caballero Oscuro
(4, 4),   -- Ciencia Ficción -> Inception
(5, 4),   -- Fantasía -> Inception
(4, 5),   -- Ciencia Ficción -> Interstellar
(3, 5),   -- Drama -> Interstellar
(3, 6),   -- Drama -> Breaking Bad
(1, 6),   -- Acción -> Breaking Bad
(4, 7),   -- Ciencia Ficción -> Stranger Things
(7, 7),   -- Terror -> Stranger Things
(3, 8),   -- Drama -> Chernobyl
(8, 8),   -- Documental -> Chernobyl
(2, 9),   -- Comedia -> El Método Kominsky
(3, 9),   -- Drama -> El Método Kominsky
(3, 10),  -- Drama -> The Social Network
(3, 11),  -- Drama -> La La Land
(2, 11),  -- Comedia -> La La Land
(5, 12),  -- Fantasía -> El Laberinto del Fauno
(3, 12),  -- Drama -> El Laberinto del Fauno
(1, 13),  -- Acción -> Oldboy
(3, 13),  -- Drama -> Oldboy
(2, 14),  -- Comedia -> El Gran Hotel Budapest
(3, 14),  -- Drama -> El Gran Hotel Budapest
(3, 15),  -- Drama -> Fargo
(2, 15),  -- Comedia -> Fargo
(3, 16),  -- Drama -> Mindhunter
(7, 16),  -- Terror -> Mindhunter
(3, 17),  -- Drama -> True Detective
(7, 17),  -- Terror -> True Detective
(3, 18),  -- Drama -> House of Cards
(3, 19),  -- Drama -> La Lista de Schindler
(1, 20),  -- Acción -> Gladiador
(3, 20),  -- Drama -> Gladiador
(3, 21),  -- Drama -> American History X
(3, 22),  -- Drama -> Whiplash
(3, 23),  -- Drama -> The Irishman
(1, 23),  -- Acción -> The Irishman
(8, 24),  -- Documental -> Planet Earth II
(8, 25),  -- Documental -> The Last Dance
(8, 26),  -- Documental -> March of the Penguins
(8, 27),  -- Documental -> The Act of Killing
(2, 28),  -- Comedia -> Amélie
(3, 28),  -- Drama -> Amélie
(3, 29),  -- Drama -> Cinema Paradiso
(5, 30),  -- Fantasía -> Spirited Away
(6, 30),  -- Animación -> Spirited Away
(5, 31),  -- Fantasía -> Your Name
(6, 31),  -- Animación -> Your Name
(4, 32),  -- Ciencia Ficción -> The Handmaid's Tale
(3, 32),  -- Drama -> The Handmaid's Tale
(4, 33),  -- Ciencia Ficción -> Black Mirror
(7, 33),  -- Terror -> Black Mirror
(8, 34),  -- Documental -> Planet Earth
(8, 35),  -- Documental -> Bowling for Columbine
(3, 36),  -- Drama -> La Vita è Bella
(2, 36),  -- Comedia -> La Vita è Bella
(3, 37),  -- Drama -> Il Postino
(8, 38),  -- Documental -> The Blue Planet
(8, 39),  -- Documental -> An Inconvenient Truth
(4, 40),  -- Ciencia Ficción -> Her
(3, 40),  -- Drama -> Her
(3, 41),  -- Drama -> Moonlight
(1, 42),  -- Acción -> The Departed
(3, 42),  -- Drama -> The Departed
(3, 43),  -- Drama -> Six Feet Under
(2, 43),  -- Comedia -> Six Feet Under
(8, 45),  -- Documental -> He Named Me Malala
(8, 46),  -- Documental -> RBG
(1, 47),  -- Acción -> Mad Max: Fury Road
(4, 47),  -- Ciencia Ficción -> Mad Max: Fury Road
(8, 48),  -- Documental -> Jiro Dreams of Sushi
(1, 49),  -- Acción -> Pulp Fiction
(3, 49),  -- Drama -> Pulp Fiction
(1, 50),  -- Acción -> The Matrix
(4, 50),  -- Ciencia Ficción -> The Matrix
(1, 51),  -- Acción -> Fight Club
(3, 51),  -- Drama -> Fight Club
(3, 52),  -- Drama -> The Shawshank Redemption
(3, 53),  -- Drama -> Goodfellas
(1, 53),  -- Acción -> Goodfellas
(3, 54),  -- Drama -> The Godfather Part II
(3, 55),  -- Drama -> The Silence of the Lambs
(7, 55),  -- Terror -> The Silence of the Lambs
(1, 56),  -- Acción -> Saving Private Ryan
(3, 56),  -- Drama -> Saving Private Ryan
(3, 57),  -- Drama -> Titanic
(1, 58),  -- Acción -> Avatar
(4, 58),  -- Ciencia Ficción -> Avatar
(1, 59),  -- Acción -> The Revenant
(3, 59),  -- Drama -> The Revenant
(3, 60),  -- Drama -> The Wolf of Wall Street
(2, 60),  -- Comedia -> The Wolf of Wall Street
(3, 61),  -- Drama -> The Green Mile
(5, 61),  -- Fantasía -> The Green Mile
(3, 62),  -- Drama -> Se7en
(7, 62),  -- Terror -> Se7en
(1, 63),  -- Acción -> Django Unchained
(3, 63),  -- Drama -> Django Unchained
(3, 64),  -- Drama -> Once Upon a Time in Hollywood
(2, 64),  -- Comedia -> Once Upon a Time in Hollywood
(3, 65),  -- Drama -> Parasite
(2, 65),  -- Comedia -> Parasite
(3, 66),  -- Drama -> The Truman Show
(2, 66),  -- Comedia -> The Truman Show
(4, 67),  -- Ciencia Ficción -> The Prestige
(3, 67),  -- Drama -> The Prestige
(3, 68),  -- Drama -> Memento
(1, 68),  -- Acción -> Memento
(3, 69),  -- Drama -> The Usual Suspects
(1, 69),  -- Acción -> The Usual Suspects
(4, 70),  -- Ciencia Ficción -> Blade Runner
(1, 70),  -- Acción -> Blade Runner
(4, 71),  -- Ciencia Ficción -> Blade Runner 2049
(1, 71),  -- Acción -> Blade Runner 2049
(2, 72),  -- Comedia -> The Big Lebowski
(3, 72),  -- Drama -> The Big Lebowski
(3, 73),  -- Drama -> Joker
(1, 73),  -- Acción -> Joker
(3, 74),  -- Drama -> 12 Angry Men
(3, 75),  -- Drama -> The Pianist
(3, 76),  -- Drama -> A Beautiful Mind
(3, 77),  -- Drama -> Casablanca
(3, 78),  -- Drama -> Citizen Kane
(3, 79),  -- Drama -> Vertigo
(7, 79),  -- Terror -> Vertigo
(3, 80),  -- Drama -> Rear Window
(7, 80),  -- Terror -> Rear Window
(7, 81),  -- Terror -> Psycho
(3, 81),  -- Drama -> Psycho
(7, 82),  -- Terror -> The Shining
(3, 82),  -- Drama -> The Shining
(4, 83),  -- Ciencia Ficción -> 2001: A Space Odyssey
(1, 84),  -- Acción -> Apocalypse Now
(3, 84),  -- Drama -> Apocalypse Now
(1, 85),  -- Acción -> Full Metal Jacket
(3, 85),  -- Drama -> Full Metal Jacket
(6, 86),  -- Animación -> The Lion King
(5, 86),  -- Fantasía -> The Lion King
(6, 87),  -- Animación -> Toy Story
(2, 87),  -- Comedia -> Toy Story
(6, 88),  -- Animación -> Finding Nemo
(2, 88),  -- Comedia -> Finding Nemo
(6, 89),  -- Animación -> Up
(5, 89),  -- Fantasía -> Up
(6, 90),  -- Animación -> Inside Out
(5, 90),  -- Fantasía -> Inside Out
(6, 91),  -- Animación -> Coco
(5, 91),  -- Fantasía -> Coco
(6, 92),  -- Animación -> Ratatouille
(2, 92),  -- Comedia -> Ratatouille
(6, 93),  -- Animación -> WALL·E
(4, 93),  -- Ciencia Ficción -> WALL·E
(6, 94),  -- Animación -> The Incredibles
(1, 94),  -- Acción -> The Incredibles
(6, 95),  -- Animación -> Soul
(5, 95),  -- Fantasía -> Soul
(3, 96),  -- Drama -> Oppenheimer
(2, 97),  -- Comedia -> Barbie
(5, 97),  -- Fantasía -> Barbie
(4, 98),  -- Ciencia Ficción -> Dune
(1, 98);  -- Acción -> Dune


-- ==============================
-- DATOS PARA LA TABLA REPARTO
-- ==============================

INSERT INTO reparto (es_protagonista, nombre_personaje, id_actor, id_contenido) VALUES
-- El Padrino (1)
(1, 'Michael Corleone', 28, 1),
(1, 'Vito Corleone', 29, 1),
(0, 'Tom Hagen', 30, 1),

-- Forrest Gump (2)
(1, 'Forrest Gump', 1, 2),
(1, 'Jenny Curran', 2, 2),

-- El Caballero Oscuro (3)
(1, 'Bruce Wayne/Batman', 31, 3),
(1, 'Joker', 32, 3),

-- Inception (4)
(1, 'Dom Cobb', 31, 4),
(1, 'Mal', 2, 4),

-- Interstellar (5)
(1, 'Cooper', 1, 5),
(1, 'Dr. Amelia Brand', 33, 5),

-- Breaking Bad (6)
(1, 'Walter White', 34, 6),
(1, 'Jesse Pinkman', 35, 6),

-- Stranger Things (7)
(1, 'Eleven', 36, 7),
(1, 'Mike Wheeler', 37, 7),

-- Chernobyl (8)
(1, 'Valery Legasov', 17, 8),
(1, 'Boris Shcherbina', 38, 8),

-- The Social Network (10)
(1, 'Mark Zuckerberg', 39, 10),
(1, 'Eduardo Saverin', 40, 10),

-- La La Land (11)
(1, 'Sebastian', 41, 11),
(1, 'Mia', 42, 11),

-- El Laberinto del Fauno (12)
(1, 'Ofelia', 43, 12),
(1, 'Capitán Vidal', 44, 12),

-- Oldboy (13)
(1, 'Oh Dae-su', 21, 13),
(1, 'Lee Woo-jin', 45, 13),

-- El Gran Hotel Budapest (14)
(1, 'M. Gustave', 46, 14),
(1, 'Zero Moustafa', 47, 14),

-- Fargo (15)
(1, 'Jerry Lundegaard', 48, 15),
(1, 'Marge Gunderson', 49, 15),

-- Gladiador (20)
(1, 'Máximo Décimo Meridio', 50, 20),
(1, 'Cómodo', 51, 20),

-- American History X (21)
(1, 'Derek Vinyard', 52, 21),
(1, 'Danny Vinyard', 53, 21),

-- Whiplash (22)
(1, 'Andrew Neimann', 54, 22),
(1, 'Terence Fletcher', 55, 22),

-- The Irishman (23)
(1, 'Frank Sheeran', 30, 23),
(1, 'Jimmy Hoffa', 56, 23),

-- Amélie (28)
(1, 'Amélie Poulain', 57, 28),
(1, 'Nino Quincampoix', 58, 28),

-- Cinema Paradiso (29)
(1, 'Salvatore Di Vita (adulto)', 59, 29),
(1, 'Alfredo', 60, 29),

-- Spirited Away (30)
(1, 'Chihiro Ogino (voz)', 61, 30),
(1, 'Haku (voz)', 62, 30),

-- Parasite (65)
(1, 'Kim Ki-taek', 21, 65),
(1, 'Park Dong-ik', 63, 65),

-- The Matrix (50)
(1, 'Neo', 64, 50),
(1, 'Trinity', 65, 50),

-- Pulp Fiction (49)
(1, 'Vincent Vega', 66, 49),
(1, 'Jules Winnfield', 67, 49),

-- The Shawshank Redemption (52)
(1, 'Andy Dufresne', 68, 52),
(1, 'Ellis Boyd ''Red'' Redding', 69, 52),

-- Goodfellas (53)
(1, 'Henry Hill', 70, 53),
(1, 'Jimmy Conway', 30, 53),

-- The Godfather Part II (54)
(1, 'Michael Corleone', 28, 54),
(1, 'Vito Corleone', 30, 54),

-- Titanic (57)
(1, 'Jack Dawson', 31, 57),
(1, 'Rose DeWitt Bukater', 71, 57),

-- Avatar (58)
(1, 'Jake Sully', 72, 58),
(1, 'Neytiri', 73, 58),

-- The Revenant (59)
(1, 'Hugh Glass', 31, 59),
(1, 'John Fitzgerald', 32, 59),

-- Joker (73)
(1, 'Arthur Fleck/Joker', 74, 73),
(1, 'Murray Franklin', 75, 73),

-- The Lion King (86)
(1, 'Simba (voz adulto)', 76, 86),
(1, 'Scar (voz)', 77, 86),

-- Toy Story (87)
(1, 'Woody (voz)', 78, 87),
(1, 'Buzz Lightyear (voz)', 1, 87),

-- Finding Nemo (88)
(1, 'Marlin (voz)', 79, 88),
(1, 'Dory (voz)', 80, 88),

-- Up (89)
(1, 'Carl Fredricksen (voz)', 81, 89),
(1, 'Russell (voz)', 82, 89),

-- Coco (91)
(1, 'Miguel (voz)', 83, 91),
(1, 'Héctor (voz)', 84, 91),

-- Oppenheimer (96)
(1, 'J. Robert Oppenheimer', 85, 96),
(1, 'Lewis Strauss', 86, 96),

-- Barbie (97)
(1, 'Barbie', 87, 97),
(1, 'Ken', 41, 97),

-- Dune (98)
(1, 'Paul Atreides', 88, 98),
(1, 'Lady Jessica', 33, 98);


-- ==============================
-- DATOS PARA LA TABLA USUARIO 
-- ==============================

INSERT INTO usuario (nombre, apellido, email, fecha_registro, id_pais) VALUES
('Bruno', 'Pérez', 'bruno.perez@gmail.com', '2024-03-01', 1),
('Nicolas', 'Fernandez', 'nicolas.fernandez@gmail.com', '2024-04-15', 3),
('Franco', 'Montecino', 'franco.montecino@gmail.com', '2024-02-20', 2),
('Laura', 'Gómez', 'laura.gomez@hotmail.com', '2024-01-10', 1),
('Carlos', 'Rodríguez', 'carlos.rodriguez@yahoo.com', '2024-05-20', 4),
('Ana', 'Martínez', 'ana.martinez@gmail.com', '2024-03-15', 5),
('Diego', 'López', 'diego.lopez@outlook.com', '2024-02-05', 2),
('María', 'García', 'maria.garcia@gmail.com', '2024-04-01', 4),
('Javier', 'Hernández', 'javier.hernandez@hotmail.com', '2024-01-25', 14),
('Sofía', 'Ramírez', 'sofia.ramirez@gmail.com', '2024-05-05', 1),
('Miguel', 'Torres', 'miguel.torres@yahoo.com', '2024-03-30', 4),
('Elena', 'Díaz', 'elena.diaz@gmail.com', '2024-02-15', 5),
('Pedro', 'Santos', 'pedro.santos@outlook.com', '2024-04-25', 2),
('Carmen', 'Ortega', 'carmen.ortega@gmail.com', '2024-01-30', 1),
('Ricardo', 'Vargas', 'ricardo.vargas@hotmail.com', '2024-05-15', 3);

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
('2024-03-01', '2024-09-01', 9.99, 1, 2),
('2024-04-15', '2024-10-15', 14.99, 2, 3),
('2024-02-20', '2024-08-20', 5.99, 3, 1),
('2024-01-10', '2024-07-10', 14.99, 4, 3),
('2024-05-20', '2024-11-20', 9.99, 5, 2),
('2024-03-15', '2024-09-15', 14.99, 6, 3),
('2024-02-05', '2024-08-05', 5.99, 7, 1),
('2024-04-01', '2024-10-01', 9.99, 8, 2),
('2024-01-25', '2024-07-25', 14.99, 9, 3),
('2024-05-05', '2024-11-05', 5.99, 10, 1),
('2024-03-30', '2024-09-30', 9.99, 11, 2),
('2024-02-15', '2024-08-15', 14.99, 12, 3),
('2024-04-25', '2024-10-25', 5.99, 13, 1),
('2024-01-30', '2024-07-30', 9.99, 14, 2),
('2024-05-15', '2024-11-15', 14.99, 15, 3);

-- ==============================
-- DATOS PARA LA TABLA RESEÑA 
-- ==============================

INSERT INTO reseña (fecha_reseña, valoracion, id_contenido, id_usuario) VALUES
-- Reseñas para El Padrino
('2024-03-05', 5, 1, 1),
('2024-03-10', 5, 1, 2),
('2024-03-15', 4, 1, 3),

-- Reseñas para Forrest Gump
('2024-03-12', 5, 2, 4),
('2024-03-18', 4, 2, 5),
('2024-03-20', 5, 2, 6),

-- Reseñas para El Caballero Oscuro
('2024-03-25', 5, 3, 7),
('2024-03-28', 5, 3, 8),
('2024-04-01', 4, 3, 9),

-- Reseñas para Inception
('2024-04-05', 5, 4, 10),
('2024-04-08', 4, 4, 11),
('2024-04-10', 5, 4, 12),

-- Reseñas para Breaking Bad
('2024-04-15', 5, 6, 13),
('2024-04-20', 5, 6, 14),
('2024-04-25', 5, 6, 15),

-- Reseñas para Stranger Things
('2024-05-01', 4, 7, 1),
('2024-05-05', 5, 7, 2),
('2024-05-10', 4, 7, 3),

-- Reseñas para Chernobyl
('2024-05-15', 5, 8, 4),
('2024-05-20', 5, 8, 5),
('2024-05-25', 5, 8, 6),

-- Reseñas para Parasite
('2024-06-01', 5, 65, 7),
('2024-06-05', 4, 65, 8),
('2024-06-10', 5, 65, 9),

-- Reseñas para The Matrix
('2024-06-15', 5, 50, 10),
('2024-06-20', 4, 50, 11),
('2024-06-25', 5, 50, 12),

-- Reseñas para The Shawshank Redemption
('2024-07-01', 5, 52, 13),
('2024-07-05', 5, 52, 14),
('2024-07-10', 5, 52, 15);

-- ==============================
-- DATOS PARA LA TABLA REPRODUCCION 
-- ==============================

INSERT INTO reproduccion (fecha_reproduccion, progreso_minutos, id_contenido, id_usuario) VALUES
-- Reproducciones de Bruno (Usuario 1)
('2024-03-01', 45, 1, 1),
('2024-03-02', 175, 1, 1), -- Completado
('2024-03-05', 60, 7, 1),
('2024-03-10', 142, 2, 1), -- Completado
('2024-03-15', 30, 6, 1),

-- Reproducciones de Nicolas (Usuario 2)
('2024-04-16', 20, 3, 2),
('2024-04-17', 152, 3, 2), -- Completado
('2024-04-20', 90, 4, 2),
('2024-04-25', 148, 4, 2), -- Completado
('2024-04-28', 50, 8, 2),

-- Reproducciones de Franco (Usuario 3)
('2024-02-21', 127, 2, 3), -- Completado
('2024-02-25', 60, 1, 3),
('2024-03-01', 175, 1, 3), -- Completado
('2024-03-05', 45, 3, 3),

-- Reproducciones de Laura (Usuario 4)
('2024-01-11', 80, 65, 4),
('2024-01-12', 132, 65, 4), -- Completado
('2024-01-15', 60, 28, 4),
('2024-01-20', 122, 28, 4), -- Completado

-- Reproducciones de Carlos (Usuario 5)
('2024-05-21', 45, 50, 5),
('2024-05-22', 136, 50, 5), -- Completado
('2024-05-25', 30, 51, 5),
('2024-05-28', 139, 51, 5), -- Completado

-- Reproducciones de Ana (Usuario 6)
('2024-03-16', 100, 52, 6),
('2024-03-17', 142, 52, 6), -- Completado
('2024-03-20', 60, 53, 6),
('2024-03-25', 146, 53, 6), -- Completado

-- Reproducciones de Diego (Usuario 7)
('2024-02-06', 75, 11, 7),
('2024-02-07', 128, 11, 7), -- Completado
('2024-02-10', 50, 12, 7),
('2024-02-15', 119, 12, 7), -- Completado

-- Reproducciones de María (Usuario 8)
('2024-04-02', 60, 20, 8),
('2024-04-03', 155, 20, 8), -- Completado
('2024-04-06', 45, 19, 8),
('2024-04-10', 195, 19, 8), -- Completado

-- Reproducciones de Javier (Usuario 9)
('2024-01-26', 90, 30, 9),
('2024-01-27', 125, 30, 9), -- Completado
('2024-01-30', 60, 31, 9),
('2024-02-02', 106, 31, 9), -- Completado

-- Reproducciones de Sofía (Usuario 10)
('2024-05-06', 45, 40, 10),
('2024-05-07', 126, 40, 10), -- Completado
('2024-05-10', 80, 41, 10),
('2024-05-12', 111, 41, 10); -- Completado

-- ==============================
-- DATOS COMPLETOS PARA LA TABLA TEMPORADA 
-- ==============================

INSERT INTO temporada (nro_temporada, resumen, id_contenido) VALUES
-- Breaking Bad (5 temporadas)
(1, 'Walter White, un profesor de química con cáncer, se asocia con un exalumno para fabricar metanfetamina y asegurar el futuro de su familia.', 6),
(2, 'Walter y Jesse expanden su negocio mientras lidian con nuevas amenazas y las consecuencias de sus acciones.', 6),
(3, 'La entrada de Gus Fring cambia por completo el juego del narcotráfico en Albuquerque.', 6),
(4, 'La guerra entre Walter White y Gus Fring llega a su punto máximo con consecuencias devastadoras.', 6),
(5, 'El ascenso y caída final de Heisenberg en el imperio de las drogas.', 6),

-- Stranger Things (4 temporadas)
(1, 'La desaparición de Will Byers revela misterios sobrenaturales y experimentos secretos en Hawkins.', 7),
(2, 'Los habitantes de Hawkins enfrentan nuevas amenazas del Mundo del Revés y sus propias batallas personales.', 7),
(3, 'El verano en Hawkins se ve interrumpido por nuevas fuerzas malignas y conspiraciones soviéticas.', 7),
(4, 'Los eventos se expanden más allá de Hawkins con consecuencias globales y revelaciones impactantes.', 7),

-- Chernobyl (1 temporada)
(1, 'Recreación minuciosa del desastre nuclear de Chernobyl y sus devastadoras consecuencias humanas y políticas.', 8),

-- El Método Kominsky (3 temporadas)
(1, 'Un actor retirado y su agente navegan los desafíos de la vejez, la amistad y Hollywood.', 9),
(2, 'Sandy y Norman enfrentan nuevos desafíos personales y profesionales en sus vidas doradas.', 9),
(3, 'Las despedidas, nuevos comienzos y reflexiones finales en la vida de los protagonistas.', 9),

-- Mindhunter (2 temporadas)
(1, 'Agentes del FBI pioneros desarrollan técnicas revolucionarias para entrevistar asesinos en serie.', 16),
(2, 'Los agentes investigan los crímenes de BTK y el terrible asesinato de niños en Atlanta.', 16),

-- True Detective (4 temporadas)
(1, 'Dos detectives con personalidades opuestas investigan un ritualístico asesinato en Louisiana durante 17 años.', 17),
(2, 'Una compleja investigación de corrupción entrelaza a policías, criminales y políticos en California.', 17),
(3, 'Un caso sin resolver de desapariciones afecta a un detective décadas después en el Ozark.', 17),
(4, 'Investigación de desapariciones en Alaska durante la noche polar, revelando secretos ancestrales.', 17),

-- House of Cards (6 temporadas)
(1, 'Frank Underwood inicia su metódico y despiadado ascenso al poder en Washington.', 18),
(2, 'Frank consolida su poder como vicepresidente mientras elimina obstáculos en su camino.', 18),
(3, 'Frank enfrenta desafíos inesperados como presidente y tensiones en su matrimonio.', 18),
(4, 'Campaña de reelección llena de amenazas y la revelación pública de sus maquinaciones.', 18),
(5, 'Frank y Claire luchan desesperadamente por mantener el control ante investigaciones.', 18),
(6, 'Claire asume la presidencia tras Frank, enfrentando su propio legado y desafíos.', 18),

-- The Handmaid''s Tale (5 temporadas)
(1, 'June es forzada a ser criada en el régimen teocrático de Gilead, luchando por sobrevivir.', 32),
(2, 'June lucha por liberar a su hija de Gilead mientras enfrenta embarazo y opresión.', 32),
(3, 'June organiza la resistencia contra Gilead y busca rescatar a más niños del régimen.', 32),
(4, 'June se convierte en objetivo prioritario de Gilead mientras busca venganza y libertad.', 32),
(5, 'La guerra contra Gilead se intensifica con consecuencias para todos los personajes.', 32),

-- Black Mirror (6 temporadas)
(1, 'Antología que explora el lado oscuro de la tecnología moderna y su impacto en la sociedad.', 33),
(2, 'Nuevas historias perturbadoras sobre tecnología, realidad y relaciones humanas.', 33),
(3, 'Exploración de realidades alternativas, redes sociales y mundos virtuales.', 33),
(4, 'Inteligencia artificial, mundos virtuales y los límites de la conciencia digital.', 33),
(5, 'Historias personales íntimas en un mundo cada vez más tecnológico y desconectado.', 33),
(6, 'Nuevos formatos y narrativas que desafían las convenciones tecnológicas.', 33),

-- Six Feet Under (5 temporadas)
(1, 'La familia Fisher maneja una funeraria mientras enfrenta la vida, muerte y relaciones familiares.', 43),
(2, 'Los Fisher lidian con relaciones complicadas, pérdidas personales y secretos familiares.', 43),
(3, 'Cambios profesionales y personales transforman a cada miembro de la familia Fisher.', 43),
(4, 'Crisis existenciales, nuevos comienzos y confrontaciones con el pasado.', 43),
(5, 'El final del viaje emocional de la familia Fisher y reflexiones sobre la vida y muerte.', 43);

-- ==============================
-- DATOS PARA LA TABLA EPISODIO 
-- ==============================

-- Breaking Bad Temporada 1 (7 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Pilot', 1, 58, 'Walter White descubre que tiene cáncer de pulmón y decide fabricar metanfetamina con un exalumno.', 1, 6),
('Cat''s in the Bag...', 2, 48, 'Walter y Jesse lidian con las consecuencias de su primer encuentro con Emilio y Krazy-8.', 1, 6),
('...And the Bag''s in the River', 3, 48, 'Walter toma una decisión difícil sobre Krazy-8 mientras Skyler sospecha de su comportamiento.', 1, 6),
('Cancer Man', 4, 48, 'Walter considera el tratamiento contra el cáncer mientras continúa cocinando metanfetamina.', 1, 6),
('Gray Matter', 5, 48, 'Walter rechaza la ayuda de sus antiguos socios y enfrenta tensiones familiares.', 1, 6),
('Crazy Handful of Nothin''', 6, 48, 'Walter usa sus conocimientos de química para enfrentarse a Tuco Salamanca.', 1, 6),
('A No-Rough-Stuff-Type Deal', 7, 48, 'Walter y Jesse negocian un acuerdo con el volátil Tuco Salamanca.', 1, 6);

-- Breaking Bad Temporada 2 (13 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Seven Thirty-Seven', 1, 47, 'Walter y Jesse planean cómo lidiar con Tuco después de los eventos de la temporada 1.', 2, 6),
('Grilled', 2, 48, 'Walter y Jesse son llevados a la guarida de Tuco y luchan por sobrevivir.', 2, 6),
('Bit by a Dead Bee', 3, 48, 'Walter idea una cobertura para su desaparición mientras Jesse enfrenta interrogatorios.', 2, 6),
('Down', 4, 48, 'Jesse toca fondo mientras Walter intenta reconciliarse con su familia.', 2, 6),
('Breakage', 5, 48, 'Jesse expande el negocio con nuevos distribuidores mientras Skyler sospecha.', 2, 6),
('Peekaboo', 6, 48, 'Jesse recupera el dinero de unos drogadictos que robaron a Skinny Pete.', 2, 6),
('Negro y Azul', 7, 48, 'Walter regresa a trabajar mientras Hank investiga el caso "Heisenberg".', 2, 6),
('Better Call Saul', 8, 48, 'Walter y Jesse conocen al abogado Saul Goodman para resolver problemas legales.', 2, 6),
('4 Days Out', 9, 48, 'Walter y Jesse quedan varados en el desierto durante una cocina de emergencia.', 2, 6),
('Over', 10, 48, 'Walter compra una casa nueva mientras la familia se adapta a los cambios.', 2, 6),
('Mandala', 11, 48, 'La necesidad de dinero lleva a Walter y Jesse a un acuerdo riesgoso con Gus.', 2, 6),
('Phoenix', 12, 48, 'Un evento familiar lleva a Walter a tomar una decisión que cambia todo.', 2, 6),
('ABQ', 13, 48, 'Las consecuencias de las acciones de Walter afectan a todos a su alrededor.', 2, 6);

-- Breaking Bad Temporada 3 (13 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('No Más', 1, 48, 'Walter lidia con las consecuencias de sus acciones mientras Gus ofrece una oportunidad.', 3, 6),
('Caballo sin Nombre', 2, 48, 'Walter se muda de casa mientras Jesse se adentra en el negocio de la metanfetamina.', 3, 6),
('I.F.T.', 3, 48, 'Skyler descubre la verdad sobre Walter mientras Jesse conoce a Gale.', 3, 6),
('Verde', 4, 48, 'Walter comienza a trabajar para Gus mientras la familia enfrenta problemas financieros.', 3, 6),
('Más', 5, 48, 'Jesse gasta su dinero extravagantemente mientras Walter se adapta al nuevo trabajo.', 3, 6),
('Vuelo', 6, 48, 'Un avión se estrella cerca de la casa de White mientras las tensiones aumentan.', 3, 6),
('Un Día', 7, 48, 'Walter y Jesse trabajan juntos en el superlaboratorio de Gus.', 3, 6),
('Veo a Toda Gente', 8, 48, 'Hank investiga el laboratorio de metanfetamina mientras Walter se preocupa por Gale.', 3, 6),
('Kafkaesque', 9, 48, 'Walter lava dinero a través del negocio de lavado de autos mientras Skyler ayuda.', 3, 6),
('Mosca', 10, 48, 'Walter se obsesiona con una mosca en el laboratorio, revelando su culpa y estrés.', 3, 6),
('Abiquiu', 11, 48, 'Skyler maneja el lavado de dinero mientras Jesse conoce a Andrea.', 3, 6),
('Medidas Desesperadas', 12, 48, 'Walter idea un plan para eliminar a Gale y salvar a Jesse.', 3, 6),
('Full Measure', 13, 48, 'Walter toma medidas extremas para proteger su operación y su vida.', 3, 6);

-- Breaking Bad Temporada 4 (13 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Box Cutter', 1, 48, 'Gus demuestra su naturaleza despiadada tras la desaparición de Gale.', 4, 6),
('Thirty-Eight Snub', 2, 48, 'Walter compra un arma mientras Jesse se hunde en la lujuria y las drogas.', 4, 6),
('Open House', 3, 48, 'Marie roba habitaciones abiertas mientras Skyler expande el negocio de lavado.', 4, 6),
('Bullet Points', 4, 48, 'Walter y Skyler preparan su cobertura mientras Hank comparte su investigación.', 4, 6),
('Shotgun', 5, 48, 'Gus lleva a Jesse en viajes misteriosos mientras Mike lo vigila.', 4, 6),
('Cornered', 6, 48, 'Walter se da cuenta de que no es el peligroso que cree ser.', 4, 6),
('Problem Dog', 7, 48, 'Jesse lidia con las consecuencias de sus acciones en el grupo de apoyo.', 4, 6),
('Hermanos', 8, 48, 'Flashbacks revelan la historia entre Gus y Hector Salamanca.', 4, 6),
('Bug', 9, 48, 'Walter intenta envenenar a Gus mientras la tensión llega a su punto máximo.', 4, 6),
('Salud', 10, 48, 'Walter Jr. bebe demasiado mientras Gus viaja a México.', 4, 6),
('Crawl Space', 11, 48, 'Walter enfrenta una crisis mientras Gus amenaza a su familia.', 4, 6),
('End Times', 12, 48, 'Walter y Jesse unen fuerzas en un último esfuerzo por sobrevivir.', 4, 6),
('Face Off', 13, 48, 'El enfrentamiento final entre Walter y Gus cambia todo para siempre.', 4, 6);

-- Breaking Bad Temporada 5 (16 episodios - dividida en dos partes)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
-- Parte 1
('Live Free or Die', 1, 48, 'Walter, Jesse y Mike limpian las evidencias del laboratorio de Gus.', 5, 6),
('Madrigal', 2, 48, 'Mike investiga la eliminación de sus hombres mientras Walter expande su imperio.', 5, 6),
('Hazard Pay', 3, 48, 'El trío establece un nuevo laboratorio en casas fumigadas.', 5, 6),
('Fifty-One', 4, 48, 'Skyler se desespera por la influencia de Walter en la familia.', 5, 6),
('Dead Freight', 5, 48, 'El equipo ejecuta un audaz robo de metilamina de un tren.', 5, 6),
('Buyout', 6, 48, 'Jesse quiere dejar el negocio después del robo del tren.', 5, 6),
('Say My Name', 7, 48, 'Walter negocia con Declan mientras Mike quiere retirarse.', 5, 6),
('Gliding Over All', 8, 48, 'Walter elimina a sus enemigos mientras Hank hace un descubrimiento impactante.', 5, 6),
-- Parte 2
('Blood Money', 9, 48, 'Hank confronta a Walter sobre su identidad como Heisenberg.', 5, 6),
('Buried', 10, 48, 'Walter esconde su dinero mientras Skyler enfrenta interrogatorios.', 5, 6),
('Confessions', 11, 48, 'Walter graba una falsa confesión que implica a Hank.', 5, 6),
('Rabid Dog', 12, 48, 'Jesse planea quemar la casa de Walter después de descubrir la verdad.', 5, 6),
('To''hajiilee', 13, 48, 'Hank y Jesse tienden una trampa a Walter con su dinero enterrado.', 5, 6),
('Ozymandias', 14, 48, 'El enfrentamiento final tiene consecuencias devastadoras para todos.', 5, 6),
('Granite State', 15, 48, 'Walter escapa a New Hampshire mientras su imperio se desmorona.', 5, 6),
('Felina', 16, 48, 'Walter regresa a Albuquerque para un enfrentamiento final y redención.', 5, 6);

-- Stranger Things Temporada 1 (8 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('The Vanishing of Will Byers', 1, 47, 'Will Byers desaparece misteriosamente en Hawkins, Indiana.', 2, 7),
('The Weirdo on Maple Street', 2, 55, 'Los amigos encuentran a una niña misteriosa con poderes telequinéticos.', 2, 7),
('Holly, Jolly', 3, 51, 'La madre de Will tiene visiones mientras Nancy busca a su amiga desaparecida.', 2, 7),
('The Body', 4, 49, 'El cuerpo de Will es encontrado, pero Joyce cree que todavía está vivo.', 2, 7),
('The Flea and the Acrobat', 5, 52, 'El grupo busca un portal al Mundo del Revés.', 2, 7),
('The Monster', 6, 47, 'Once revela la verdad sobre el laboratorio y el monstruo.', 2, 7),
('The Bathtub', 7, 41, 'El grupo se prepara para entrar al Mundo del Revés.', 2, 7),
('The Upside Down', 8, 54, 'El grupo entra al Mundo del Revés para rescatar a Will.', 2, 7);

-- Stranger Things Temporada 2 (9 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('MADMAX', 1, 48, 'Un año después, nuevos misterios emergen en Hawkins.', 3, 7),
('Trick or Treat, Freak', 2, 56, 'Halloween en Hawkins se vuelve peligroso con nuevas amenazas.', 3, 7),
('The Pollywog', 3, 51, 'Dustin encuentra una criatura misteriosa y la esconde.', 3, 7),
('Will the Wise', 4, 50, 'Will tiene visiones aterradoras del Mundo del Revés.', 3, 7),
('Dig Dug', 5, 47, 'Hopper queda atrapado mientras investiga los túneles.', 3, 7),
('The Spy', 6, 51, 'Will se convierte en un espía involuntario del Mind Flayer.', 3, 7),
('The Lost Sister', 7, 46, 'Once viaja a Chicago para encontrar a otros como ella.', 3, 7),
('The Mind Flayer', 8, 47, 'El grupo descubre la verdadera naturaleza del Mind Flayer.', 3, 7),
('The Gate', 9, 62, 'Confrontación final para cerrar el portal al Mundo del Revés.', 3, 7);

-- Stranger Things Temporada 3 (8 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Suzie, Do You Copy?', 1, 51, 'Verano en Hawkins, nuevos romances y fuerzas malignas emergen.', 4, 7),
('The Mall Rats', 2, 50, 'El nuevo centro comercial esconde oscuros secretos.', 4, 7),
('The Case of the Missing Lifeguard', 3, 50, 'Heather desaparece mientras el grupo investiga.', 4, 7),
('The Sauna Test', 4, 53, 'El grupo prueba una teoría sobre los poseídos.', 4, 7),
('The Flayed', 5, 52, 'Descubren la verdad sobre los aplanados y su propósito.', 4, 7),
('E Pluribus Unum', 6, 50, 'El Mind Flayer comienza su transformación final.', 4, 7),
('The Bite', 7, 55, 'Uno del grupo es herido mientras luchan contra el Mind Flayer.', 4, 7),
('The Battle of Starcourt', 8, 78, 'Batalla final en el centro comercial Starcourt.', 4, 7);

-- Stranger Things Temporada 4 (9 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('The Hellfire Club', 1, 78, 'Seis meses después, el grupo está separado y nuevos horrores emergen.', 5, 7),
('Vecna''s Curse', 2, 75, 'Una nueva criatura aterroriza Hawkins con muertes misteriosas.', 5, 7),
('The Monster and the Superhero', 3, 63, 'Once intenta recuperar sus poderes mientras el grupo investiga.', 5, 7),
('Dear Billy', 4, 78, 'Max enfrenta a Vecna en una carrera contra el tiempo.', 5, 7),
('The Nina Project', 5, 72, 'El proyecto para recuperar los poderes de Once avanza.', 5, 7),
('The Dive', 6, 75, 'El grupo se aventura en el Lago Cristal para encontrar un portal.', 5, 7),
('The Massacre at Hawkins Lab', 7, 98, 'Flashbacks revelan el origen de Vecna y la masacre.', 5, 7),
('Papa', 8, 85, 'Once enfrenta su pasado mientras Vecna ataca.', 5, 7),
('The Piggyback', 9, 139, 'Batalla final contra Vecna que determinará el destino de Hawkins.', 5, 7);

-- Chernobyl (5 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('1:23:45', 1, 65, 'El desastre nuclear de Chernobyl comienza durante una prueba de seguridad.', 6, 8),
('Please Hold My Hand', 2, 62, 'Las consecuencias del desastre se hacen evidentes mientras llegan los primeros respondedores.', 6, 8),
('Open Wide, O Earth', 3, 67, 'La lucha desesperada por contener la radiación y evacuar Pripyat.', 6, 8),
('The Happiness of All Mankind', 4, 67, 'Soluciones extremas para limpiar el techo altamente radiactivo.', 6, 8),
('Vichnaya Pamyat', 5, 72, 'El juicio final y las consecuencias políticas del desastre.', 6, 8);

-- The Handmaid''s Tale Temporada 1 (10 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Offred', 1, 52, 'June se adapta a su nueva vida como criada en el régimen de Gilead.', 8, 32),
('Birth Day', 2, 52, 'June asiste a un parto que prueba su resistencia y humanidad.', 8, 32),
('Late', 3, 52, 'June se reencuentra con su amiga Moira en los centros de entrenamiento.', 8, 32),
('Nolite Te Bastardes Carborundorum', 4, 52, 'June descubre un mensaje secreto de la criada anterior.', 8, 32),
('Faithful', 5, 52, 'La esposa de Nick llega a la casa mientras June enfrenta tentaciones.', 8, 32),
('A Woman''s Place', 6, 52, 'Serena Joy recuerda su papel en la creación de Gilead.', 8, 32),
('The Other Side', 7, 52, 'Luke intenta sobrevivir en Canadá mientras busca a June.', 8, 32),
('Jezebels', 8, 52, 'June visita un club clandestino para elites de Gilead.', 8, 32),
('The Bridge', 9, 52, 'June enfrenta consecuencias después de desobedecer las reglas.', 8, 32),
('Night', 10, 52, 'June toma una decisión crucial sobre su futuro en Gilead.', 8, 32);

-- Black Mirror Temporada 1 (3 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('The National Anthem', 1, 44, 'El primer ministro enfrenta una demanda surrealista para salvar a una princesa.', 9, 33),
('Fifteen Million Merits', 2, 62, 'Un mundo distópico donde el ejercicio genera energía y el entretenimiento es escape.', 9, 33),
('The Entire History of You', 3, 49, 'Tecnología que permite revisar memorias destruye una relación.', 9, 33);

-- Black Mirror Temporada 2 (4 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Be Right Back', 1, 48, 'Una mujer usa tecnología para recrear a su difunto esposo.', 10, 33),
('White Bear', 2, 42, 'Una mujer despierta sin memoria en un mundo donde es perseguida.', 10, 33),
('The Waldo Moment', 3, 43, 'Un personaje de dibujos animados se postula para elecciones.', 10, 33),
('White Christmas', 4, 74, 'Tres historias entrelazadas sobre tecnología y conciencia.', 10, 33);

-- Black Mirror Temporada 3 (6 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Nosedive', 1, 63, 'Una mujer obsesionada con su calificación social busca mejorar su estatus.', 11, 33),
('Playtest', 2, 57, 'Un viajero prueba un videojuego de realidad aumentada extremadamente realista.', 11, 33),
('Shut Up and Dance', 3, 52, 'Un adolescente es chantajeado después de ser hackeado.', 11, 33),
('San Junipero', 4, 61, 'Dos mujeres se enamoran en un mundo virtual de los años 80.', 11, 33),
('Men Against Fire', 5, 60, 'Un soldado descubre la verdad sobre su misión de exterminio.', 11, 33),
('Hated in the Nation', 6, 89, 'Abejas robóticas son usadas para asesinatos en masa en redes sociales.', 11, 33);

-- Six Feet Under Temporada 1 (13 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Pilot', 1, 55, 'La familia Fisher enfrenta la muerte del patriarca y el futuro de la funeraria.', 12, 43),
('The Will', 2, 50, 'La lectura del testamento revela sorpresas para la familia.', 12, 43),
('The Foot', 3, 50, 'Nate conoce a Brenda mientras David lucha con su sexualidad.', 12, 43),
('Familia', 4, 50, 'Ruth visita a su hermana mientras los hijos lidian con relaciones.', 12, 43),
('An Open Book', 5, 50, 'Un cliente inusual desafía las tradiciones de la funeraria.', 12, 43),
('The Room', 6, 50, 'Nate descubre secretos sobre su padre en una habitación oculta.', 12, 43),
('Brotherhood', 7, 50, 'David se une a una organización fraternal mientras Nate enfrenta su pasado.', 12, 43),
('Crossroads', 8, 50, 'Decisiones cruciales afectan a cada miembro de la familia.', 12, 43),
('Life''s Too Short', 9, 50, 'Un diagnóstico médico cambia la perspectiva de un personaje.', 12, 43),
('The New Person', 10, 50, 'Una nueva empleada trae cambios a la funeraria.', 12, 43),
('The Trip', 11, 50, 'Un viaje revela verdades incómodas sobre las relaciones.', 12, 43),
('A Private Life', 12, 50, 'Secretos personales salen a la luz afectando a todos.', 12, 43),
('Knock, Knock', 13, 55, 'Final de temporada con revelaciones y nuevos comienzos.', 12, 43);

-- True Detective Temporada 1 (8 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('The Long Bright Dark', 1, 58, 'Dos detectives con personalidades opuestas investigan un ritualístico asesinato.', 13, 17),
('Seeing Things', 2, 58, 'La investigación revela conexiones inesperadas con ocultismo.', 13, 17),
('The Locked Room', 3, 58, 'Los detectives siguen pistas sobre una secta misteriosa.', 13, 17),
('Who Goes There', 4, 58, 'Una peligrosa incursión en territorio criminal.', 13, 17),
('The Secret Fate of All Life', 5, 58, 'El caso parece resolverse pero quedan dudas.', 13, 17),
('Haunted Houses', 6, 58, 'Flashbacks revelan los problemas personales de los detectives.', 13, 17),
('After You''ve Gone', 7, 58, 'La investigación se reabre años después.', 13, 17),
('Form and Void', 8, 58, 'Resolución final del caso después de 17 años.', 13, 17);

-- Mindhunter Temporada 1 (10 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Episode 1', 1, 54, 'Los agentes Holden y Bill entrevistan a su primer asesino en serie.', 14, 16),
('Episode 2', 2, 51, 'Desarrollan técnicas de entrevista con asesinos en serie.', 14, 16),
('Episode 3', 3, 59, 'Investigan el caso de un hombre que asesina abuelas.', 14, 16),
('Episode 4', 4, 59, 'Holden entrevista a Monte Rissell sobre sus crímenes.', 14, 16),
('Episode 5', 5, 56, 'Los agentes viajan a California para entrevistar a más asesinos.', 14, 16),
('Episode 6', 6, 56, 'Holden entrevista a Richard Speck sobre la masacre de enfermeras.', 14, 16),
('Episode 7', 7, 58, 'La investigación del BTK comienza a tomar forma.', 14, 16),
('Episode 8', 8, 56, 'Holden entrevista a Jerry Brudos, el asesino fetiche.', 14, 16),
('Episode 9', 9, 58, 'Tensiones en el equipo mientras el caso se complica.', 14, 16),
('Episode 10', 10, 57, 'Holden enfrenta las consecuencias de sus métodos poco ortodoxos.', 14, 16);

-- Mindhunter Temporada 2 (9 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Episode 1', 1, 59, 'Los agentes investigan los asesinatos de niños en Atlanta.', 15, 16),
('Episode 2', 2, 56, 'Holden se recupera mientras el equipo viaja a Atlanta.', 15, 16),
('Episode 3', 3, 62, 'Entrevistan a Charles Manson en prisión.', 15, 16),
('Episode 4', 4, 58, 'La investigación en Atlanta enfrenta obstáculos raciales.', 15, 16),
('Episode 5', 5, 60, 'Bill lidia con problemas familiares por el trabajo.', 15, 16),
('Episode 6', 6, 58, 'El equipo desarrolla un perfil del asesino de Atlanta.', 15, 16),
('Episode 7', 7, 64, 'Tensiones raciales y políticas afectan la investigación.', 15, 16),
('Episode 8', 8, 59, 'Un avance crucial en el caso de Atlanta.', 15, 16),
('Episode 9', 9, 68, 'Resolución del caso de Atlanta con consecuencias para todos.', 15, 16);

-- House of Cards Temporada 1 (13 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Chapter 1', 1, 51, 'Frank Underwood es pasado por alto para Secretario de Estado.', 16, 18),
('Chapter 2', 2, 49, 'Frank comienza su venganza metódica contra sus enemigos.', 16, 18),
('Chapter 3', 3, 52, 'Frank manipula a un congresista para que renuncie.', 16, 18),
('Chapter 4', 4, 48, 'Claire enfrenta su pasado mientras Frank consolida poder.', 16, 18),
('Chapter 5', 5, 50, 'Frank orquesta una crisis educativa para su beneficio.', 16, 18),
('Chapter 6', 6, 51, 'Zoe Barnes publica una historia explosiva sobre Frank.', 16, 18),
('Chapter 7', 7, 49, 'Frank enfrenta una audiencia congresional difícil.', 16, 18),
('Chapter 8', 8, 52, 'Claire lidia con consecuencias de sus acciones pasadas.', 16, 18),
('Chapter 9', 9, 50, 'Frank manipula una huelga de profesores.', 16, 18),
('Chapter 10', 10, 51, 'La relación de Frank con Zoe se vuelve peligrosa.', 16, 18),
('Chapter 11', 11, 49, 'Frank prepara su movimiento final hacia la vicepresidencia.', 16, 18),
('Chapter 12', 12, 52, 'Frank elimina los últimos obstáculos en su camino.', 16, 18),
('Chapter 13', 13, 53, 'Frank alcanza la vicepresidencia con consecuencias inesperadas.', 16, 18);

-- El Método Kominsky Temporada 1 (8 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Chapter 1: An Actor Avoids', 1, 30, 'Sandy Kominsky enfrenta la muerte de su agente y mejor amigo.', 17, 9),
('Chapter 2: An Agent Grieves', 2, 26, 'Sandy ayuda a Norman con el funeral mientras lidia con su propia pena.', 17, 9),
('Chapter 3: A Prostate Enlarges', 3, 27, 'Sandy enfrenta problemas de salud de la mediana edad.', 17, 9),
('Chapter 4: A Daughter Detoxes', 4, 28, 'La hija de Sandy llega a la ciudad con problemas.', 17, 9),
('Chapter 5: An Afternoon With Sex', 5, 26, 'Sandy intenta revivir su vida sexual con resultados mixtos.', 17, 9),
('Chapter 6: A Thetan Arrives', 6, 27, 'Sandy conoce al nuevo novio de su hija, un científico.', 17, 9),
('Chapter 7: A String Is Attached', 7, 28, 'Sandy considera hacer una película comercial por dinero.', 17, 9),
('Chapter 8: A Normal Heart', 8, 29, 'Sandy enfrenta decisiones sobre su carrera y relaciones.', 17, 9);

-- El Método Kominsky Temporada 2 (8 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Chapter 9: Round Two', 1, 28, 'Sandy comienza a enseñar actuación mientras lidia con nuevos desafíos.', 18, 9),
('Chapter 10: You Only Give Me Your Funny Paper', 2, 27, 'Sandy ayuda a Mindy con problemas financieros.', 18, 9),
('Chapter 11: A Thetan Emerges', 3, 26, 'El novio de Phoebe causa problemas en la familia.', 18, 9),
('Chapter 12: A Night of the Iguana', 4, 28, 'Sandy tiene una cita desastrosa con una ex alumna.', 18, 9),
('Chapter 13: A River of Cash', 5, 27, 'Problemas de dinero llevan a decisiones difíciles.', 18, 9),
('Chapter 14: A Thetan Drops', 6, 26, 'La relación de Phoebe llega a un punto crítico.', 18, 9),
('Chapter 15: Near, Far, Wherever You Are', 7, 28, 'Sandy considera mudarse por una relación.', 18, 9),
('Chapter 16: Jettison the Lumber', 8, 29, 'Decisiones finales sobre el futuro y las relaciones.', 18, 9);

-- El Método Kominsky Temporada 3 (6 episodios)
INSERT INTO episodio (titulo, nro_episodio, duracion, resumen, id_temporada, id_contenido) VALUES
('Chapter 17: Inconsolable', 1, 28, 'Sandy lidia con el duelo mientras comienza una nueva relación.', 19, 9),
('Chapter 18: You Do See Me', 2, 27, 'Sandy enfrenta problemas de salud con humor y dignidad.', 19, 9),
('Chapter 19: And It''s Getting More and More Absurd', 3, 26, 'Las complicaciones románticas se intensifican.', 19, 9),
('Chapter 20: I''m Going to Miss You', 4, 28, 'Sandy considera grandes cambios en su vida.', 19, 9),
('Chapter 21: The Round Toes, of the High Shoes', 5, 27, 'Reflexiones sobre la vida, el amor y la mortalidad.', 19, 9),
('Chapter 22: The Fundamental Things Apply', 6, 29, 'Final de la serie con conclusiones emocionales.', 19, 9);

-- ==============================
-- DATOS PARA LA TABLA PERFIL 
-- ==============================

INSERT INTO perfil (nombre_perfil, restriccion, id_usuario) VALUES
-- Perfiles para Bruno (Usuario 1)
('Bruno', 'Sin restricción', 1),
('Bruno_Kids', 'Infantil', 1),

-- Perfiles para Nicolas (Usuario 2)
('Nicolas', 'Sin restricción', 2),
  
-- Perfiles para Franco (Usuario 3)
('Franco', 'Todo público', 3),

-- Perfiles para Laura (Usuario 4)
('Laura', 'Sin restricción', 4),
  
-- Perfiles para Carlos (Usuario 5)
('Carlos', 'Sin restricción', 5),
('Carlos_Kids', 'Infantil', 5),

-- Perfiles para Ana (Usuario 6)
('Ana', 'Sin restricción', 6),

-- Perfiles para Diego (Usuario 7)
('Diego', 'Todo público', 7),
('Diego_4K', 'Sin restricción', 7),

-- Perfiles para María (Usuario 8)
('María', 'Sin restricción', 8),
('Maria_Movies', 'Todo público', 8),

-- Perfiles para Javier (Usuario 9)
('Javier', 'Sin restricción', 9),

-- Perfiles para Sofía (Usuario 10)
('Sofía', 'Todo público', 10),
('Sofia_Series', 'Sin restricción', 10),

-- Perfiles para Miguel (Usuario 11)
('Miguel', 'Sin restricción', 11),

-- Perfiles para Elena (Usuario 12)
('Elena', 'Todo público', 12),
('Elena_Family', 'Infantil', 12),

-- Perfiles para Pedro (Usuario 13)
('Pedro', 'Sin restricción', 13),

-- Perfiles para Carmen (Usuario 14)
('Carmen', 'Todo público', 14),
('Carmen_Movies', 'Sin restricción', 14),

-- Perfiles para Ricardo (Usuario 15)
('Ricardo', 'Sin restricción', 15),
('Rick_Docs', 'Todo público', 15);
