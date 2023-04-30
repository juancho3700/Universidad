import java.util.ArrayList;

public class Pareja {

  private String nombrePareja;
  private int idP;
  private static int contadorIdP = 0;
  public ArrayList <Jugador> jugadores = new ArrayList <Jugador> ();
  private int nPiedras = 0;

  public Pareja (String nomP, String nomJ1, String nomJ2) {
    nombrePareja = nomP;

    jugadores.add (new Jugador (nomJ1));
    jugadores.add (new Jugador (nomJ2));

    idP = contadorIdP;
    contadorIdP++;
  }


  public int getIdP () {
    return idP;
  }


  public String getNombreP () {
    return nombrePareja;
  }


  public int getNPiedras () {
    return nPiedras;
  }


  public void masVictoria () {
    nPiedras = nPiedras + 3;
  }


  public void masEmpate () {
    nPiedras = nPiedras + 1;
  }


  public int mejorGrande () {
    String comp = "124567SCR";
    int i1, i2;
    int i = 3;

    do {

      i1 = comp.indexOf (jugadores.get (0).cartas.get (i).getDenominacion ());
      if (i1 == -1) {
        i1 = 8;

      } else if (i1 == 1) {
        i1 = 0;
      }

      i2 = comp.indexOf (jugadores.get (1).cartas.get (i).getDenominacion ());
      if (i2 == -1) {
        i2 = 8;

      } else if (i2 == 1) {
        i2 = 0;
      }

      i--;

      if (i1 > i2) {
        return 0;


      } else if (i1 < i2)
        return 1;

    } while (i >= 0);
    return 0;
  }



  public int mejorChica () {
    String comp = "124567SCR";
    int i1, i2;



    for (int i = 0; i < 4; i++) {

      i1 = comp.indexOf (jugadores.get (0).cartas.get (i).getDenominacion ());
      if (i1 == -1) {
        i1 = 8;

      } else if (i1 == 1) {
        i1 = 0;
      }

      i2 = comp.indexOf (jugadores.get (1).cartas.get (i).getDenominacion ());

      if (i2 == -1) {
        i2 = 8;

      } else if (i2 == 1) {
        i2 = 0;
      }

      if (i1 > i2) {
        return 1;


      } else if (i1 < i2) {
        return 0;


      }
    }
    return 0;

  }
}
