import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Baraja {

  private ArrayList <Carta> baraja = new ArrayList <Carta> ();
  private static int numCarta;

  public int getNumCarta (){
    return numCarta;
  }

  public Baraja (){

  }




  public void nuevaBaraja (){
    String repr = new String ();
    char denoms [] = {'1','2','3','4','5','6','7','S','C','R'};
    char palos [] = {'B','C','E','O'};

    for (int i = 0; i < palos.length; i++){

      for (int j = 0; j < denoms.length; j++){

        repr = "" + denoms [j] + palos [i];
        baraja.add (new Carta (repr));
        System.out.print (repr);

        if (j == 9){
          break;
        }

        System.out.print (", ");
      }
      System.out.println ("");
    }
    System.out.print ("\n");
  }




  public void barajar (){
    Collections.shuffle (baraja);

    for (int i = 0; i < 40; i++){

      System.out.print (baraja.get(i).getCarta());

      if (i == 40){
        break;
      }
      if ((i + 1) % 10 == 0 && i != 0){
        System.out.println ("");

      } else {
        System.out.print (", ");

      }
    }
    System.out.println ("\n");
  }




  public boolean sacarCartas (int n){
    ArrayList <Carta> nCartas = new ArrayList <Carta> ();

    while (numCarta < n){
      nCartas.add (new Carta (baraja.get(numCarta).getCarta ()));
      System.out.print (nCartas.get(numCarta).getCarta ());

      if (numCarta == n - 1){
        break;
      }
      System.out.print (", ");
      numCarta++;
    }
    System.out.println ("\n");

    if (nCartas == null){
      return true;

    } else {
      return false;
    }

  }




  public boolean restablecerBaraja (){
    numCarta = 0;
    baraja.clear ();
    nuevaBaraja ();

    if (baraja == null){
      return true;

    } else {
      return false;
    }

  }




  public boolean ordenarBaraja (){
    numCarta = 0;
    Collections.sort (baraja);

    for (int i = 0; i < 40; i++){

      System.out.print (baraja.get(i).getCarta());

      if (i == 40){
        break;
      }
      if ((i + 1) % 10 == 0 && i != 0){
        System.out.println ("");

      } else {
        System.out.print (", ");

      }
    }
    System.out.println ("\n");

    if (baraja == null){
      return true;

    } else {
      return false;
    }
  }
}
