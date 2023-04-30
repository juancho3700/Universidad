SYSTEM clear;

INSERT INTO Recinto (Nombre, Ciudad, Calle, Numero, Sala, Aforo) VALUES
    ("Estadio Santiago Bernabéu", "Madrid", "Avenida de Concha", 1, NULL, 0);

INSERT INTO Recinto (Nombre, Ciudad, Calle, Numero, Sala, Aforo) VALUES
    ("Estadio Balaidos", "Vigo", "Avenida de Balaidos", 0, NULL, 10);

INSERT INTO Recinto (Nombre, Ciudad, Calle, Numero, Sala, Aforo) VALUES
    ("Estadio Camp Nou", NULL, "Calle d'Artistes Maillol", 12, NULL, 99354);

INSERT INTO Recinto (ID_recinto, Nombre, Ciudad, Calle, Numero, Sala, Aforo) VALUES
    (103, "Estadio Camp Nou", "Barcelona", "Calle d'Artistes Maillol", 12, NULL, 99354);

INSERT INTO Espectaculo (Nombre, Tipo, Productor, PrecioBase) VALUES
    ("El rey león", "Película", "Rob Minkoff", -10);

INSERT INTO Espectaculo (Nombre, Tipo, Productor, PrecioBase) VALUES
    (NULL, "Pelicula", "Hayao Miyazaki", 10);


INSERT INTO RecintoEspectaculo (ID_espectaculo, ID_recinto, FechaInicio, FechaFin, FechaReserva, FechaAnulacion, Estado) VALUES
    (501, 101, "2022-08-11 14:00:00", "2022-08-11 16:00:00", "2022-08-9 14:00:00", "2022-08-10 14:00:00", "En espera");


INSERT INTO Grada(ID_recinto, Nombre, FactorAumentoPrecio, Capacidad) VALUES
    (10, "Grada 1", 0.5, 10);

INSERT INTO Grada(ID_recinto, Nombre, FactorAumentoPrecio, Capacidad) VALUES
    (10, "Grada 1", 1, 0);

