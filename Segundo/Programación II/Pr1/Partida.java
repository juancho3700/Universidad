import java.util.ArrayList;

public class Partida {

  public ArrayList <Jugador> sacarJugadores (){
    ArrayList <Jugador> nJugadores = new ArrayList <Jugador> ();

    nJugadores.add (new Jugador ("Anselmo"));
    nJugadores.add (new Jugador ("Tania"));
    nJugadores.add (new Jugador ("Anxo"));
    nJugadores.add (new Jugador ("Axel"));

    return nJugadores;
  }

  public ArrayList <Pareja> sacarParejas (ArrayList <Jugador> nJugadores){
    ArrayList <Pareja> nParejas = new ArrayList <Pareja> ();

    nParejas.add (new Pareja ("Los Veteranos", nJugadores.get(0).getIdJ(), nJugadores.get(1).getIdJ()));
    nParejas.add (new Pareja ("Los Novatos", nJugadores.get(2).getIdJ(), nJugadores.get(3).getIdJ()));

    return nParejas;
  }


  public ArrayList <Carta> sacarCartas (){
    ArrayList <Carta> nCartas = new ArrayList <Carta> ();

    nCartas.add (new Carta ("3O"));
    nCartas.add (new Carta ("RO"));
    nCartas.add (new Carta ("1C"));
    nCartas.add (new Carta ("2B"));

    nCartas.add (new Carta ("5E"));
    nCartas.add (new Carta ("4C"));
    nCartas.add (new Carta ("3E"));
    nCartas.add (new Carta ("3B"));

    nCartas.add (new Carta ("4C"));
    nCartas.add (new Carta ("4B"));
    nCartas.add (new Carta ("4E"));
    nCartas.add (new Carta ("SB"));

    nCartas.add (new Carta ("6B"));
    nCartas.add (new Carta ("6E"));
    nCartas.add (new Carta ("RB"));
    nCartas.add (new Carta ("CC"));

    return nCartas;
  }

  public void setGanador (ArrayList <Carta> nCartas, ArrayList <Jugador> nJugadores, ArrayList <Pareja> nParejas){
    int k = 0;
    int puntos[] = new int [6];

    puntos[0] = nCartas.get(0).getPuntos() + nCartas.get(1).getPuntos() + nCartas.get(2).getPuntos() + nCartas.get(3).getPuntos();
    puntos[1] = nCartas.get(4).getPuntos() + nCartas.get(5).getPuntos() + nCartas.get(6).getPuntos() + nCartas.get(7).getPuntos();
    puntos[2] = nCartas.get(9).getPuntos() + nCartas.get(9).getPuntos() + nCartas.get(10).getPuntos() + nCartas.get(11).getPuntos();
    puntos[3] = nCartas.get(12).getPuntos() + nCartas.get(13).getPuntos() + nCartas.get(14).getPuntos() + nCartas.get(15).getPuntos();

    puntos[4] = puntos[0] + puntos[1];
    puntos[5] = puntos[2] + puntos[3];

    System.out.println ("Cartas de " + nJugadores.get(0).getNombreJ() + " de la pareja " +
                        nParejas.get(0).getNombreP() + ": " + nCartas.get(0).getCarta() + ", " +
                        nCartas.get(1).getCarta() + ", " + nCartas.get(2).getCarta() + ", " +
                        nCartas.get(3).getCarta());

    System.out.println ("Cartas de " + nJugadores.get(1).getNombreJ() + " de la pareja " +
                       nParejas.get(0).getNombreP() + ": " + nCartas.get(4).getCarta() + ", " +
                       nCartas.get(5).getCarta() + ", " + nCartas.get(6).getCarta() + ", " +
                       nCartas.get(7).getCarta());

    System.out.println ("Cartas de " + nJugadores.get(2).getNombreJ() + " de la pareja " +
                       nParejas.get(1).getNombreP() + ": " + nCartas.get(8).getCarta() + ", " +
                       nCartas.get(9).getCarta() + ", " + nCartas.get(10).getCarta() + ", " +
                       nCartas.get(11).getCarta());

    System.out.println ("Cartas de " + nJugadores.get(3).getNombreJ() + " de la pareja " +
                       nParejas.get(1).getNombreP() + ": " + nCartas.get(12).getCarta() + ", " +
                       nCartas.get(13).getCarta() + ", " + nCartas.get(14).getCarta() + ", " +
                       nCartas.get(15).getCarta());


    if (puntos[4] > puntos[5]) {
      System.out.println ("Gana " + nParejas.get(0).getNombreP() + " por " + puntos[4] + " (" + puntos[0]
                          + " + " + puntos[1] + ") frente a los " + puntos[5] + " puntos que consigue "
                          + nParejas.get(1).getNombreP() + " (" +  puntos[2] + " + " + puntos[3] + ").\n");
    }
    else if (puntos[4] < puntos[5]) {
      System.out.println ("Gana " + nParejas.get(1).getNombreP() + " por " + puntos[5] + " (" + puntos[2]
                          + " + " + puntos[3] + ") frente a los " + puntos[4] + " puntos que consigue " +
                          nParejas.get(0).getNombreP() + " (" +  puntos[0] + " + " + puntos[1] + ").\n");
    }
    else {
      System.out.println (nParejas.get(0).getNombreP() + " y " + nParejas.get(1).getNombreP() +
                          "han empatado con " + puntos[4] + " (" + puntos[0]  + " + " +  puntos[1]
                          + "), (" + puntos[2]  + " + " + puntos[3] + ").\n");
    }
  }
}
