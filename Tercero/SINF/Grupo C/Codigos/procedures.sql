DELIMITER //


DROP PROCEDURE IF EXISTS crearRecinto //

CREATE PROCEDURE crearRecinto(

    IN CiudadIN VARCHAR(50),
    IN NombreIN VARCHAR(50),
    IN CalleIN VARCHAR(50),
    IN NumeroIN INT,
    IN SalaIN INT,
    IN AforoIN INT
)

BEGIN
    INSERT INTO Recinto (Ciudad, Nombre, Calle, Numero, Sala, Aforo) VALUE (CiudadIN, NombreIN, CalleIN, NumeroIN, SalaIN, AforoIN);
END //



DROP PROCEDURE IF EXISTS crearEspectaculo //

CREATE PROCEDURE crearEspectaculo(

    IN NombreIN VARCHAR(50),
    IN FechaProduccionIN DATETIME,
    IN TipoIN VARCHAR(15),
    IN ProductorIN VARCHAR(30),
    IN PrecioBaseIN INT
)

BEGIN
    INSERT INTO Espectaculo (Nombre, FechaProduccion, Tipo, Productor, PrecioBase) VALUE (NombreIN, FechaProduccionIN, TipoIN, ProductorIN, PrecioBaseIN);
END //



DROP PROCEDURE IF EXISTS crearGrada //

CREATE PROCEDURE crearGrada(

    IN ID_recintoIN INT,
    IN NombreIN VARCHAR(100),
    IN CapacidadIN INT,
    IN FactorAumentoPrecioIN FLOAT
)

BEGIN

    DECLARE idGrada INT;
    DECLARE capacidadAux INT;
    DECLARE numEvento INT;
    DECLARE ID_localidadAux INT;

    DECLARE cursorEventos CURSOR FOR SELECT ID_evento FROM RecintoEspectaculo WHERE (ID_recinto = ID_recintoIN AND FechaInicio > NOW());
    
   
    SET idGrada = 0;
    SET capacidadAux = 0;

    IF((SELECT EXISTS(SELECT * FROM Recinto WHERE ID_recinto = ID_recintoIN)) = '') THEN
        CALL error(1234,"No existe el recinto");
    END IF;

    IF(CapacidadIN > (SELECT Aforo FROM Recinto WHERE ID_recinto = ID_recintoIN)) THEN
        CALL error(1234, "Excedida la capacidad del recinto");
    END IF;    

    IF(((SELECT SUM(Capacidad) FROM Grada WHERE ID_recinto = ID_recintoIN) + CapacidadIN) > (SELECT Aforo FROM Recinto WHERE ID_recinto = ID_recintoIN)) THEN
        CALL error(1234, "Excedida la capacidad del recinto");
    END IF;

    INSERT INTO Grada(ID_recinto, Nombre, FactorAumentoPrecio, Capacidad) VALUES
        (ID_recintoIN, NombreIN, FactorAumentoPrecioIN, CapacidadIN);

    SELECT ID_grada INTO idGrada FROM Grada WHERE ID_grada=(SELECT max(ID_grada) FROM Grada);

    bucleCrearLocalidades : LOOP
        IF capacidadAux = CapacidadIN THEN 
            LEAVE bucleCrearLocalidades;

        ELSE

            INSERT INTO Localidad(ID_recinto, ID_grada, Numero) VALUES (ID_recintoIN, idGrada, capacidadAux);
            SET capacidadAux = capacidadAux + 1;

        END IF;
    END LOOP;
    OPEN cursorEventos;
    BEGIN
        DECLARE finEventos BOOLEAN DEFAULT false;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET finEventos = TRUE;
        

        bucleEventos: LOOP

            FETCH cursorEventos INTO numEvento;

            IF finEventos THEN
                LEAVE bucleEventos;
            ELSE
                SET capacidadAux = 0;
                bucleEventos2 : LOOP
                    IF capacidadAux = CapacidadIN THEN
                        LEAVE bucleEventos2;
                    ELSE
                        SELECT ID_localidad INTO ID_localidadAux FROM Localidad WHERE ID_recinto = ID_recintoIN AND Numero = capacidadAux AND ID_grada = (SELECT max(ID_grada) FROM Grada);
                        INSERT INTO Entrada (ID_evento, ID_localidad) VALUES (numEvento, ID_localidadAux);
                        SET capacidadAux = capacidadAux + 1;

                    END IF;
                END LOOP;
            END IF;
        END LOOP;
    END;
    CLOSE cursorEventos;
