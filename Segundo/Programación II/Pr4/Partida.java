import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.io.File;
import java.util.Collections;

public class Partida {

  public ArrayList <Pareja> sacarParejas () {
    ArrayList <Pareja> nParejas = new ArrayList <Pareja> ();

    nParejas.add (new Pareja ("Los Mejores", "Anselmo", "Oscar"));
    nParejas.add (new Pareja ("Los Otros", "El Webo", "Axel"));

    return nParejas;
  }




  public String leerArchivo () {
    String stringCartas = "\0";
    FileReader fr = null;

    try {
      fr = new FileReader ("jugadas.txt");
      BufferedReader br = new BufferedReader (fr);

      stringCartas = br.readLine ();

      br.close ();
    } catch (FileNotFoundException e1) {
      e1.printStackTrace ();

    } catch (Exception e2) {
      System.out.println (e2.getMessage ());

    } finally {
      try {
        if (fr != null) {
          fr.close ();
        }
      } catch (Exception e3) {
        System.out.println ("Error: fallo al cerrar el fichero");
        System.out.println (e3.getMessage ());
      }
    }

    return stringCartas;
  }




  public void sacarCartas (ArrayList <Pareja> nParejas, String stringCartas) {
    ArrayList <Carta> nCartas = new ArrayList <Carta> ();
    int cont = 0;

    StringTokenizer separador = new StringTokenizer (stringCartas, "- (),*");

    if (stringCartas.charAt (0) == '*') {
      nParejas.get (0).jugadores.get (0).setMano (true);

    } else if (stringCartas.charAt (17) == '*') {
      nParejas.get (1).jugadores.get (0).setMano (true);

    } else if (stringCartas.charAt (34) == '*') {
      nParejas.get (0).jugadores.get (1).setMano (true);

    } else if (stringCartas.charAt (51) == '*') {
      nParejas.get (1).jugadores.get (1).setMano (true);
    }

    while (separador.hasMoreTokens ()) {
      String nC = separador.nextToken ();
      nCartas.add (new Carta (nC));

    }

    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < nParejas.size (); j++) {

        Pareja pareja = nParejas.get (j);
        Jugador jugador = pareja.jugadores.get (i);

        for (int k = 0; k < 4; k++) {

          jugador.cartas.add (new Carta (nCartas.get (cont + k).getCarta ()));

        }
        cont = cont + 4;
        nParejas.get (j).jugadores.get (i).ordenarCartas ();
      }
    }
  }




  public void escribirNombres (ArrayList <Pareja> nParejas) {
    String lineaFichero1 = "", lineaFichero2 = "Mano: ";

    for (int i = 0; i < nParejas.size (); i++) {
      lineaFichero1 = lineaFichero1 + nParejas.get (i).getNombreP () + ": ";
      lineaFichero1 = lineaFichero1 + nParejas.get (i).jugadores.get (0).getNombreJ () + ", ";
      lineaFichero1 = lineaFichero1 + nParejas.get (i).jugadores.get (1).getNombreJ () + ".\n";

      if (nParejas.get (i).jugadores.get (0).getMano () == true) {
        lineaFichero2 = lineaFichero2 + nParejas.get (i).jugadores.get (0).getNombreJ () + "\n";

      } else if (nParejas.get (i).jugadores.get (1).getMano () == true) {
        lineaFichero2 = lineaFichero2 + nParejas.get (i).jugadores.get (1).getNombreJ () + "\n";

      }
    }

    try {
      BufferedWriter writer = new BufferedWriter (new FileWriter (new File ("./resPartida.txt")));

      writer.write (lineaFichero1);
      writer.write (lineaFichero2);
      writer.close ();

    } catch (Exception e) {
      e.printStackTrace ();
    }
  }




  public void escribirCartas (ArrayList <Pareja> nParejas) {

    String lineaFichero = "";
    int cont = 0;

    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < nParejas.size (); j++) {

        if (nParejas.get (j).jugadores.get (i).getMano () == true) {
          lineaFichero = lineaFichero + "*(";

        } else {
          lineaFichero = lineaFichero + "-(";

        }

        for (int k = 0; k < 4; k++) {

          lineaFichero = lineaFichero + nParejas.get (j).jugadores.get (i).cartas.get (k).getCarta ();

          if (k != 3) {
            lineaFichero = lineaFichero + ", ";
          }

        }
        lineaFichero = lineaFichero + ")";
      }
    }

    lineaFichero = lineaFichero + "\n";

    try {
      BufferedWriter writer = new BufferedWriter (new FileWriter (new File ("./resPartida.txt"), true));

      writer.write (lineaFichero);
      writer.close ();

    } catch (Exception e) {
      e.printStackTrace ();
    }
  }




  public void resuelveGrande (ArrayList <Pareja> nParejas) {

    String lineaFichero = "Grande ";
    int js [] = new int [nParejas.size ()], i1, i2;
    boolean win = false;
    String comp = "124567SCR";
    int i;

    for (i = 0; i < nParejas.size (); i++) {
        js [i] = nParejas.get (i).mejorGrande ();
    }

    i = 3;

    do {

      i1 = comp.indexOf (nParejas.get (0).jugadores.get (js [0]).cartas.get (i).getDenominacion ());
      if (i1 == -1) {
        i1 = 8;

      } else if (i1 == 1) {
        i1 = 0;
      }

      i2 = comp.indexOf (nParejas.get (1).jugadores.get (js [1]).cartas.get (i).getDenominacion ());
      if (i2 == -1) {
        i2 = 8;

      } else if (i2 == 1) {
        i2 = 0;
      }

      i--;

      if (i1 > i2) {
        lineaFichero = lineaFichero + "3 0";
        win = true;
        nParejas.get (0). masVictoria ();
        break;

      } else if (i2 > i1) {
        lineaFichero = lineaFichero + "0 3";
        win = true;
        nParejas.get (1). masVictoria ();
        break;
      }
    } while (i >= 0);

    if (win == false) {
      lineaFichero = lineaFichero + "1 1";
      nParejas.get (0). masEmpate ();
      nParejas.get (1). masEmpate ();
    }

    try {
      BufferedWriter writer = new BufferedWriter (new FileWriter (new File ("./resPartida.txt"), true));

      writer.write (lineaFichero);
      writer.close ();

    } catch (Exception e) {
      e.printStackTrace ();
    }
  }




  public void resuelveChica (ArrayList <Pareja> nParejas) {

    String lineaFichero = " Chica ";
    int js [] = new int [nParejas.size ()], i1, i2;
    boolean win = false;
    String comp = "124567SCR";

    for (int i = 0; i < nParejas.size (); i++) {
        js [i] = nParejas.get (i).mejorChica ();
    }

    for (int i = 0; i < 4; i++) {

      i1 = comp.indexOf (nParejas.get (0).jugadores.get (js [0]).cartas.get (i).getDenominacion ());
      if (i1 == -1) {
        i1 = 8;

      } else if (i1 == 1) {
        i1 = 0;
      }

      i2 = comp.indexOf (nParejas.get (1).jugadores.get (js [1]).cartas.get (i).getDenominacion ());
      if (i2 == -1) {
        i2 = 8;

      } else if (i2 == 1) {
        i2 = 0;
      }

      if (i1 < i2) {
        lineaFichero = lineaFichero + "3 0";
        win = true;
        nParejas.get (0). masVictoria ();
        break;

      } else if (i1 > i2) {
        lineaFichero = lineaFichero + "0 3";
        win = true;
        nParejas.get (1). masVictoria ();
        break;
      }
    }

    if (win == false) {
      lineaFichero = lineaFichero + "1 1";
      nParejas.get (0). masEmpate ();
      nParejas.get (1). masEmpate ();
    }



    try {
      BufferedWriter writer = new BufferedWriter (new FileWriter (new File ("./resPartida.txt"), true));

      writer.write (lineaFichero);
      writer.close ();

    } catch (Exception e) {
      e.printStackTrace ();
    }
  }




  public void setGanador (ArrayList <Pareja> nParejas) {

    String lineaFichero = " - ";
    int i1 = nParejas.get (0).getNPiedras ();
    int i2 = nParejas.get (1).getNPiedras ();

    lineaFichero = lineaFichero + i1 + " " + i2 + "\n";

    if (i1 > i2) {
      lineaFichero = lineaFichero + "Gana: " + nParejas.get (0).getNombreP () + ".";

    } else if (i1 < i2) {
      lineaFichero = lineaFichero + "Gana: " + nParejas.get (1).getNombreP () + ".";

    } else {
      lineaFichero = lineaFichero + "Las dos parejas han empatado.";
    }

    try {
      BufferedWriter writer = new BufferedWriter (new FileWriter (new File ("./resPartida.txt"), true));

      writer.write (lineaFichero);
      writer.close ();

    } catch (Exception e) {
      e.printStackTrace ();
    }
  }
}
