set @llamadas_contar_directores = 0;
set @cadena = "Esta es una cadena de prueba";

system clear;
drop table if exists actores_peliculas;
drop table if exists actores;
drop table if exists peliculas;
drop table if exists directores;
drop table if exists cuentaDirectores;

drop procedure if exists listar_directores_peliculas;
drop procedure if exists contar_directores;
drop procedure if exists consulta_nacionalidad;
drop procedure if exists num_peliculas_nacionalidad;
drop procedure if exists poner_mayus;
drop procedure if exists contar_directores2;
drop procedure if exists extraer_imdbs;
drop procedure if exists nueva_pelicula;

create table directores (
    
    id int not NULL,
    nombre varchar (100) not NULL,
    edad int CHECK (edad > 0 and edad <= 120),
    nacionalidad varchar (100),
    primary key (id),
    unique (id)
);

create index IndiceDirectores ON directores (id);

create table peliculas
(
    id int,
    titulo varchar (100) not NULL,
    id_director int not NULL,
    nacionalidad varchar (100),
    primary key (id),
    unique (id, titulo),
    foreign key (id_director) references directores (id)
);

create table actores
(
    id int NOT NULL,
    nombre varchar (100) not NULL,
    edad int CHECK (edad > 0 and edad <= 120),
    nacionalidad varchar (100),
    primary key (id),
    unique (id)
);

create table actores_peliculas
(
    id_actor int not NULL,
    id_pelicula int not NULL,
    primary key (id_actor, id_pelicula),
    foreign key (id_pelicula) references peliculas (id),
    foreign key (id_actor) references actores (id)
);

insert into directores
    (nombre, id, edad, nacionalidad)
values
	('Ridley Scott', 631, 83, 'Inglaterra'),
    ('Marvel - Hermanos Russo', 939, 85, 'USA'),
    ('Christopher Nolan', 4240, 50, 'Inglaterra'),
    ('George Lucas', 184, 75, 'USA');

insert into actores
    (nombre, id, edad, nacionalidad)
values
	('Russell Crowe', 128, 56, 'Nueva Zelanda'),
    ('Robert Downey Jr', 375, 55, 'USA'),
    ('Tom Holland', 618, 24, 'Inglaterra'),
    ('Gwyneth Paltrow', 569, 48, 'USA'),
    ('Matthew McConaughey', 190, 52, 'USA'),
    ('Matt Damon', 354, 51, 'USA'),
    ('Mark Hamill', 434, 70, 'USA'),
    ('Carrie Fisher', 402, 60, 'USA'),
    ('Harrison Ford', 148, 79, 'USA'),
    ('Hayden Christensen', 789, 40, 'Canadá');

insert into peliculas
    (id, titulo, id_director, nacionalidad)
values
	(0172495, 'Gladiator', 631, 'Inglaterra'),
    (0371746, 'Iron Man', 939, 'USA'),
    (6320628, 'SpiderMan', 939, 'USA'),
    (4154796, 'Los vengadores: Endgame', 939, 'USA'),
    (816692,  'Interstellar', 4240, 'USA'),
    (76759,   'Star Wars: A new hope', 184, 'Canadá'),
    (3659388, 'The Martian', 631, 'USA');

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


/* EJERCICIO 1 */

delimiter $$
create procedure listar_directores_peliculas ()
begin
    select  peliculas.titulo, directores.nombre
    from    peliculas, directores
    where   directores.id = peliculas.id_director
    order by peliculas.titulo;
end $$
delimiter ;

call listar_directores_peliculas ();


/* EJERCICIO 2 y 3 */

delimiter $$
create procedure contar_directores ()
begin
    declare contador int;

    create table if not exists cuentaDirectores (
        id_tabla int not null AUTO_INCREMENT,
        instante timestamp,
        contaje int,
        primary key (id_tabla)
    );

    select  count(nombre)
    into    @contador
    from    directores;

    insert into cuentaDirectores (contaje, instante) values
        (@contador, CURRENT_TIMESTAMP());

    select
        *
    from
        cuentaDirectores;

    set @llamadas_contar_directores = @llamadas_contar_directores + 1;
end $$
delimiter ;

call contar_directores ();
select @llamadas_contar_directores;


/* EJERCICIO 4 */

delimiter $$
create procedure consulta_nacionalidad (in nacionIn varchar (100))
begin
    select *    from peliculas      where peliculas.nacionalidad = nacionIn;
    select *    from actores        where actores.nacionalidad = nacionIn;
    select *    from directores     where directores.nacionalidad = nacionIn;
end $$
delimiter ;

call consulta_nacionalidad ("Inglaterra");


/* EJERCICIO 5 */

delimiter $$
create procedure num_peliculas_nacionalidad (in nacionIn varchar (100), out numPeliculas int)
begin
    select  count(nacionalidad)
    into    numPeliculas
    from    peliculas
    where   nacionalidad = nacionIn;
end $$
delimiter ;

call num_peliculas_nacionalidad ("USA", @num_peliculas);
select @num_peliculas;


/* EJERCICIO 6 */