END //


DROP PROCEDURE IF EXISTS eliminarGrada //

CREATE PROCEDURE eliminarGrada(

    IN ID_gradaIN INT
)

BEGIN

    IF((SELECT EXISTS(SELECT * FROM Grada WHERE ID_grada = ID_gradaIN)) = '') THEN
        CALL error(1234,"No existe la grada");
    END IF;

    INSERT INTO EntradaAnulada (ID_evento, ID_cliente, PrecioFinal) SELECT Entrada.ID_evento, Entrada.ID_cliente, Entrada.PrecioFinal FROM Entrada, Localidad WHERE Entrada.ID_localidad = Localidad.ID_localidad AND Localidad.ID_grada = ID_gradaIN AND Entrada.Estado = "Reservada";
    INSERT INTO EntradaAnulada (ID_evento, ID_cliente, PrecioFinal, Comprada) SELECT Entrada.ID_evento, Entrada.ID_cliente, Entrada.PrecioFinal, TRUE FROM Entrada, Localidad WHERE Entrada.ID_localidad = Localidad.ID_localidad AND Localidad.ID_grada = ID_gradaIN AND Entrada.Estado = "Comprada";

    DELETE Entrada FROM Entrada
    INNER JOIN Localidad ON Localidad.ID_localidad = Entrada.ID_localidad
    WHERE Localidad.ID_grada = ID_gradaIN;

    DELETE FROM Localidad WHERE ID_grada = ID_gradaIN;
    DELETE FROM Grada where ID_grada = ID_gradaIN;

END //


DROP PROCEDURE IF EXISTS crearEvento //

CREATE PROCEDURE crearEvento(

    IN ID_espectaculoIN INT, 
    IN ID_recintoIN INT,
    IN FechaInicioIN DATETIME,
    IN FechaFinIN DATETIME,
    IN FechaReservaIN DATETIME,
    IN FechaAnulacionIN DATETIME,
    IN EstadoIN VARCHAR(50)

)

BEGIN

    DECLARE numEventoNuevo INT;
    DECLARE numLocalidades INT;
    DECLARE cursorLocalidades CURSOR FOR SELECT Localidad.ID_localidad FROM Localidad WHERE Localidad.ID_recinto = ID_recintoIN;
    SET numLocalidades = 0;

    IF((SELECT EXISTS(SELECT * FROM Espectaculo WHERE ID_espectaculo = ID_espectaculoIN)) = '') THEN
        CALL error(1234,"No existe el espectaculo");
    END IF;

    IF((SELECT EXISTS(SELECT * FROM Recinto WHERE ID_recinto = ID_recintoIN)) = '') THEN
        CALL error(1234,"No existe el recinto");
    END IF;



    IF((FechaInicioIN > FechaFinIN) OR (FechaInicioIN = FechaFinIN) OR (FechaInicioIN <= NOW()) OR (FechaAnulacionIN > DATE_SUB(FechaInicioIN,INTERVAL 8 HOUR)) OR (FechaAnulacionIN < FechaReservaIN)) THEN
        CALL error(1234,"Fechas incorrectas");
    END IF;

    IF((EstadoIN = "Finalizado")) THEN
        CALL error(1234,"Estado Incorrecto");
    END IF;

    INSERT INTO RecintoEspectaculo (ID_espectaculo, ID_recinto, FechaInicio, FechaFin, FechaReserva, FechaAnulacion, Estado) VALUES
        (ID_espectaculoIN, ID_recintoIN, FechaInicioIN, FechaFinIN, FechaReservaIN, FechaAnulacionIN, EstadoIN);

    SELECT ID_evento INTO numEventoNuevo FROM RecintoEspectaculo WHERE ID_espectaculo = ID_espectaculoIN AND ID_recinto = ID_recintoIN AND FechaInicio = FechaInicioIN; 

    OPEN cursorLocalidades;
    BEGIN

        DECLARE finLocalidades BOOLEAN DEFAULT false;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET finLocalidades = TRUE;

        bucleLocalidades : LOOP

            FETCH cursorLocalidades INTO numLocalidades;
            IF finLocalidades THEN 
                LEAVE bucleLocalidades;
            
            ELSE
                IF((SELECT Estado FROM Localidad WHERE ID_localidad = numLocalidades ) = "Disponible") THEN
                    INSERT INTO Entrada(ID_evento, ID_localidad) VALUES (numEventoNuevo, numLocalidades);
                END IF;
            END IF;
        END LOOP;
    END;
    CLOSE cursorLocalidades;

