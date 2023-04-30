import java.util.ArrayList;

public class Probando {

  public static void main(String[] args) {
    Partida partida = new Partida();

    ArrayList <Carta> cartas = partida.sacarCartas ();
    ArrayList <Jugador> jugadores = partida.sacarJugadores ();
    ArrayList <Pareja> parejas = partida.sacarParejas (jugadores);

    partida.setGanador (cartas, jugadores, parejas);
  }
}
