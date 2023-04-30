DROP USER IF EXISTS 'cliente'@'localhost';
CREATE USER 'cliente'@'localhost' IDENTIFIED by 'AxelVal1.';

GRANT SELECT ON Proyecto.VistaEntradas TO 'cliente'@'localhost';
GRANT EXECUTE ON PROCEDURE reservarEntrada TO 'cliente'@'localhost';
GRANT EXECUTE ON PROCEDURE comprarEntrada TO 'cliente'@'localhost';
GRANT EXECUTE ON PROCEDURE anularEntrada TO 'cliente'@'localhost';
GRANT EXECUTE ON PROCEDURE agregarCliente TO 'cliente'@'localhost';
GRANT EXECUTE ON PROCEDURE misEntradas TO 'cliente'@'localhost';
GRANT EXECUTE ON PROCEDURE EntradasDisponibles TO 'cliente'@'localhost';



DROP USER IF EXISTS 'administracion'@'localhost';
CREATE USER 'administracion'@'localhost' IDENTIFIED BY 'Administ1.';

GRANT EXECUTE ON PROCEDURE crearRecinto TO 'administracion'@'localhost';
GRANT EXECUTE ON PROCEDURE crearEspectaculo TO 'administracion'@'localhost';
GRANT EXECUTE ON PROCEDURE crearGrada TO 'administracion'@'localhost';
GRANT EXECUTE ON PROCEDURE eliminarGrada TO 'administracion'@'localhost';
GRANT EXECUTE ON PROCEDURE crearEvento TO 'administracion'@'localhost';
GRANT EXECUTE ON PROCEDURE cambiarEstadoLocalidad TO 'administracion'@'localhost';
GRANT EXECUTE ON PROCEDURE cancelarEvento TO 'administracion'@'localhost';
GRANT SELECT ON Proyecto.VistaRecintos TO 'administracion'@'localhost';




DROP USER IF EXISTS 'mantenimiento'@'localhost';
CREATE USER 'mantenimiento'@'localhost' IDENTIFIED BY 'Mantenim1.';

GRANT ALL PRIVILEGES ON *.* TO 'mantenimiento'@'localhost';

FLUSH PRIVILEGES;