END // 




DROP PROCEDURE IF EXISTS cambiarEstadoLocalidad //

CREATE PROCEDURE cambiarEstadoLocalidad(

    IN ID_localidadIN INT
)

BEGIN

    IF (SELECT Estado FROM Localidad WHERE ID_localidad = ID_localidadIN) = "Disponible" THEN
        UPDATE Localidad SET Estado = "No Disponible" WHERE ID_localidad = ID_localidadIN;
    ELSEIF (SELECT Estado FROM Localidad WHERE ID_localidad = ID_localidadIN) = "No Disponible" THEN
        UPDATE Localidad SET Estado = "Disponible" WHERE ID_localidad = ID_localidadIN;
    ELSE
        CALL error (1234, "La localidad seleccionada no existe");
    END IF;

END //


DROP PROCEDURE IF EXISTS cancelarEvento //

CREATE PROCEDURE cancelarEvento (

    IN ID_eventoIN INT
)

BEGIN

    INSERT INTO EntradaAnulada (ID_evento, ID_cliente, PrecioFinal) SELECT ID_evento, ID_cliente, PrecioFinal FROM Entrada WHERE ID_evento = ID_eventoIN AND (Estado = "Reservada");
    INSERT INTO EntradaAnulada (ID_evento, ID_cliente, PrecioFinal, Comprada) SELECT ID_evento, ID_cliente, PrecioFinal, TRUE FROM Entrada WHERE ID_evento = ID_eventoIN AND (Estado = "Comprada");
    DELETE FROM Entrada WHERE ID_evento = ID_eventoIN;

END //



DROP VIEW IF EXISTS VistaRecintos //

CREATE VIEW VistaRecintos AS SELECT Recinto.Nombre AS Recinto, RecintoEspectaculo.ID_evento, Espectaculo.Nombre AS Espectaculo, RecintoEspectaculo.FechaInicio, RecintoEspectaculo.FechaFin, RecintoEspectaculo.Estado, COUNT(IF(Entrada.Estado = "Comprada", Entrada.Estado, NULL)) AS Entradas_compradas FROM RecintoEspectaculo 
    JOIN Recinto ON RecintoEspectaculo.ID_recinto = Recinto.ID_recinto
    JOIN Espectaculo ON RecintoEspectaculo.ID_espectaculo = Espectaculo.ID_espectaculo
    JOIN Entrada ON RecintoEspectaculo.ID_evento = Entrada.ID_evento
    GROUP BY RecintoEspectaculo.ID_evento
    ORDER BY RecintoEspectaculo.FechaInicio, Recinto.Nombre;




DROP PROCEDURE IF EXISTS reservarEntrada //


CREATE PROCEDURE reservarEntrada(

    IN ID_eventoIN INT,
    IN ID_localidadIN INT,
    IN ID_clienteIN VARCHAR(9),
    IN TipoUsuarioIN VARCHAR(20)
)

