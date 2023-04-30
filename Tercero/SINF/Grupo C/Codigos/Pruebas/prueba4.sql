system clear;

CALL crearEvento(5, 1, "2022-07-07 12:00:00", "2022-07-07 14:00:00", "2022-06-30 12:00:00", "2022-07-01 12:00:00", "Abierto");

CALL reservarEntrada(35000, 15, "123456789", "Infantil");
CALL reservarEntrada(1, 15000, "123456789", "Infantil");
CALL reservarEntrada(1, 55, "12345678A", "Adulto");
CALL reservarEntrada(1, 55, "387204379", "Adulto");

SELECT * FROM Entrada WHERE ID_cliente = "387204379";
SELECT max(ID_entrada) INTO @maxEntrada FROM Entrada WHERE ID_cliente = "387204379";

CALL reservarEntrada(1, 55, "530276746", "Adulto");



CALL comprarEntrada(35000, 15, "123456789", "Efectivo", NULL, "Infantil");
CALL comprarEntrada(1, 15000, "123456789", "Tarjeta", "123456789", "Infantil");
CALL comprarEntrada(1, 55, "12345678A", "Efectivo", NULL, "Adulto");
CALL comprarEntrada(1, 55, "518377099", "Efectivo", NULL, "Adulto");
CALL comprarEntrada(1, 56, "518377099", "Efectivo", NULL, "Jubilado");

SELECT * FROM Entrada WHERE ID_cliente = "518377099";



CALL anularEntrada(15000, "530276746");
CALL anularEntrada(@maxEntrada, "530276746");
CALL anularEntrada(@maxEntrada, "387204379");

SELECT * FROM Entrada WHERE ID_entrada = @maxEntrada;
SELECT * FROM EntradaAnulada WHERE ID_entrada = @maxEntrada;



CALL reservarEntrada(1, 55, "387204379", "Adulto");
CALL comprarEntrada(1, 55, "387204379", "Efectivo", NULL, "Adulto");

SELECT * FROM Entrada WHERE ID_entrada = @maxEntrada;