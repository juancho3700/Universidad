import java.util.ArrayList;

public class Juegos {
  public void juegoAutonomo (String ficheroJugadores, String ficheroSalida) {
    int i = 0;
  }


  public void juegoPreestablecido (String ficheroJugadas, String ficheroJugadores, String ficheroSalida) {
    ArrayList <Pareja> parejas = new ArrayList <Pareja> ();

    if (ficheroJugadores == null) {
      parejas = FuncionesVarias.crearParejaDefecto (2);

    } else {

    }
  }


  public void juegoComandos (String ficheroComandos, String ficheroSalida) {
    boolean existeFichero = true;
    String lineaComando = null;
    int nLinea = 0;

    if (ficheroSalida == null) {
      existeFichero = false;

    }

    Comanditos comandos = new Comanditos (ficheroSalida, existeFichero);

    lineaComando = GestorFichero.leerLineaFichero (ficheroComandos, nLinea);
    while (lineaComando != null) {
      String params[] = lineaComando.split (" ", 2);
      comandos.detectarComando (params[0], params[1]);
    }
  }
}