BEGIN   

    DECLARE ID_espectaculoIN INT;
    DECLARE ID_gradaIN INT;
    DECLARE Precio FLOAT;

    IF((SELECT EXISTS(SELECT * FROM RecintoEspectaculo WHERE ID_evento = ID_eventoIN)) = '') THEN
        CALL error(1234,"No existe el evento");
    END IF;

    IF((SELECT EXISTS(SELECT * FROM RecintoEspectaculo JOIN Localidad ON RecintoEspectaculo.ID_recinto = Localidad.ID_recinto WHERE Localidad.ID_localidad = ID_localidadIN AND RecintoEspectaculo.ID_evento = ID_eventoIN)) = '') THEN
        CALL error(1234,"No existe la localidad");
    END IF;

    IF((SELECT EXISTS(SELECT * FROM Cliente WHERE ID_cliente = ID_clienteIN)) = '') THEN
        CALL error(1234,"No existe el cliente");
    END IF;

    IF((SELECT FechaReserva FROM RecintoEspectaculo WHERE ID_evento = ID_eventoIN) < NOW()) THEN
        CALL error(1234,"No puedes reservar, periodo de reserva CERRADO");
    END IF;


    IF((SELECT Estado FROM Entrada WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN) = "Disponible") THEN
        
        SELECT ID_espectaculo INTO ID_espectaculoIN FROM RecintoEspectaculo WHERE ID_evento = ID_eventoIN;
        SELECT ID_grada INTO ID_gradaIN FROM Localidad WHERE ID_localidad = ID_localidadIN;
        CALL calcularPrecio (ID_espectaculoIN, ID_gradaIN, TipoUsuarioIN, Precio);
        
        UPDATE Entrada SET PrecioFinal = Precio WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN;
        UPDATE Entrada SET Estado = "Reservada" WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN;
        UPDATE Entrada SET ID_cliente = ID_clienteIN WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN;

    ELSE

        CALL error(1234, "Entrada no disponible");

    END IF;

END //


DROP PROCEDURE IF EXISTS comprarEntrada //

CREATE PROCEDURE comprarEntrada(

    IN ID_eventoIN INT,
    IN ID_localidadIN INT,
    IN ID_clienteIN VARCHAR(9),
    IN Metodo_pagoIN VARCHAR(50),
    IN Numero_cuentaIN VARCHAR(30),
    IN TipoUsuarioIN VARCHAR(20)
)

