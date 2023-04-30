system clear;
drop table if exists actores_peliculas;
drop table if exists actores;
drop table if exists peliculas;
drop table if exists directores;

drop procedure if exists listar_directores_peliculas;
drop procedure if exists contar_directores;

create table directores
(
    id int not NULL,
    nombre varchar (100) not NULL,
    edad int CHECK (edad > 0 and edad <= 120),
    primary key (id),
    unique (id)
);

create index IndiceDirectores ON directores (id);

create table peliculas
(
    id int,
    titulo varchar (100) not NULL,
    id_director int not NULL,
    primary key (id),
    unique (id,titulo),
    foreign key (id_director) references directores (id)
);

create table actores
(
    id int NOT NULL,
    nombre varchar (100) not NULL,
    edad int CHECK (edad > 0 and edad <= 120),
    primary key (id),
    unique (id)
);

create table actores_peliculas
(
    id_actor int not NULL,
    id_pelicula int not NULL,
    primary key (id_actor,id_pelicula),
    foreign key (id_pelicula) references peliculas (id),
    foreign key (id_actor) references actores (id)
);

insert into directores
    (id,nombre,edad)
values
    (631, 'Ridley Scott', 83),
    (939, 'Hermanos Russo', 85),
    (4240, 'Christopher Nolan', 50),
    (184, 'George Lucas', 75);

insert into actores
    (id,nombre,edad)
values
    (128, 'Russell Crowe', 56),
    (375, 'Robert Downey Jr', 55),
    (618, 'Tom Holland', 24),
    (569, 'Gwyneth Paltrow', 48),
    (190, 'Matthew McConaughey', 52),
    (354, 'Matt Damon', 51),
    (434, 'Mark Hamill', 70),
    (402, 'Carrie Fisher', 60),
    (148, 'Harrison Ford', 79),
    (789, 'Hayden Christensen', 40);

insert into peliculas
    (id, titulo, id_director)
values
    (0172495, 'Gladiator', 631),
    (0371746, 'Iron Man', 939),
    (6320628, 'SpiderMan', 939),
    (4154796, 'Los vengadores: Endgame', 939),
    (816692, 'Interstellar', 4240),
    (76759, 'Star Wars: A new hope', 184),
    (3659388, 'The Martian', 631);

insert into actores_peliculas
    (id_actor, id_pelicula)
values
    (128, 0172495),
    (375, 0371746),
    (375, 4154796),
    (618, 6320628),
    (618, 4154796),
    (569, 0371746),
    (569, 4154796),
    (190, 816692),
    (354, 816692),
    (434, 76759),
    (402, 76759),
    (148, 76759),
    (354, 3659388);

/* 1 - LISTAR TODOS LOS ACTORES */

select
    *
from 
    actores;


/* 2 - TODOS LOS ACTORES DE STAR WARS */

select 
    actores.nombre
from
    actores, actores_peliculas, peliculas
where
    actores.id = actores_peliculas.id_actor and
    peliculas.id = actores_peliculas.id_pelicula and
    peliculas.titulo = 'Star Wars: A new hope';


/* 3 - ACTORES DE EDAD > 50 AÑOS */

select
    nombre
from
    actores
where
    edad > 50;


/* 4 - ATRIBUTOS DE TODAS LAS PELICULAS + NOMBRE DEL DIRECTOR */

select
    peliculas.id, peliculas.titulo, directores.nombre
from
    peliculas, directores
where
    directores.id = peliculas.id_director;


/* 5 - CUANTAS PELICULAS HA DIRIGIDO CADA DIRECTOR */

select
    directores.nombre, count(peliculas.titulo) as numero_peliculas
from
    directores, peliculas
where
    directores.id = peliculas.id_director
group by directores.nombre;


/* 6 - ACTORES QUE NO HAN ACTUADO EN NINGUNA PELICULA */

select
    nombre
from
    actores
where
    id not in (
        select
            id_actor
        from
            actores_peliculas
    );


/* 7 - TODOS LOS ACTORES QUE HAN DIRIGIDO A TOM HOLLAND */

select
    actores.nombre, directores.nombre
from
    actores, directores, peliculas, actores_peliculas
where
    actores.id = actores_peliculas.id_actor and
    peliculas.id = actores_peliculas.id_pelicula and
    directores.id = peliculas.id_director and
    actores.nombre = 'Matt Damon';