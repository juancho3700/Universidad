system clear;

CALL reservarEntrada(1, 60, "387204379", "Adulto");
CALL comprarEntrada(2, 60, "387204379", "Tarjeta", "123456789", "Adulto");
select * from Entrada where ID_cliente = "387204379" AND ID_localidad = 60;

CALL cambiarEstadoLocalidad(60);
select * from Entrada where ID_localidad = 60;

select max(ID_entrada) into @maxEntrada from EntradaAnulada;
select * from EntradaAnulada where ID_cliente = "387204379" and (ID_evento = 1 OR ID_evento = 2);
select * from Entrada where ID_localidad = 60;
select * from Localidad where ID_localidad = 60;

CALL cambiarEstadoLocalidad(60);
select * from Entrada where ID_localidad = 60;
select * from Localidad where ID_localidad = 60;