BEGIN

    DECLARE ID_espectaculoIN INT;
    DECLARE ID_gradaIN INT;
    DECLARE Precio FLOAT;

    SET ID_espectaculoIN = 0;
    SET ID_gradaIN = 0;
    SET Precio = 0;

    IF((SELECT EXISTS(SELECT * FROM RecintoEspectaculo WHERE ID_evento = ID_eventoIN)) = '') THEN
        CALL error(1234,"No existe el evento");
    END IF;

    IF((SELECT EXISTS(SELECT * FROM RecintoEspectaculo JOIN Localidad ON RecintoEspectaculo.ID_recinto = Localidad.ID_recinto WHERE Localidad.ID_localidad = ID_localidadIN AND RecintoEspectaculo.ID_evento = ID_eventoIN)) = '') THEN
        CALL error(1234,"No existe la localidad");
    END IF;

    IF((SELECT EXISTS(SELECT * FROM Cliente WHERE ID_cliente = ID_clienteIN)) = '') THEN
        CALL error(1234,"No existe el cliente");
    END IF;


    IF((SELECT Estado FROM Entrada WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN) = "Disponible") THEN

        SELECT ID_espectaculo INTO ID_espectaculoIN FROM RecintoEspectaculo WHERE ID_evento = ID_eventoIN;
        SELECT ID_grada INTO ID_gradaIN FROM Localidad WHERE ID_localidad = ID_localidadIN;
        CALL calcularPrecio (ID_espectaculoIN, ID_gradaIN, TipoUsuarioIN, Precio);
        
        UPDATE Entrada SET PrecioFinal = Precio WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN;
        UPDATE Entrada SET Estado = "Comprada" WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN;
        UPDATE Entrada SET ID_cliente = ID_clienteIN WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN;
        UPDATE Cliente SET Metodo_pago = Metodo_pagoIN WHERE ID_cliente = ID_clienteIN;
        UPDATE Cliente SET Numero_cuenta = Numero_cuentaIN WHERE ID_cliente = ID_clienteIN;

    ELSE
        IF((SELECT Estado FROM Entrada WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN) = "Reservada" AND 
            (SELECT ID_cliente FROM Entrada WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN) = ID_clienteIN) THEN
        
            SELECT ID_espectaculo INTO ID_espectaculoIN FROM RecintoEspectaculo WHERE ID_evento = ID_eventoIN;
            SELECT ID_grada INTO ID_gradaIN FROM Localidad WHERE ID_localidad = ID_localidadIN;
            CALL calcularPrecio (ID_espectaculoIN, ID_gradaIN, TipoUsuarioIN, Precio);
        
            UPDATE Entrada SET PrecioFinal = Precio WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN;
            UPDATE Entrada SET Estado = "Comprada" WHERE ID_evento = ID_eventoIN AND ID_localidad = ID_localidadIN;
            UPDATE Cliente SET Metodo_pago = Metodo_pagoIN WHERE ID_cliente = ID_clienteIN;
            UPDATE Cliente SET Numero_cuenta = Numero_cuentaIN WHERE ID_cliente = ID_clienteIN;
    
        ELSE
            CALL error(1234, "Entrada no disponible");

        END IF;
    END IF;
END //


DROP PROCEDURE IF EXISTS anularEntrada //

CREATE PROCEDURE anularEntrada(

    IN ID_entradaIN INT,
    IN ID_clienteIN VARCHAR(9)
    
)

BEGIN 

    IF((SELECT EXISTS(SELECT * FROM Entrada WHERE ID_entrada = ID_entradaIN)) = '') THEN
        CALL error(1234,"No existe la entrada");
    END IF;

    IF((SELECT EXISTS(SELECT * FROM Cliente WHERE ID_cliente = ID_clienteIN)) = '') THEN
        CALL error(1234,"No existe el cliente");
    END IF;

    IF((SELECT FechaAnulacion FROM RecintoEspectaculo WHERE ID_evento = (SELECT ID_evento FROM Entrada WHERE ID_entrada = ID_entradaIN)) < NOW()) THEN
        CALL error(1234,"No puedes anular, periodo de anulacion CERRADO");
    END IF;


    IF((SELECT Estado FROM Entrada WHERE ID_entrada = ID_entradaIN) = "Reservada" AND 
        (SELECT ID_cliente FROM Entrada WHERE ID_entrada = ID_entradaIN) = ID_clienteIN) THEN

        INSERT INTO EntradaAnulada (ID_evento, ID_cliente, PrecioFinal) SELECT ID_evento, ID_cliente, PrecioFinal FROM Entrada WHERE ID_entrada = ID_entradaIN;

        UPDATE Entrada SET PrecioFinal = NULL WHERE ID_entrada = ID_entradaIN;
        UPDATE Entrada SET Estado = "Disponible" WHERE ID_entrada = ID_entradaIN;
        UPDATE Entrada SET ID_cliente = NULL WHERE ID_entrada = ID_entradaIN;

    ELSE
        CALL error(1234,"Usted no tiene: reservada la entrada");
    END IF;

END //


DROP PROCEDURE IF EXISTS anularFinTiempo //

CREATE PROCEDURE anularFinTiempo(

)

