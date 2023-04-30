public class Carta {

  private char denominacion;
  private char palo;
  private int puntos;


  public Carta (String representacion) {    //Con esto creas las variables de esta clase
    denominacion = representacion.charAt(0);
    palo = representacion.charAt(1);
    calculaPuntos ();
  }



  public String getCarta () {
    String n = String.valueOf (denominacion) + String.valueOf (palo);
    return n;
  }



  public void setDenominacion (char den) {
    denominacion = den;
  }



  public char getDenominacion () {
    return denominacion;
  }



  public char getPalo () {
    return palo;
  }



  public int getPuntos () {
    return puntos;
  }



  private void calculaPuntos () {
    switch (denominacion) {

      case '1':
        puntos = 1;
        break;

      case '2':
        puntos = 1;
        break;

      case '3':
        puntos = 10;
        break;

      case '4':
        puntos = 4;
        break;

      case '5':
        puntos = 5;
        break;

      case '6':
        puntos = 6;
        break;

      case '7':
        puntos = 7;
        break;

      case 'S':
        puntos = 10;
        break;

      case 'C':
        puntos = 10;
        break;

      case 'R':
        puntos = 10;
        break;
    }
  }
}
