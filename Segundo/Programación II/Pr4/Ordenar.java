import java.util.Comparator;

public class Ordenar implements Comparator <Carta> {

  public int compare (Carta c1, Carta c2) {
    int i1, i2;

    if (c1.getDenominacion () == c2.getDenominacion ()) {
      i1 = "BCEO".indexOf (c1.getPalo ());
      i2 = "BCEO".indexOf (c2.getPalo ());

    } else {

      i1 = "124567SCR3".indexOf (c1.getDenominacion ());
      i2 = "124567SCR3".indexOf (c2.getDenominacion ());

    }

    if (i1 > i2) {
      return 1;

    } else {
      return -1;

    }
  }
}