BEGIN
    DECLARE numEvento INT;
    DECLARE cursorEventos CURSOR FOR SELECT RecintoEspectaculo.ID_evento FROM RecintoEspectaculo WHERE FechaAnulacion < NOW();
        
    SET numEvento = 0;



    OPEN cursorEventos;
        BEGIN
            DECLARE finEventos BOOLEAN DEFAULT false;
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET finEventos = TRUE;

            bucleEventos : LOOP
                    FETCH cursorEventos INTO numEvento;
                    
                    IF finEventos THEN
                        LEAVE bucleEventos;
                    ELSE
                        INSERT INTO EntradaAnulada(ID_evento, ID_cliente) SELECT ID_evento, ID_cliente FROM Entrada WHERE ID_evento = numEvento AND Estado = "Reservada";
                        UPDATE Entrada SET Estado = "Disponible", ID_cliente = NULL WHERE ID_evento = numEvento AND Entrada.Estado = "Reservada"; 

                    END IF; 
        
                END LOOP;
            END;
        CLOSE cursorEventos;
END //


DROP PROCEDURE IF EXISTS calcularPrecio //

CREATE PROCEDURE calcularPrecio(

    IN ID_espectaculoIN INT,
    IN ID_gradaIN INT,
    IN TipoUsuarioIN VARCHAR(20),
    OUT PrecioFinal FLOAT
)

BEGIN 

    DECLARE FactorAumentoGrada FLOAT;
    DECLARE FactorDescuentoUsuario FLOAT;
    DECLARE PrecioBaseEvento FLOAT;

    SET FactorAumentoGrada = 0;
    SET FactorDescuentoUsuario = 0;
    SET PrecioBaseEvento = 0;

    SELECT PrecioBase INTO PrecioBaseEvento FROM Espectaculo WHERE ID_espectaculo = ID_espectaculoIN;
    SELECT FactorAumentoPrecio INTO FactorAumentoGrada FROM Grada WHERE ID_grada = ID_gradaIN;
    SELECT FactorDescuento INTO FactorDescuentoUsuario FROM TipoUsuario WHERE Tipo = TipoUsuarioIN;

    SET PrecioFinal = PrecioBaseEvento * FactorAumentoGrada * FactorDescuentoUsuario;

END //


DROP TRIGGER IF EXISTS trigger_EstadoLocalidad //

CREATE TRIGGER trigger_EstadoLocalidad AFTER UPDATE ON Localidad for each row
BEGIN

    DECLARE numEvento INT;
    DECLARE cursorEventos CURSOR FOR SELECT ID_evento FROM RecintoEspectaculo WHERE ID_recinto = new.ID_recinto AND FechaInicio > NOW();
    
    SET numEvento = 0;

    IF (new.Estado = "Disponible") THEN
        
        OPEN cursorEventos;
        BEGIN

            DECLARE finEventos BOOLEAN DEFAULT false;
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET finEventos = TRUE;
            bucleEventos: LOOP

                FETCH cursorEventos INTO numEvento;

                IF finEventos THEN
                    LEAVE bucleEventos;
                ELSE
                    INSERT INTO Entrada (ID_evento, ID_localidad) VALUES (numEvento, new.ID_localidad);
                END IF;
            END LOOP;
        END;
        CLOSE cursorEventos;

    ELSE

        INSERT INTO EntradaAnulada (ID_evento, ID_cliente, PrecioFinal) SELECT ID_evento, ID_cliente, PrecioFinal FROM Entrada WHERE ID_localidad = new.ID_localidad AND (Estado = "Reservada");
        INSERT INTO EntradaAnulada (ID_evento, ID_cliente, PrecioFinal, Comprada) SELECT ID_evento, ID_cliente, PrecioFinal, TRUE FROM Entrada WHERE ID_localidad = new.ID_localidad AND (Estado = "Comprada");
        DELETE FROM Entrada WHERE ID_localidad = new.ID_localidad;

    END IF;
END //




DROP PROCEDURE IF EXISTS agregarCliente //

CREATE PROCEDURE agregarCliente(

    IN ID_clienteIN VARCHAR(9),
    IN correoIN VARCHAR(30)

)

BEGIN

INSERT INTO Cliente (ID_Cliente, Correo_electronico) VALUES (ID_clienteIN, correoIN);

END //



