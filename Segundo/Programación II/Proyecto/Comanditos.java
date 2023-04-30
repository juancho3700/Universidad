import java.util.ArrayList;
import java.util.Collections;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.File;
import java.util.StringTokenizer;

public class Comanditos {
  private String opcComandos [] = {"#", "NewPlayer", "DeletePlayer", "NewCouple", "DeleteCouple", "DumpPlayers", "ResetPlayers", "LoadPlayers", "GeneralRandomDelivery", "PlayGame", "PlayHand", "ResolvePares", "ResolveJuego", "ResolveGrande", "ResolveChica"};
  private ArrayList <Jugador> jugadoresGuardados = new ArrayList <Jugador> ();
  private ArrayList <Pareja> parejas = new ArrayList <Pareja> ();
  private String ficheroSalida = null;
  private boolean salidaPorFichero = true;



  public Comanditos (String fichero, boolean existeFichero) {
    ficheroSalida = fichero;
    salidaPorFichero = existeFichero;
  }



  public void detectarComando (String comando, String subcomando) {
    int sel = 0;

    for (int i = 0; i < opcComandos.length; i++){

      if (comando == opcComandos [i]) {
        if (i == 0) {
          break;
        }

        sel = i;
        break;
      }
    }

    switch (sel) {
      case 1:
        newPlayer (subcomando);
        break;

      case 2:
        deletePlayer (subcomando);
        break;

      case 3:
        newCouple (subcomando);
        break;

      case 4:
        deleteCouple (subcomando);
        break;

      case 5:
        dumpPlayers (subcomando);
        break;

      case 6:
        resetPlayers ();
        break;

      case 7:
        loadPlayers (subcomando);
        break;

      case 8:
        generateRandomDelivery (subcomando);
        break;

      case 9:
        playGame (subcomando);
        break;

      case 10:
        playHand (subcomando);
        break;

      case 11:
        resolvePares (subcomando);
        break;

      case 12:
        resolveJuego (subcomando);
        break;

      case 13:
        resolveGrande (subcomando);
        break;

      case 14:
        resolveChica (subcomando);
        break;
    }
  }




  public void newPlayer (String subcomando) {
    String params [] = subcomando.split (" ", 2);

    for (int i = 0; i < jugadoresGuardados.size (); i++) {
      if (jugadoresGuardados.get (i).getIdJ () == Integer.parseInt (params [0])) {
        //Sacar el error de que ya hay un jugador con esa id
        return;
      }
    }

    jugadoresGuardados.add (new Jugador (Integer.parseInt (params [0]), params [1]));

  }



  public void deletePlayer (String subcomando) {
    int id = Integer.parseInt (subcomando);

    for (int i = 0; i < jugadoresGuardados.size (); i++) {
      if (jugadoresGuardados.get (i).getIdJ () == id) {
        jugadoresGuardados.remove (i);
        return;
      }
    }
    //Sacar el error de que no hay ningun jugador con esa id para eliminar
  }



  public void newCouple (String subcomando) {
    String params [] = subcomando.split (" ", 4);
    int index [] = {-1, -1};

    for (int i = 0; i < parejas.size (); i++){
      if (parejas.get (i).getIdP () == Integer.parseInt (params [0])) {
        //Sacar el error de que hay otra pareja con ese id
        return;
      }
    }

    for (int i = 0; i < jugadoresGuardados.size (); i++) {

      if (index [0] == -1 && jugadoresGuardados.get (i).getIdJ () == Integer.parseInt (params [1])) {
        index [0] = i;

      } else if (index [1] == -1 && jugadoresGuardados.get (i).getIdJ () == Integer.parseInt (params [2])) {
        index [1] = i;
      }
    }

    if (index [0] != -1 && index [1] != -1) {
      parejas.add (new Pareja (params [3], Integer.parseInt(params [0]), jugadoresGuardados.get (index [0]), jugadoresGuardados.get (index [1])));
      jugadoresGuardados.remove (index [0]);
      jugadoresGuardados.remove (index [1]);

    } else {
      // Sacar el error de que no existe jugador/es con los ids mandados
    }
  }



  public void deleteCouple (String subcomando) {
    int id = Integer.parseInt (subcomando);

    for (int i = 0; i < parejas.size (); i++) {
      if (parejas.get (i).getIdP () == id) {
        parejas.remove (i);
        return;
      }
    }
    //Sacar el error de que no hay ninguna pareja con esa id para eliminar

  }



