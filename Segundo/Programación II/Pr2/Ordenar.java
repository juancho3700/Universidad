import java.util.Comparator;

public class Ordenar implements Comparator <Carta> {

  public int compare (Carta c1, Carta c2){
    if (c1.getPalo () == c2.getPalo ()){
      int i1 = "1234567SCR".indexOf (c1.getDenominacion ());
      int i2 = "1234567SCR".indexOf (c2.getDenominacion ());

      if (i1 > i2){
        return 1;
      }
      else {
        return -1;
      }
    }
    else {
      if (c1.getPalo () > c2.getPalo ()) {
        return 1;
      }
      else {
        return -1;
      }
    }
  }
}
