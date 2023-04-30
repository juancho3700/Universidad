SYSTEM clear;

call crearRecinto("Ciudad", "Nombre", "Calle", 2, null, 50);

CALL crearGrada(12131232, "Grada 2", 50000, 1);
CALL crearGrada(20001, "Grada 2", 100, 1);

CALL crearGrada(20001, "Grada 2", 25, 1);
SELECT * FROM Grada WHERE ID_grada = (SELECT max(ID_grada) FROM Grada);
SELECT * FROM Localidad WHERE ID_grada = (SELECT max(ID_grada) FROM Grada);

SELECT Localidad.ID_localidad, Grada.ID_grada, Entrada.ID_entrada FROM Entrada
    JOIN Localidad ON Localidad.ID_localidad = Entrada.ID_localidad
    JOIN Grada ON Grada.ID_grada = Localidad.ID_grada
    WHERE Grada.ID_grada = (SELECT max(ID_grada) FROM Grada);

CALL eliminarGrada(122131);
CALL eliminarGrada(301);
SELECT * FROM Grada WHERE ID_grada = 301;


CALL crearEvento(15000, 22000, "2022-07-07 12:00:00", "2022-07-07 14:00:00", "2022-07-01 12:00:00", "2022-07-01 12:00:00", "Abierto");
CALL crearEvento(20000, 1, "2022-07-07 12:00:00", "2022-07-07 14:00:00", "2022-07-01 12:00:00", "2022-07-01 12:00:00", "Abierto");
CALL crearEvento(1, 1, "2021-07-07 12:00:00", "2022-07-07 14:00:00", "2022-07-01 12:00:00", "2022-07-01 12:00:00", "Abierto");
CALL crearEvento(1, 1, "2022-07-07 12:00:00", "2022-07-06 14:00:00", "2022-07-01 12:00:00", "2022-07-01 12:00:00", "Abierto");
CALL crearEvento(1, 1, "2022-07-07 12:00:00", "2022-07-07 14:00:00", "2022-07-07 10:00:00", "2022-07-01 12:00:00", "Abierto");
CALL crearEvento(1, 1, "2022-07-07 12:00:00", "2022-07-07 14:00:00", "2022-07-01 12:00:00", "2022-06-30 12:00:00", "Abierto");
CALL crearEvento(1, 1, "2022-07-07 12:00:00", "2022-07-07 14:00:00", "2022-06-30 12:00:00", "2022-07-01 12:00:00", "Finalizado");
CALL crearEvento(2, 1, "2022-07-07 12:00:00", "2022-07-07 14:00:00", "2022-06-30 12:00:00", "2022-07-01 12:00:00", "Abierto");

SELECT * FROM RecintoEspectaculo WHERE ID_recinto = 1 AND ID_espectaculo = 2 AND FechaInicio = "2022-07-07 12:00:00";
SELECT * FROM Entrada WHERE ID_evento = (SELECT ID_evento FROM RecintoEspectaculo WHERE ID_recinto = 1 AND ID_espectaculo = 2 AND FechaInicio = "2022-07-07 12:00:00");
SELECT count(*) AS numLocalidadesDelRecinto FROM Localidad WHERE ID_recinto = 1;