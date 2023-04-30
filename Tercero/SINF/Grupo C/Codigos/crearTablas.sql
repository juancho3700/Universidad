SYSTEM clear;

DROP TABLE IF EXISTS EntradaAnulada;
DROP TABLE IF EXISTS EntradaLocalidad;
DROP TABLE IF EXISTS FechaEntradaCliente;
DROP TABLE IF EXISTS Entrada;
DROP TABLE IF EXISTS RecintoEspectaculo;
DROP TABLE IF EXISTS FechaEvento;
DROP TABLE IF EXISTS Espectaculo;
DROP TABLE IF EXISTS Localidad;
DROP TABLE IF EXISTS Grada;
DROP TABLE IF EXISTS Recinto;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Fecha;
DROP TABLE IF EXISTS TipoUsuario;

CREATE TABLE Espectaculo(

    ID_espectaculo INT AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    FechaProduccion DATETIME NOT NULL,
    Tipo VARCHAR(15),
    Productor VARCHAR(100),
    PrecioBase FLOAT NOT NULL CHECK (PrecioBase >= 0),
    PRIMARY KEY (ID_espectaculo),
    CONSTRAINT nombre_tipo_fecha UNIQUE (Nombre, Tipo, FechaProduccion)
);

CREATE TABLE Recinto(

    ID_recinto INT AUTO_INCREMENT NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Calle VARCHAR(50) NOT NULL,
    Numero INT CHECK (Numero > 0),
    Sala INT CHECK (Sala > 0),
    Aforo INT NOT NULL CHECK (Aforo > 0),
    PRIMARY KEY (ID_recinto),
    CONSTRAINT direccion UNIQUE (Ciudad, Calle, Numero, Nombre, Sala)
);

CREATE TABLE Cliente(

    ID_cliente VARCHAR(9),
    Metodo_pago VARCHAR(50) DEFAULT NULL,
    Numero_cuenta VARCHAR(24) DEFAULT NULL,
    Correo_electronico VARCHAR(80),
    PRIMARY KEY (ID_Cliente),
    CONSTRAINT correo UNIQUE (Correo_electronico)
);

CREATE TABLE Fecha(

    ID_fecha INT,
    Fecha DATETIME DEFAULT NOW(),
    Movimiento VARCHAR(50),
    PRIMARY KEY (ID_fecha)

);


CREATE TABLE RecintoEspectaculo(

    ID_evento INT AUTO_INCREMENT NOT NULL,
    ID_espectaculo INT NOT NULL,
    ID_recinto INT NOT NULL,
    FechaInicio DATETIME NOT NULL,
    FechaFin DATETIME NOT NULL,
    FechaReserva DATETIME,
    FechaAnulacion DATETIME,
    Estado VARCHAR(50) DEFAULT "Abierto" NOT NULL CHECK (Estado = "Abierto" OR Estado = "No Disponible" OR Estado = "Finalizado"),
    PRIMARY KEY (ID_evento),
    CONSTRAINT espectaculo_recinto_fechaInicio UNIQUE (ID_espectaculo, ID_recinto, FechaInicio),  
    FOREIGN KEY (ID_espectaculo) REFERENCES Espectaculo (ID_espectaculo),
    FOREIGN KEY (ID_recinto) REFERENCES Recinto (ID_recinto)
);


CREATE TABLE Grada(

    ID_grada INT AUTO_INCREMENT NOT NULL,
    ID_recinto INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    FactorAumentoPrecio FLOAT DEFAULT 1.0 NOT NULL CHECK (FactorAumentoPrecio >= 1),
    Capacidad INT NOT NULL CHECK (Capacidad > 0),
    PRIMARY KEY (ID_grada),
    CONSTRAINT nombre_recinto UNIQUE (ID_recinto, Nombre),
    FOREIGN KEY (ID_recinto) REFERENCES Recinto (ID_recinto)
);

CREATE TABLE Localidad(

    ID_recinto INT NOT NULL,
    ID_grada INT NOT NULL,
    ID_localidad INT AUTO_INCREMENT NOT NULL,
    Numero INT NOT NULL CHECK (Numero >= 0),
    Estado VARCHAR(50) DEFAULT "Disponible" NOT NULL CHECK (Estado = "Disponible" OR Estado = "No Disponible"),
    PRIMARY KEY (ID_localidad),
    CONSTRAINT recinto_grada_numeroLocalidad UNIQUE (ID_recinto, ID_grada, Numero),
    FOREIGN KEY (ID_recinto) REFERENCES Recinto (ID_recinto),
    FOREIGN KEY (ID_grada) REFERENCES Grada (ID_grada) 
);

CREATE TABLE Entrada(

    ID_evento INT NOT NULL,
    ID_entrada INT AUTO_INCREMENT NOT NULL,
    ID_cliente VARCHAR(9) DEFAULT NULL,
    ID_localidad INT NOT NULL,
    Estado VARCHAR(50) DEFAULT "Disponible" NOT NULL CHECK (Estado = "Disponible" OR Estado = "Comprada" OR Estado = "Reservada" OR Estado = "No Disponible"),
    PrecioFinal FLOAT DEFAULT NULL,
    PRIMARY KEY (ID_entrada),
    CONSTRAINT evento_localidad UNIQUE (ID_evento, ID_localidad),
    FOREIGN KEY (ID_evento) REFERENCES RecintoEspectaculo (ID_evento),
    FOREIGN KEY (ID_localidad) REFERENCES Localidad (ID_localidad),
    FOREIGN KEY (ID_cliente) REFERENCES Cliente (ID_cliente)
);

CREATE TABLE EntradaAnulada(

    ID_evento INT NOT NULL,
    ID_entrada INT NOT NULL AUTO_INCREMENT,
    ID_cliente VARCHAR(9) NOT NULL,
    PrecioFinal FLOAT NOT NULL,
    Comprada BOOLEAN DEFAULT FALSE NOT NULL,
    PRIMARY KEY (ID_entrada),
    FOREIGN KEY (ID_evento) REFERENCES RecintoEspectaculo (ID_evento),
    FOREIGN KEY (ID_cliente) REFERENCES Cliente (ID_cliente)
);


CREATE TABLE EntradaLocalidad(

    ID_entrada INT NOT NULL,
    ID_localidad INT NOT NULL,
    Tipo_usuario VARCHAR(50) DEFAULT "Adulto",
    PRIMARY KEY (ID_entrada, ID_localidad),
    FOREIGN KEY (ID_entrada) REFERENCES Entrada (ID_entrada),
    FOREIGN KEY (ID_localidad) REFERENCES Localidad (ID_localidad)

);


CREATE TABLE TipoUsuario(

    Tipo VARCHAR(20) CHECK (Tipo = "Bebe" OR Tipo = "Infantil" OR Tipo = "Adulto" OR Tipo = "Parado" OR Tipo = "Jubilado"),
    FactorDescuento FLOAT DEFAULT 1 NOT NULL CHECK (FactorDescuento <= 1 AND FactorDescuento >= 0),
    PRIMARY KEY (Tipo)
);

SHOW TABLES;