  public void dumpPlayers (String subcomando) {
    String lineaFichero = "";
    String fichero = "./" + subcomando;

    for (int i = 0; i < parejas.size (); i++) {
      lineaFichero += "P " + parejas.get (i).getIdP () + " ";
      lineaFichero += parejas.get (i).jugadores.get (1).getIdJ () + " " + parejas.get (i).jugadores.get (0).getIdJ () + " " + parejas.get (i).getNombreP () + "\n";

      lineaFichero += "J " + parejas.get (i).jugadores.get (0).getIdJ () + " " + parejas.get (i).jugadores.get (0).getNombreJ () + "\n";
      lineaFichero += "J " + parejas.get (i).jugadores.get (1).getIdJ () + " " + parejas.get (i).jugadores.get (1).getNombreJ () + "\n";

    }

    for (int i = 0; i < jugadoresGuardados.size (); i++) {
      lineaFichero += "J " + jugadoresGuardados.get (0).getIdJ () + " " + parejas.get (i).jugadores.get (0).getNombreJ () + "\n";
      lineaFichero += "J " + jugadoresGuardados.get (1).getIdJ () + " " + parejas.get (i).jugadores.get (1).getNombreJ () + "\n";

    }

    boolean error = GestorFichero.escribirFichero (lineaFichero, fichero, false);
    if (error == true) {
      // Sacar el error de que no se puede escribir en el fichero
    }
  }



  public void resetPlayers () {
    parejas.clear ();
    jugadoresGuardados.clear ();

    System.out.println ("ResetPlayers: OK.");
  }



  public void loadPlayers (String subcomando) {
    String siguienteLinea = "";
    String fichero = "./" + subcomando;
    int index [] = {-1, -1};
    int cont = 0;

    while (siguienteLinea != null) {

      siguienteLinea = GestorFichero.leerLineaFichero (fichero, cont);

      if (siguienteLinea.charAt (0) == 'J') {
        String params [] = siguienteLinea.split (" ", 3);
        jugadoresGuardados.add (new Jugador (Integer.parseInt(params [1]), params [2]));

      } else if (siguienteLinea.charAt (0) == 'P') {
        String params [] = siguienteLinea.split (" ", 5);

        for (int i = 0; i < jugadoresGuardados.size (); i++) {

          if (index [0] == -1 && jugadoresGuardados.get (i).getIdJ () == Integer.parseInt (params [1])) {
            index [0] = i;

          } else if (index [1] == -1 && jugadoresGuardados.get (i).getIdJ () == Integer.parseInt (params [2])) {
            index [1] = i;
          }
        }

        if (index [0] != -1 && index [1] != -1) {
          int id1 = Integer.parseInt(params [0]);

          parejas.add (new Pareja (params [3], id1, jugadoresGuardados.get (index [0]), jugadoresGuardados.get (index [1])));
          jugadoresGuardados.remove (index [0]);
          jugadoresGuardados.remove (index [1]);

        }
      }
      cont ++;
    }
  }



  public void generateRandomDelivery (String subcomando) {

    Baraja baraja = new Baraja ();
    String lineaFichero = "";
    String params [] = subcomando.split (" ", 3);
    ArrayList <Carta> nCartas = new ArrayList <Carta> ();

    for (int i = 0; i <Integer.parseInt (params [0]); i++) {
      nCartas = baraja.sacarCarta ();

      for (int j = 0; j < 4; j++) {
        lineaFichero += "-(";

        for (int k = 0; k < 4; k++) {
          lineaFichero += nCartas.get (4 * j + k).getCarta ();

          if (k != 3) {
            lineaFichero += ", ";
          }
        }

        lineaFichero += ")";
      }
      lineaFichero += "\n";
    }

    StringBuilder nLinea = new StringBuilder (lineaFichero);

    switch (params [1]) {
      case "1":
        nLinea.setCharAt (0, '*');
        break;

      case "2":
        nLinea.setCharAt (17, '*');
        break;

      case "3":
        nLinea.setCharAt (34, '*');
        break;

      case "4":
        nLinea.setCharAt (51, '*');
        break;
    }

    lineaFichero = nLinea.toString ();

    boolean error = GestorFichero.escribirFichero (lineaFichero, params [2], false);
    if (error == true) {
      // Sacar el error de que no se puede escribir en el fichero
    }
  }