delimiter $$
create procedure poner_mayus (inout cadena varchar (100))
begin
    set cadena = ucase (@cadena);
end $$
delimiter ;

select @cadena;
call poner_mayus (@cadena);
select @cadena;


/* EJERCICIO 7 */

delimiter $$
create procedure contar_directores2 ()
begin
    declare contador int;
    declare nTuplas int;

    create table if not exists cuentaDirectores (
        id_tabla int not null AUTO_INCREMENT,
        instante timestamp,
        contaje int,
        primary key (id_tabla)
    );

    select  count(*)
    into    @contador
    from    cuentaDirectores;

    select  count(nombre)
    into    @contador
    from    directores;

    if @nTuplas = 10 then
        delete from cuentaDirectores
        order by cuentaDirectores.instante asc
        limit 1;
    end if;

    insert into cuentaDirectores (contaje, instante) values
        (@contador, CURRENT_TIMESTAMP());

    select  *
    from    cuentaDirectores;
end $$
delimiter ;

call contar_directores2 ();


/* EJERCICIO 8 */

delimiter $$
create procedure extraer_imdbs (in nacionIn varchar (100))
begin
    declare peliculaAux int;
    declare actorAux int;
    declare directorAux int;
    declare terminado boolean default false;

    declare cursor_peliculas cursor for
        select  id
        from    peliculas
        where   nacionalidad = nacionIn;

    declare cursor_actores cursor for 
        select  id
        from    actores
        where   nacionalidad = nacionIn;

    declare cursor_directores cursor for
        select  id
        from    directores
        where   nacionalidad = nacionIn;
    
    set @eliminar_tabla = concat("drop table if exists ", nacionIn, ";");
    set @crear_tabla = concat ("create table ", nacionIn, " (imdb int);");

    set peliculaAux = 0;
    set actorAux = 0;
    set directorAux = 0;

    prepare stmt_dropTable from @eliminar_tabla;
    execute stmt_dropTable;

    prepare stmt_createTable from @crear_tabla;
    execute stmt_createTable;

    open cursor_peliculas;
    begin
        declare terminado boolean default false;
        declare continue handler for not found set terminado = true;

        bucle_peliculas: loop
            fetch cursor_peliculas into peliculaAux;
            if terminado then
                leave bucle_peliculas;
            else
                set @meter_pelicula = concat("insert ", nacionIn, " values (", peliculaAux, ");");
                prepare stmt_addValuePeliculas from @meter_pelicula;
                execute stmt_addValuePeliculas;
            end if;
        end loop bucle_peliculas;
    end;
    close cursor_peliculas;

    open cursor_actores;
    begin
        declare terminado boolean default false;
        declare continue handler for not found set terminado = true;

        bucle_actores: loop
            fetch cursor_actores into actorAux;
            if terminado then
                leave bucle_actores;
            else
                set @meter_actor = concat("insert ", nacionIn, " values (", actorAux, ");");
                prepare stmt_addValueActores from @meter_actor;
                execute stmt_addValueActores;
            end if;
        end loop bucle_actores;
    end;
    close cursor_actores;

    open cursor_directores;
    begin
        declare terminado boolean default false;
        declare continue handler for not found set terminado = true;

        bucle_directores: loop
            fetch cursor_directores into directorAux;
            if terminado then
                leave bucle_directores;
            else
                set @meter_director = concat("insert ", nacionIn, " values (", directorAux, ");");
            end if;
        end loop bucle_directores;
    end;
    close cursor_directores;
end $$
delimiter ;

call extraer_imdbs ("USA");
select * from USA;


/* EJERCICIO 9 y 10 */

delimiter $$
create procedure nueva_pelicula (in idIn int, in tituloIn varchar (100), in id_directorIn int, in nacionIn varchar (100))
begin
    start transaction;
        insert peliculas values 
            (idIn, tituloIn, id_directorIn, nacionIn);
    commit;
end $$
delimiter ;

call nueva_pelicula (12345, "Inception", 4240, "USA");
select * from peliculas;


/* EJERCICIO 11 */

delimiter $$
drop trigger if exists trigger_borrar_directores $$
create trigger trigger_borrar_directores after delete on directores for each row
begin
    declare nacionAux varchar (100);
    declare idAux int;

    select  directores.nacionalidad
    into    nacionAux
    from    directores
    where   directores.id_director = old.nacionalidad;

    select  directores.id
    into    idAux
    from    directores
    where   directores.id = old.id;

    if (nacionAux = "USA") then
        delete from USA where USA.imdb = idAux;
    end if;
end $$
delimiter ; 

delimiter $$
drop trigger if exists trigger_meter_directores $$
create trigger trigger_meter_directores after insert on directores for each row
begin
    declare nacionAux varchar (100);
    declare idAux int;

    select  directores.nacionalidad
    into    nacionAux
    from    directores
    where   directores.nacionalidad = new.nacionalidad;

    select  directores.id
    into    idAux
    from    directores
    where   directores.is = new.id;

    if (nacionAux = "USA") then
        insert into USA (imdb) values
            (idAux);
    end if;
end $$
delimiter ;

