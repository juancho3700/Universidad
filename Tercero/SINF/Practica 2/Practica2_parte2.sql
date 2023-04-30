/* 1 - TODOS LOS DOCENTES */

select
    *
from
    docente;


/* 2 - TODOS LOS DOCENTES DE TELEMATICA */

select
    nombre
from
    docente
where
    nombre_dpto = 'Ingeniería Telemática';


/* 3 - TODOS LOS DOCENTES DE TELEMATICA CON SUELDO > 70 000€ */

select
    nombre
from
    docente
where
    nombre_dpto = 'Ingeniería Telemática' and
    salario > 70000;


/* 4 - ID, NOMBRE, SUELDO, DPTO, EDIFICIO DE DPTO Y PRESUPUESTO DE TODOS LOS DOCENTES */
select
    docente.ID, docente.nombre, docente.salario, docente.nombre_dpto, departamento.edificio, departamento.presupuesto
from
    docente, departamento
where
    docente.nombre_dpto = departamento.nombre_dpto;


/* 5 - MATERIAS DE TELEMATICA CON 3 CREDITOS */

select
    nombre
from
    materia
where
    nombre_dpto = 'Ingeniería Telemática' and
    creditos = 3;


/* 6 - MATERIAS CON SU ID QUE CURSA EL ALUMNO CON ID 12345 */

select
    materia.nombre, materia.id_materia
from
    materia, alumno_3ciclo, cursa
where
    materia.id_materia = cursa.id_materia and
    cursa.ID = alumno_3ciclo.ID and
    alumno_3ciclo.ID = 12345;


/* 7 - NOMBRE DE TODOS LOS DOCENTES Y ALUMNOS ALFABETICAMENTE */

select
    nombre
from
    docente
union all
    select
        nombre
    from
        alumno_3ciclo;


/* 8 - COMO LA ANTERIOR PERO CON LOS CREDITOS CURSADOS POR EL ALUMNO */

select
    nombre, NULL as tot_creditos
from
    docente
union all
    select
        alumno_3ciclo.nombre, sum(materia.creditos)
    from
        alumno_3ciclo, cursa, materia
    where
        alumno_3ciclo.ID = cursa.ID and
        cursa.id_materia = materia.id_materia
    group by cursa.ID;


/* 9 - COMO LA ANTERIOR PERO CON LOS TOTALES Y SU ID EN VEZ DE EL NOMBRE */

select
    ID, NULL as creditos
from
    docente
union all
    select
        ID, tot_creditos
    from
        alumno_3ciclo;


/* 10 - TODOS LOS ALUMNOS QUE HAYAN CURSADO UNA ASIGNATURA DE TELEMATICA */

select distinct
    alumno_3ciclo.nombre
from
    alumno_3ciclo, materia, cursa
where
    alumno_3ciclo.ID = cursa.ID and
    materia.id_materia = cursa.id_materia;


/* 11 - ID DE LOS DOCENTES QUE NO HAYAN IMPARTIDO UNA MATERIA NUNCA */

select 
    ID
from
    docente
where 
    ID not in (
        select
            ID
        from
            imparte
    );


/* 12 - COMO LA ANTERIOR PERO CON LOS NOMBRES EN VEZ DE LAS IDS */

select 
    nombre
from
    docente
where 
    ID not in (
        select
            ID
        from
            imparte
    );


/* 13 - GRUPOS COM MAYOR Y MENOR NUMERO DE ALUMNOS MATRICULADOS */

select
    id_materia, id_grupo, count(*) as contaje
from
    cursa
group by id_materia, id_grupo
order by contaje asc
limit 1;


select
    id_materia, id_grupo, count (*) as contaje
from 
    cursa
order by contaje desc 
limit 1;


/* 14 - GRUPOS CON EL MAXIMO NUMERO DE ALUMNOS */

select
    s1.id_materia, s1.id_grupo, s1.cuenta AS maximo
from (
    select
        cursa.id_materia, cursa.id_grupo, count(*) as cuenta
    from
        cursa
    group by cursa.id_materia, cursa.id_grupo
    order by cursa.id_materia
) s1
inner join (
    select
        id_materia, max(cuenta) as mxm
    from (
        select
            cursa.id_materia, cursa.id_grupo, count(*) as cuenta
            from
                cursa
        group by cursa.id_materia, cursa.id_grupo
        order by cursa.id_materia
    ) as contarAlumnos
    group by id_materia
) s2 on s2.id_materia = s1.id_materia and s2.mxm = s1.cuenta
order by maximo;


/* 15 - IGUAL PERO ORDENANDO DE MAYOR A MENOR */

select
    s1.id_materia, s1.id_grupo, s1.cuenta AS maximo
from (
    select
        cursa.id_materia, cursa.id_grupo, count(*) as cuenta
    from
        cursa
    group by cursa.id_materia, cursa.id_grupo
    order by cursa.id_materia
) s1
inner join (
    select
        id_materia, max(cuenta) as mxm
    from (
        select
            cursa.id_materia, cursa.id_grupo, count(*) as cuenta
            from
                cursa
        group by cursa.id_materia, cursa.id_grupo
        order by cursa.id_materia
    ) as contarAlumnos
    group by id_materia
) s2 on s2.id_materia = s1.id_materia and s2.mxm = s1.cuenta
order by maximo desc;


/* 16 - LOS 10 GRUPOS CON MAS ALUMNOS */

select
    grupo.id_materia, grupo.id_grupo, count(cursa.ID) as numero_alumnos
from
    cursa, grupo
where
    cursa.id_materia = grupo.id_materia and
    cursa.id_grupo = grupo.id_grupo and
    cursa.cuatrimestre = grupo.cuatrimestre and
    cursa.anho = grupo.anho
group by cursa.id_materia, cursa.id_grupo, cursa.cuatrimestre, cursa.anho
order by numero_alumnos
limit 10;