DROP VIEW IF EXISTS VistaEntradas //

CREATE VIEW VistaEntradas AS SELECT Espectaculo.Nombre AS Espectaculo, Recinto.Nombre AS Recinto, Grada.Nombre AS Grada, COUNT(Entrada.ID_entrada) AS EntradasDisponibles, RecintoEspectaculo.FechaInicio FROM RecintoEspectaculo 
    JOIN Recinto ON RecintoEspectaculo.ID_recinto = Recinto.ID_recinto
    JOIN Espectaculo ON RecintoEspectaculo.ID_espectaculo = Espectaculo.ID_espectaculo
    JOIN Grada ON Recinto.ID_recinto = Grada.ID_recinto
    JOIN Entrada ON RecintoEspectaculo.ID_evento = Entrada.ID_evento
    WHERE Entrada.Estado = "Disponible"
    GROUP BY RecintoEspectaculo.ID_evento, Grada.ID_grada;



DROP PROCEDURE IF EXISTS misEntradas //

CREATE PROCEDURE misEntradas(

    IN ID_clienteIN VARCHAR(9)

)

BEGIN

    SELECT Espectaculo.Nombre AS Espectaculo, Recinto.Nombre AS Recinto, Grada.Nombre AS Grada, Localidad.Numero AS Asiento, RecintoEspectaculo.FechaInicio FROM Entrada
    JOIN RecintoEspectaculo ON Entrada.ID_evento = RecintoEspectaculo.ID_evento
    JOIN Recinto ON Recinto.ID_recinto = RecintoEspectaculo.ID_recinto
    JOIN Espectaculo ON Espectaculo.ID_espectaculo = RecintoEspectaculo.ID_espectaculo
    JOIN Localidad ON Localidad.ID_localidad = Entrada.ID_localidad
    JOIN Grada ON Grada.ID_grada = Localidad.ID_grada
    WHERE ID_cliente = ID_clienteIN;
    

END //


DROP PROCEDURE IF EXISTS EntradasDisponibles //

CREATE PROCEDURE EntradasDisponibles(

    IN ID_eventoIN INT

)

BEGIN

    SELECT Localidad.Numero FROM Entrada 
    JOIN Localidad ON Localidad.ID_localidad = Entrada.ID_localidad
    WHERE ID_evento = ID_eventoIN AND Entrada.Estado = "Disponible";


END //


DROP PROCEDURE IF EXISTS compruebaFinEvento //

CREATE PROCEDURE compruebaFinEvento(

)

BEGIN

    DECLARE numEventos INT;
    DECLARE cursorEvento CURSOR FOR SELECT RecintoEspectaculo.ID_evento FROM RecintoEspectaculo WHERE FechaFin < NOW();

    set numEventos = 0;

    OPEN cursorEvento;
        BEGIN
            DECLARE finEventos BOOLEAN DEFAULT false;
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET finEventos = TRUE;

            bucleEventos : LOOP
                FETCH cursorEvento INTO numEventos;

                IF finEventos THEN
                    LEAVE bucleEventos;
                ELSE
                    UPDATE RecintoEspectaculo SET Estado = "Finalizado" WHERE ID_evento = numEventos;
                    DELETE FROM Entrada WHERE ID_evento = numEventos AND Estado != "Comprada";

                END IF;
            END LOOP;
        END;
    CLOSE cursorEvento;
END //




DROP EVENT IF EXISTS eventoAnular //

CREATE EVENT eventoAnular 
ON SCHEDULE EVERY 15 MINUTE
DO
BEGIN

    CALL anularFinTiempo();
    CALL compruebaFinEvento();
    
END //




DROP PROCEDURE IF EXISTS error //

CREATE PROCEDURE error ( errno BIGINT UNSIGNED,
    message VARCHAR(100)
)
BEGIN
    SIGNAL SQLSTATE
        'ERROR'

SET 
    MESSAGE_TEXT = message,
    MYSQL_ERRNO = errno;

END //

DELIMITER ;