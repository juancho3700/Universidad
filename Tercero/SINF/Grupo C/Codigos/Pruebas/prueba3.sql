system clear;

CALL eliminarGrada(15000);

CALL crearGrada (1, "Grada 5", 15, 1.5);
SELECT Entrada.ID_evento, count(Entrada.ID_entrada) AS numEntradas FROM Entrada
    JOIN Localidad ON Localidad.ID_localidad = Entrada.ID_localidad
    JOIN Grada ON Grada.ID_grada = Localidad.ID_grada
    WHERE Grada.ID_grada = (SELECT max(ID_grada) FROM Grada)
    GROUP BY Entrada.ID_evento;

SELECT max(ID_grada) INTO @maxGrada FROM Grada;

CALL eliminarGrada (15000);
CALL eliminarGrada (@maxGrada);
SELECT Entrada.ID_evento, count(Entrada.ID_entrada) AS numEntradas FROM Entrada
    JOIN Localidad ON Localidad.ID_localidad = Entrada.ID_localidad
    JOIN Grada ON Grada.ID_grada = Localidad.ID_grada
    WHERE Localidad.ID_grada = @maxGrada
    GROUP BY Entrada.ID_evento;

SELECT * FROM Localidad WHERE ID_grada = @maxGrada;


CALL crearEvento(3, 1, "2022-07-07 12:00:00", "2022-07-07 14:00:00", "2022-06-30 12:00:00", "2022-07-01 12:00:00", "Abierto");

SELECT max(ID_evento) INTO @maxEvento FROM RecintoEspectaculo;
SELECT ID_evento, count(*) FROM Entrada WHERE ID_evento = @maxEvento GROUP BY ID_evento;

CALL cancelarEvento(@maxEvento);
SELECT ID_evento, count(*) FROM Entrada WHERE ID_evento = @maxEvento GROUP BY ID_evento;