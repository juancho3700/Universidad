import java.util.ArrayList;

public class Probando {

  public static void main(String[] args) {
    Partida partida = new Partida();

    ArrayList <Jugador> jugadores = partida.sacarJugadores ();
    ArrayList <Pareja> parejas = partida.sacarParejas (jugadores);
    String stringCartas = partida.leerArchivo ();
    ArrayList <Carta> cartas = partida.sacarCartas (jugadores, stringCartas);
    cartas = partida.ordenarCartas (cartas);

    partida.setGanador (cartas, jugadores, parejas, stringCartas);
  }
}
