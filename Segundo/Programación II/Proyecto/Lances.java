import java.util.Comparator;
import java.util.ArrayList;

public class Lances {

  public static int[] resuelveGrande (ArrayList <Pareja> nParejas) {
    int piedras[] = {0, 0};
    int js[] = new int [2];
    boolean win = false;
    String comp = "124567SCR";

    for (int i = 0; i < 2; i++) {
        js[i] = nParejas.get (i).mejorGrande ();
    }

    for (int i = 3; i >= 0; i--) {

      int i1 = comp.indexOf (nParejas.get (0).jugadores.get (js [0]).cartas.get (i).getDenominacion ());
      if (i1 == -1) {
        i1 = 8;

      } else if (i1 == 1) {
        i1 = 0;
      }

      int i2 = comp.indexOf (nParejas.get (1).jugadores.get (js [1]).cartas.get (i).getDenominacion ());
      if (i2 == -1) {
        i2 = 8;

      } else if (i2 == 1) {
        i2 = 0;
      }

      if (i1 > i2) {
        win = true;
        nParejas.get (1). masPuntos (-3);
        piedras[0] = 3;
        break;

      } else if (i2 > i1) {
        win = true;
        nParejas.get (0). masPuntos (-3);
        piedras[1] = 3;
        break;
      }
    }

    if (win == false) {
      nParejas.get (0). masPuntos (-2);
      nParejas.get (1). masPuntos (-2);
      piedras[0] = 1;
      piedras[1] = 1;
    }
    return piedras;
  }



  public static int[] resuelveChica (ArrayList <Pareja> nParejas) {
    int js [] = new int [2];
    boolean win = false;
    String comp = "124567SCR";
    int piedras[] = {0, 0};

    for (int i = 0; i < nParejas.size (); i++) {
        js [i] = nParejas.get (i).mejorChica ();
    }

    for (int i = 0; i < 4; i++) {

      int i1 = comp.indexOf (nParejas.get (0).jugadores.get (js [0]).cartas.get (i).getDenominacion ());
      if (i1 == -1) {
        i1 = 8;

      } else if (i1 == 1) {
        i1 = 0;
      }

      int i2 = comp.indexOf (nParejas.get (1).jugadores.get (js [1]).cartas.get (i).getDenominacion ());
      if (i2 == -1) {
        i2 = 8;

      } else if (i2 == 1) {
        i2 = 0;
      }

      if (i1 < i2) {
        win = true;
        nParejas.get (1). masPuntos (-3);
        piedras[0] = 3;
        return piedras;

      } else if (i1 > i2) {
        win = true;
        nParejas.get (0). masPuntos (-3);
        piedras[1] = 3;
        return piedras;
      }
    }

    if (win == false) {
      nParejas.get (0). masPuntos (-2);
      nParejas.get (1). masPuntos (-2);
      piedras[0] = 1;
      piedras[1] = 1;
      return piedras;
    }
    return piedras;
  }



  public static int[] resuelvePares (ArrayList <Pareja> nParejas) {
    int piedras[] = new int [2];

    for (int i = 0; i < nParejas.size (); i++) {
      piedras[i] = nParejas.get (i).mejorPares ();
    }

    return piedras;
  }



  public static int[] resuelveJuego (ArrayList <Pareja> nParejas) {
    int indices[][] = new int [nParejas.size ()][4];
    int piedras[] = {0, 0};
    Jugador js [][] = new Jugador [2][2];

    for (int i = 0; i < 2; i++) {
      indices[i] = nParejas.get (i).mejorJuego ();
    }

    js[0][0] = nParejas.get (0).jugadores.get (indices[0][1]);
    js[0][1] = nParejas.get (1).jugadores.get (indices[1][1]);

    js[1][0] = nParejas.get (0).jugadores.get (indices[0][1]);
    js[1][1] = nParejas.get (1).jugadores.get (indices[1][1]);

    if (js[0][0].getPuntos () < js[0][1].getPuntos ()) {
      piedras[1] += 2;
      js[0][1].masPiedras (2);

    } else if (js[0][0].getPuntos () > js[0][1].getPuntos ()) {
      piedras[0] += 2;
      js[0][0].masPiedras (2);

    } else {

      if (js[1][0].getPuntos () < js[1][1].getPuntos ()) {
        piedras[1] += 2;
        js[1][1].masPiedras (2);

      } else if (js[1][0].getPuntos () > js[1][1].getPuntos ()) {
        piedras[0] += 2;
        js[1][0].masPiedras (2);

      } else {
        if (js[1][0].getMano () == true) {
          piedras[0] += 2;
          js[1][0].masPiedras (2);

        } else if (js[1][1].getMano () == true) {
          piedras[1] += 2;
          js[1][1].masPiedras (2);

        } else if (js[0][1].getMano () == true) {
          piedras[0] += 2;
          js[1][1].masPiedras (2);

        } else if (js[0][0].getMano () == true) {
          piedras[1] += 2;
          js[0][0].masPiedras (2);

        }
      }
    }

    for (int i = 0; i < 2; i++) {
      nParejas.get (i).masPuntos (piedras[i]);
    }

    return piedras;
  }
}
