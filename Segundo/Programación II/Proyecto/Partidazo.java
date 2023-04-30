import java.util.ArrayList;
import java.util.StringTokenizer;

public class Partidazo {
  public static void main (String args[]) {

    String ficheroSalida = null;
    String ficheroJugadores = null;
    Juegos juego = new Juegos ();

    if (args[3] == "-o") {
      ficheroSalida = args[4];

    } else if (args[3] == "-p") {
      ficheroJugadores = args[4];

      if (args[5] == "-o") {
        ficheroSalida = args[6];
      }
    }

    switch (args[1]) {
      case "-c":
        juego.juegoComandos (args[2], ficheroSalida);
        break;

      case "-j":
        juego.juegoPreestablecido (args[2], ficheroJugadores, ficheroSalida);
        break;

      default:
        juego.juegoAutonomo (args[2], ficheroSalida);
        break;
    }
  }

  /*

    Modulo 1, 2 y comando PlayGame:

    Hacer una funcion que haga las parejas por fichero y si el parametro del nombre
    del fichero es null se crean por defecto.


    Modulo 2 y PlayGamw:

    Hacen lo mismo pero en el nombre de fichero en el comando PlayGame tienes que meterle
    null



*/

}
