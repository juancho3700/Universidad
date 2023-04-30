import java.util.ArrayList;

public class Probando {

  public static void main (String[] args) {
    Partida partida = new Partida ();

    ArrayList <Pareja> parejas = partida.sacarParejas ();

    String stringCartas = partida.leerArchivo ();
    partida.sacarCartas (parejas, stringCartas);

    partida.escribirNombres (parejas);
    partida.escribirCartas (parejas);

    partida.resuelveGrande (parejas);
    partida.resuelveChica (parejas);
    partida.setGanador (parejas);
  }
}
