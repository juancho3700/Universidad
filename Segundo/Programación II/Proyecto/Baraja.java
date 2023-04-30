import java.util.ArrayList;
import java.util.Collections;

public class Baraja {

  private ArrayList <Carta> baraja = new ArrayList <Carta> ();

  public Baraja () {
    String repr = new String ();
    char denoms [] = {'1','2','3','4','5','6','7','S','C','R'};
    char palos [] = {'B','C','E','O'};

    for (int i = 0; i < palos.length; i++){

      for (int j = 0; j < denoms.length; j++){

        repr = "" + denoms [j] + palos [i];
        baraja.add (new Carta (repr));

      }
    }
    barajar ();
  }



  private void barajar () {
    Collections.shuffle (baraja);

  }



  public ArrayList <Carta> sacarCarta () {

    ArrayList <Carta> nCartas = new ArrayList <Carta> ();

    for (int i = 0; i < 16; i++) {
      nCartas.add (new Carta (baraja.get (i).getCarta ()));

    }
    barajar ();
    return nCartas;
  }
}
