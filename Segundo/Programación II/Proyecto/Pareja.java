import java.util.ArrayList;

public class Pareja {

  private String nombrePareja;
  private int idP;
  public ArrayList <Jugador> jugadores = new ArrayList <Jugador> ();
  private int nPiedras = 0;

  public Pareja (String nomP, int id, Jugador j1, Jugador j2) {
    nombrePareja = nomP;

    jugadores.add (j1);
    jugadores.add (j2);

    idP = id;
  }



  public void resetPiedras () {
    nPiedras = 0;
  }



  public int getIdP () {
    return idP;
  }



  public String getNombreP () {
    return nombrePareja;
  }



  public int getPiedras () {
    return nPiedras;
  }



  public void masPuntos (int n) {
    nPiedras = nPiedras + n;
  }



  public int mejorGrande () {
    String comp = "124567SCR";
    int i1, i2;
    Jugador js[] = {jugadores.get (0), jugadores.get (1)};

    for (int i = 3; i >= 0; i--) {

      i1 = comp.indexOf (js[0].cartas.get (i).getDenominacion ());
      if (i1 == -1) {
        i1 = 8;

      } else if (i1 == 1) {
        i1 = 0;
      }

      i2 = comp.indexOf (js[1].cartas.get (i).getDenominacion ());
      if (i2 == -1) {
        i2 = 8;

      } else if (i2 == 1) {
        i2 = 0;
      }

      i--;

      if (i1 > i2) {
        js[0].masPiedras (3);
        return 0;


      } else if (i1 < i2) {
        js[1].masPiedras (3);
        return 1;

      }
    }
    js[0].masPiedras (3);
    return 0;
  }



  public int mejorChica () {
    String comp = "124567SCR";
    int i1, i2;
    Jugador js [] = {jugadores.get (0), jugadores.get (1)};

    for (int i = 0; i < 4; i++) {

      i1 = comp.indexOf (js[0].cartas.get (i).getDenominacion ());
      if (i1 == -1) {
        i1 = 8;

      } else if (i1 == 1) {
        i1 = 0;
      }

      i2 = comp.indexOf (js[1].cartas.get (i).getDenominacion ());

      if (i2 == -1) {
        i2 = 8;

      } else if (i2 == 1) {
        i2 = 0;
      }

      if (i1 > i2) {
        js[1].masPiedras (3);
        return 0;


      } else if (i1 < i2) {
        js[0].masPiedras (3);
        return 1;

      }
    }
    js[0].masPiedras (3);
    return 0;
  }



  public int mejorPares () {
    int piedras = 0;
    char den = 'a';
    Carta cAux;

    for (Jugador jugador : jugadores) {
      ArrayList <Carta> nCartas = new ArrayList <Carta> ();

      for (int i = 0; i < 4; i++) {
        cAux = jugador.cartas.get (i);
        if (cAux.getDenominacion () == '3') {
          cAux.setDenominacion ('R');

        } else if (cAux.getDenominacion () == '2') {
          cAux.setDenominacion ('1');

        }
        nCartas.add (cAux);
      }

      for (int j = 0; j < 3; j++) {
        for (int k = (j + 1); k < 4; k++) {
          char den1 = nCartas.get (j).getDenominacion ();
          char den2 = nCartas.get (k).getDenominacion ();

          if (den1 == den2) {
            nCartas.remove (j);
            nCartas.remove (k);
            den = den1;
            break;
          }
        }

        if (nCartas.size () == 2) {
          break;
        }
      }

      if (nCartas.size () == 2) {
        for (int j = 0; j < 2; j++) {
          char den1 = nCartas.get (j).getDenominacion ();

          if (den == den1){
            nCartas.remove (j);
            break;
          }
        }

        if (nCartas.size () == 1) {
          char den1 = nCartas.get (0).getDenominacion ();

          if (den == den1) {
            nCartas.remove (0);
          }

        } else {
          char den1 = nCartas.get (0).getDenominacion ();
          char den2 = nCartas.get (1).getDenominacion ();

          if (den1 == den2) {
            nCartas.clear ();
          }
        }

      } else {
        nCartas.remove (0);
      }

      jugador.masPiedras (4 - nCartas.size ());
      piedras += 4 - nCartas.size ();
    }
    return piedras;
  }



  public int[] mejorJuego () {
    Jugador js [] = {jugadores.get (0), jugadores.get (1)};
    int puntos[] = new int [2];
    int puntosAux[] = {0, 0};

    for (int i = 0; i < 2; i++) {
      puntos[i] = js[i].getPuntos ();

      if (puntos[i] < 31) {
        js[i].masPuntos (-puntos[i]);

      } else if (puntos[i] == 31) {
        js[i].masPuntos (11);

      } else if (puntos[i] == 32) {
        js[i].masPuntos (9);
      }
    }

    for (int i = 0; i < 2; i++) {
      puntosAux[i] = js[i].getPuntos ();

      if (puntosAux[i] != 0) {
        js[i].masPiedras (2);

        if (puntosAux[i] == 42) {
          js[i].masPiedras (1);
        }
      }
    }

    if (puntos[0] < puntos[1]) {
      int puntosF[] = {1, 0};
      return puntosF;

    } else {
      int puntosF[] = {0, 1};
      return puntosF;
    }
  }
}
