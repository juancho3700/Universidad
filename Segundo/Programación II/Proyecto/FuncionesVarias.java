import java.util.ArrayList;
import java.util.StringTokenizer;

public class FuncionesVarias {

  public static void resetPiedrasParejas (ArrayList <Pareja> nParejas) {
    for (Pareja pareja : nParejas){
      pareja.resetPiedras ();
    }
  }



  public static void resetPiedrasJugadores (ArrayList <Pareja> nParejas) {
    for (Pareja pareja : nParejas) {
      for (Jugador jugador : pareja.jugadores) {
        jugador.resetPiedras ();
      }
    }
  }



  public static void nuevaMano (ArrayList <Pareja> nParejas) {

    if (nParejas.get (0).jugadores.get (0).getMano () == true) {
      nParejas.get (0).jugadores.get (0).setMano (false);
      nParejas.get (1).jugadores.get (0).setMano (true);

    } else if (nParejas.get (1).jugadores.get (0).getMano () == true) {
      nParejas.get (1).jugadores.get (0).setMano (false);
      nParejas.get (0).jugadores.get (1).setMano (true);

    } else if (nParejas.get (0).jugadores.get (1).getMano () == true) {
      nParejas.get (0).jugadores.get (1).setMano (false);
      nParejas.get (1).jugadores.get (1).setMano (true);

    } else {
      nParejas.get (1).jugadores.get (1).setMano (false);
      nParejas.get (0).jugadores.get (0).setMano (true);
    }
  }



  public static void resuelveGeneral (ArrayList <Pareja> parejas, String lineaFichero, int piedrasParejas[]) {
    int piedras = 0;

    for (int i = 0; i < 2; i++) {
      for (Pareja pareja : parejas) {
        piedras = pareja.jugadores.get (i).getPiedrasJ ();
        lineaFichero += piedras + " ";
      }
    }

    lineaFichero += "- " + piedrasParejas[0] + " " + piedrasParejas[1] + "\n";
    System.out.println (lineaFichero);
  }



  public static ArrayList <Pareja> crearParejaDefecto (int numP) {
    ArrayList <Pareja> nParejas = new ArrayList <Pareja> ();

    if (numP == 2) {
      Jugador j1 = new Jugador (1, "J1PA");
      Jugador j2 = new Jugador (2, "J2PA");
      nParejas.add (new Pareja ("PA", 1, j1, j2));
    }

    Jugador j1 = new Jugador (3, "J1PB");
    Jugador j2 = new Jugador (4, "J2PB");
    nParejas.add (new Pareja ("PB", 2, j1, j2));

    return nParejas;
  }



  public static ArrayList <Pareja> crearParejaFichero (String fichero) {
    ArrayList <Pareja> parejas = new ArrayList <Pareja> ();
    ArrayList <Jugador> jugadores = new ArrayList <Jugador> ();
    int nLinea = 0;

    String linea = GestorFichero.leerLineaFichero (fichero, nLinea);
    if (linea == null) {
      return null;
    }

    String jOp[] = linea.split (" ", 2);

    while (jOp[0] != null) {
      if (jOp[0] == "J") {
        String params[] = jOp[1].split (" ", 2);
        jugadores.add (new Jugador (Integer.parseInt (params[0]), params[1]));

      } else {
        String params [] = jOp[1].split (" ", 6);
        int index[] = {-1, -1};

        for (int i = 0; i < jugadores.size (); i++) {

          if (index[0] == -1 && jugadores.get (i).getIdJ () == Integer.parseInt (params [0])) {
            index[0] = i;

          } else if (index[1] == -1 && jugadores.get (i).getIdJ () == Integer.parseInt (params [1])) {
            index[1] = i;
          }
        }

        if (index [0] != -1 && index [1] != -1) {
          parejas.add (new Pareja (params [2], Integer.parseInt(params [0]), jugadores.get (index [0]), jugadores.get (index [1])));
          jugadores.remove (index [0]);
          jugadores.remove (index [1]);

        } else {
          int numDef = 2 - parejas.size ();
          FuncionesVarias.crearParejaDefecto (numDef);
        }
      }

      nLinea++;
      linea = GestorFichero.leerLineaFichero (fichero, nLinea);
    }

    return parejas;
  }



  public static void setPrimeraMano (String linea, ArrayList <Pareja> nParejas) {
    if (linea.charAt (0) == '*') {
      nParejas.get (0).jugadores.get (0).setMano (true);

    } else if (linea.charAt (17) == '*') {
      nParejas.get (1).jugadores.get (0).setMano (true);

    } else if (linea.charAt (34) == '*') {
      nParejas.get (0).jugadores.get (1).setMano (true);

    } else if (linea.charAt (51) == '*') {
      nParejas.get (1).jugadores.get (1).setMano (true);
    }
  }



  public static ArrayList <Carta> separarCartas (String stringCartas, ArrayList <Pareja> nParejas) {
    ArrayList <Carta> nCartas = new ArrayList <Carta> ();
    StringTokenizer separador = new StringTokenizer (stringCartas, "- (),*");

    while (separador.hasMoreTokens ()) {
      String nC = separador.nextToken ();
      nCartas.add (new Carta (nC));
    }

    return nCartas;
  }



  public static void meterCartas (ArrayList <Carta> nCartas, ArrayList <Pareja> nParejas) {
    int cont = 0;

    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        Pareja par = nParejas.get (j);
        Jugador jug = par.jugadores.get (i);

        for (int k = 0; k < 4; k++) {
          jug.cartas.add (nCartas.get (i));

        }
        cont += 4;
      }
    }
  }
}