  public void playGame (String subcomando) {
    String params[] = subcomando.split (" ");
    ArrayList <Pareja> nParejas = new ArrayList <Pareja> ();
    int nLineas = 0, cont = 0;
    String linea = "";
    ArrayList <Carta> nCartas = new ArrayList <Carta> ();
    String lineaFichero = "";
    boolean error = false, nSobreescribir = false;

    if (parejas.size () > 1) {
      nParejas.add (parejas.get (0));
      nParejas.add (parejas.get (1));

    } else if (parejas.size () == 1) {
      nParejas.add (parejas.get (0));
      ArrayList <Pareja> pAux = FuncionesVarias.crearParejaDefecto (1);
      nParejas.add (pAux.get (0));

    } else {
      ArrayList <Pareja> pAux = FuncionesVarias.crearParejaDefecto (2);
      nParejas.add (pAux.get (0));
      nParejas.add (pAux.get (1));

    }

    linea = GestorFichero.leerLineaFichero (params[0], cont);

    if (linea == null) {
      // Sacar el error de que no se puede leer el fichero
      return;
    }

    FuncionesVarias.setPrimeraMano (linea, parejas);

    while (linea != null && parejas.get (0).getPiedras () < 40 && parejas.get (1).getPiedras () < 40) {

      FuncionesVarias.resetPiedrasParejas (parejas);

      lineaFichero = linea + "\n";
      nCartas = FuncionesVarias.separarCartas (linea, parejas);
      FuncionesVarias.meterCartas (nCartas, parejas);

      int piedrasGrande[] = Lances.resuelveGrande (parejas);
      lineaFichero += "Grande " + piedrasGrande[0] + " " + piedrasGrande[1] + " ";
      FuncionesVarias.resetPiedrasJugadores (parejas);

      int piedrasChica[] = Lances.resuelveChica (parejas);
      lineaFichero += "Chica " + piedrasChica[0] + " " + piedrasChica[1] + " ";
      FuncionesVarias.resetPiedrasJugadores (parejas);

      int piedrasPares[] = Lances.resuelvePares (parejas);
      lineaFichero += "Pares " + piedrasPares[0] + " " + piedrasPares[1] + " ";
      FuncionesVarias.resetPiedrasJugadores (parejas);

      int piedrasJuego[] = Lances.resuelveJuego (parejas);
      lineaFichero += "Juego " + piedrasJuego[0] + " " + piedrasJuego[1] + " ";
      FuncionesVarias.resetPiedrasJugadores (parejas);

      for (int i =0; i < parejas.size (); i++) {
        int nP = piedrasGrande[i] + piedrasChica[i] + piedrasPares[i] + piedrasJuego[i];
        lineaFichero += nP + " ";
      }

      lineaFichero += "\n";

      error = GestorFichero.escribirFichero (lineaFichero, params[1], nSobreescribir);
      if (error == true) {
        //Sacar el error de que no se puede escribir en el fichero
        error = true;
        break;
      }
      nSobreescribir = true;
      linea = GestorFichero.leerLineaFichero (params[0], nLineas);
      nLineas++;
      FuncionesVarias.resetPiedrasParejas (parejas);
    }

    lineaFichero = "PlayGame " + subcomando + ": ";

    if (parejas.get (0).getPiedras () < 40 && parejas.get (1).getPiedras () < 40 || error == true) {
      lineaFichero += "FAIL.\n";

    } else {
      lineaFichero += "OK.\n";
    }
  }



  public void playHand (String subcomando) {
    String lineaFichero = "PlayHand " + subcomando + ": ";
    ArrayList <Carta> nCartas = new ArrayList <Carta> ();

    FuncionesVarias.resetPiedrasParejas (parejas);

    nCartas = FuncionesVarias.separarCartas (subcomando, parejas);
    FuncionesVarias.meterCartas (nCartas, parejas);

    int piedrasGrande[] = Lances.resuelveGrande (parejas);
    lineaFichero += "Grande " + piedrasGrande[0] + " " + piedrasGrande[1] + " ";
    FuncionesVarias.resetPiedrasJugadores (parejas);

    int piedrasChica[] = Lances.resuelveChica (parejas);
    lineaFichero += "Chica " + piedrasChica[0] + " " + piedrasChica[1] + " ";
    FuncionesVarias.resetPiedrasJugadores (parejas);

    int piedrasPares[] = Lances.resuelvePares (parejas);
    lineaFichero += "Pares " + piedrasPares[0] + " " + piedrasPares[1] + " ";
    FuncionesVarias.resetPiedrasJugadores (parejas);

    int piedrasJuego[] = Lances.resuelveJuego (parejas);
    lineaFichero += "Juego " + piedrasJuego[0] + " " + piedrasJuego[1] + " ";
    FuncionesVarias.resetPiedrasJugadores (parejas);

    for (int i =0; i < parejas.size (); i++) {
      int nP = piedrasGrande[i] + piedrasChica[i] + piedrasPares[i] + piedrasJuego[i];
      lineaFichero += nP + " ";
    }

    System.out.println (lineaFichero);
    FuncionesVarias.resetPiedrasParejas (parejas);
  }



  public void resolvePares (String subcomando) {
    String lineaFichero = "ResolvePares " + subcomando + ": ";
    int piedrasParejas[] = Lances.resuelvePares (parejas);
    int piedras = 0;

    FuncionesVarias.resuelveGeneral (parejas, lineaFichero, piedrasParejas);
  }



  public void resolveJuego (String subcomando) {
    String lineaFichero = "ResolveJuego " + subcomando + ": ";
    int piedrasJuego[] = Lances.resuelveJuego (parejas);
    int piedras = 0;

    FuncionesVarias.resuelveGeneral (parejas, lineaFichero, piedrasJuego);
  }



  public void resolveGrande (String subcomando) {
    String lineaFichero = "ResolveGrande " + subcomando + ": ";
    int piedrasGrande[] = Lances.resuelveGrande (parejas);
    int piedras = 0;

    FuncionesVarias.resuelveGeneral (parejas, lineaFichero, piedrasGrande);
  }



  public void resolveChica (String subcomando) {
    String lineaFichero = "ResolveGrande " + subcomando + ": ";
    int piedrasChica[] = Lances.resuelveJuego (parejas);
    int piedras = 0;

    FuncionesVarias.resuelveGeneral (parejas, lineaFichero, piedrasChica);
  }
}
