system clear;

drop user if exists 'accesoVistas'@'localhost';

drop table if exists actor_pelicula;
drop table if exists actor;
drop table if exists pelicula;
drop table if exists director;

drop view if exists ver_tituloYnacion_pelicula;
drop view if exists ver_tituloYnacionYdirectorYactores_pelicula;
drop view if exists ver_pelicula_sXX;

create table director (
    
    id int not NULL auto_increment,
    nombre varchar (100) not NULL,
    edad int CHECK (edad > 0 and edad <= 120),
    nacionalidad varchar (100) default "Estados Unidos",
    sello_temporal datetime default now(),
    primary key (id),
    unique (id)
);

create index indiceDirector on director (id);

create table actor (

    id int NOT NULL auto_increment,
    nombre varchar (100) not NULL,
    edad int CHECK (edad > 0 and edad <= 120),
    nacionalidad varchar (100) default "Estados Unidos",
    sello_temporal datetime default now(),
    primary key (id),
    unique (id)
);

create table pelicula (

    id int not NULL auto_increment,
    titulo varchar (100) not NULL,
    anho int not NULL,
    id_director int not NULL,
    nacionalidad varchar (100) default "Estados Unidos",
    cartel BLOB,
    valoracion float CHECK (valoracion >= 0 and valoracion <= 10),
    sello_temporal datetime default now(),
    primary key (id),
    unique (id, titulo),
    foreign key (id_director) references director (id)
);

create table actor_pelicula (

    id_actor int not NULL,
    id_pelicula int not NULL,
    sello_temporal datetime default now(),
    primary key (id_actor, id_pelicula),
    foreign key (id_pelicula) references pelicula (id),
    foreign key (id_actor) references actor (id)
);



insert into director
    (nombre, edad, nacionalidad)
values
    ('Ridley Scott', 83, 'Inglaterra'),
    ('Christopher Nolan', 50, 'Inglaterra');

insert into director
    (nombre, edad)
values
    ('Marvel - Hermanos Russo', 85),
    ('George Lucas', 75),
    ('Steven Spielberg', 75);


insert into actor
    (nombre, edad, nacionalidad)
values
    ('Russell Crowe', 56, 'Nueva Zelanda'),
    ('Tom Holland', 24, 'Inglaterra'),
    ('Hayden Christensen', 40, 'Canadá');

insert into actor
    (nombre, edad)
values
    ('Robert Downey Jr', 55),
    ('Gwyneth Paltrow', 48),
    ('Matthew McConaughey', 52),
    ('Matt Damon', 51),
    ('Mark Hamill', 70),
    ('Carrie Fisher', 60),
    ('Harrison Ford', 79);


insert into pelicula
    (titulo, anho, id_director, nacionalidad, valoracion)
values
    ('Gladiator', 2000, 1, 'Inglaterra', 5.01),
    ('Star Wars: A new hope', 1977, 4, 'Canadá', 8.95);

insert into pelicula
    (titulo, anho, id_director, valoracion)
values
    ('Iron Man', 2008, 3, 1.04),
    ('Los vengadores: Endgame', 2019, 3, 3.27),
    ('SpiderMan', 2002, 3, 6.00),
    ('Interstellar', 2014, 2, 4.97),
    ('The Martian', 2015, 1, 7.62);


insert into actor_pelicula
    (id_actor, id_pelicula)
values
    (1, 1),
    (4, 3),
    (4, 4),
    (2, 5),
    (2, 4),
    (5, 3),
    (5, 4),
    (6, 6),
    (7, 6),
    (8, 2),
    (9, 2),
    (10, 2),
    (7, 7);



/* EJERCICIO 1 */

update pelicula
    set cartel = load_file ('/var/lib/mysql-files/Interstellar.jpg')
    where id = 6;


/* EJERCICIO 5 */

delete from director
    where nombre = 'Steven Spielberg';

insert into director
    (nombre, edad)
values
    ('Steven Spielberg', 75);

select * from director; /* Si borras uno y metes otro no usa el número que dejó libre */


insert into director
    (nombre, edad, id)
values
    ('Quentin Tarantino', 58, 35);

insert into director
    (nombre, edad, nacionalidad)
values
    ('Pedro Almodóvar', 72, 'España');

select * from director; /* Si metes tu la id se queda con esa y sigue con las IDs a partir de esa */


/* EJERCICIO 6 */

create view ver_tituloYnacion_pelicula as
    select  titulo, nacionalidad
    from    pelicula;

select * from ver_tituloYnacion_pelicula;


/* EJERCICIO 7 */

create view ver_tituloYnacionYdirectorYactores_pelicula as
    select distinct pelicula.titulo, pelicula.nacionalidad, director.nombre as nombre_director, actor.nombre as nombre_actor
    from            pelicula, actor, director, actor_pelicula

    where           pelicula.id_director = director.id and
                    pelicula.id = actor_pelicula.id_pelicula and
                    actor.id = actor_pelicula.id_actor;

select * from ver_tituloYnacionYdirectorYactores_pelicula;


/* EJERCICIO 8 */

create view ver_pelicula_sXX as
    select  *
    from    pelicula
    where   anho >= 1900 and
            anho < 2000;

select * from ver_pelicula_sXX;


/* EJERCICIO 9 */


/* EJERCICIO 10 */


/* EJERCICIO 11 */

create user 'accesoVistas'@'localhost' identified by 'Sinf1243.';

grant all privileges on practicas.ver_pelicula_sXX to 'accesoVistas'@'localhost';
grant all privileges on practicas.ver_tituloYnacion_pelicula to 'accesoVistas'@'localhost';
grant all privileges on practicas.ver_tituloYnacionYdirectorYactores_pelicula to 'accesoVistas'@'localhost';

flush privileges;
show grants for 'accesoVistas'@'localhost';


/*  */