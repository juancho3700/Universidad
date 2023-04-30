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

  public ArrayList <Jugador> sacarJugadores (){
    ArrayList <Jugador> nJugadores = new ArrayList <Jugador> ();

    nJugadores.add (new Jugador ("Anselmo"));
    nJugadores.add (new Jugador ("Tania"));
    nJugadores.add (new Jugador ("Anxo"));
    nJugadores.add (new Jugador ("Axel"));

    return nJugadores;
  }

  public ArrayList <Pareja> sacarParejas (ArrayList <Jugador> nJugadores){
    ArrayList <Pareja> nParejas = new ArrayList <Pareja> ();

    nParejas.add (new Pareja ("Los Veteranos", nJugadores.get(0).getIdJ(), nJugadores.get(1).getIdJ()));
    nParejas.add (new Pareja ("Los Novatos", nJugadores.get(2).getIdJ(), nJugadores.get(3).getIdJ()));

    return nParejas;
  }

  public String leerArchivo (){
    String linea;
    String stringCartas = "\0";
    FileReader fr = null;

    try {
      fr = new FileReader ("jugadas.txt");
      BufferedReader br = new BufferedReader (fr);

      linea = br.readLine ();
      stringCartas = linea;

      br.close ();
    } catch (FileNotFoundException e1){
      e1.printStackTrace ();

    } catch (Exception e2){
      System.out.println (e2.getMessage ());

    } finally {
      try {
        if (fr != null){
          fr.close ();
        }
      } catch (Exception e3){
        System.out.println ("Error: fallo al cerrar el fichero");
        System.out.println(e3.getMessage ());
      }
    }

    return stringCartas;
  }

  public ArrayList <Carta> sacarCartas (ArrayList <Jugador> nJugadores, String stringCartas){
    ArrayList <Carta> nCartas = new ArrayList <Carta> ();
    char pM1 = '0', pM2 = '0', pM3 = '0', pM4 = '0';
    char comp = '*';

    StringTokenizer separador = new StringTokenizer (stringCartas, "- (),*");

    pM1 = stringCartas.charAt(0);
    pM2 = stringCartas.charAt(17);
    pM3 = stringCartas.charAt(34);
    pM4 = stringCartas.charAt(51);

    if (pM1 == comp){
      nJugadores.get(0).setMano (true);

    } else if (pM2 == comp){
      nJugadores.get(1).setMano (true);

    } else if (pM3 == comp){
      nJugadores.get(2).setMano (true);


    } else if (pM4 == comp){
      nJugadores.get(3).setMano (true);
    }

    while (separador.hasMoreTokens ()){
      String nC = separador.nextToken ();
      nCartas.add(new Carta (nC));
    }

    return nCartas;
  }

  public ArrayList <Carta> ordenarCartas (ArrayList <Carta> nCartas){

    ArrayList <Carta> cartas [] = new ArrayList [4];

    for(int i = 0; i < cartas.length; i++){
      cartas[i] = new ArrayList <Carta> ();
    }

    for (int i = 0; i < 4; i++){
      for (int j = 0; j < (nCartas.size ()/4); j++){
        cartas[i].add (new Carta (nCartas.get(j).getCarta()));
      }
      Collections.sort (cartas[i], new Ordenar());
    }

    nCartas.clear ();

    for (int i = 0; i < 4; i++){
      for (int j = 0; j < (nCartas.size ()/4); j++){
        nCartas.add (new Carta (cartas[i].get(j).getCarta()));
      }
    }

    return nCartas;
  }

  public void setGanador (ArrayList <Carta> nCartas, ArrayList <Jugador> nJugadores, ArrayList <Pareja> nParejas, String lineaFichero4){

    int puntos[] = new int [6];

    puntos[0] = nCartas.get(0).getPuntos() + nCartas.get(1).getPuntos() + nCartas.get(2).getPuntos() + nCartas.get(3).getPuntos();
    puntos[1] = nCartas.get(9).getPuntos() + nCartas.get(9).getPuntos() + nCartas.get(10).getPuntos() + nCartas.get(11).getPuntos();
    puntos[2] = nCartas.get(4).getPuntos() + nCartas.get(5).getPuntos() + nCartas.get(6).getPuntos() + nCartas.get(7).getPuntos();
    puntos[3] = nCartas.get(12).getPuntos() + nCartas.get(13).getPuntos() + nCartas.get(14).getPuntos() + nCartas.get(15).getPuntos();

    puntos[4] = puntos[0] + puntos[1];
    puntos[5] = puntos[2] + puntos[3];

    try {
      BufferedWriter writer = new BufferedWriter(new FileWriter( new File ("./resPartida.txt")));

      String lineaFichero1 = null, lineaFichero2 = null, lineaFichero3 = null, lineaFichero5, lineaFichero6 = null;

      lineaFichero1 = (nParejas.get(0).getNombreP() + ": " + nJugadores.get(0).getNombreJ() + " y " + nJugadores.get(1).getNombreJ() + "\n");
      lineaFichero2 = (nParejas.get(1).getNombreP() + ": " + nJugadores.get(2).getNombreJ() + " y " + nJugadores.get(3).getNombreJ() + "\n");

      if (nJugadores.get(0).getMano() == true){
        lineaFichero3 = ("Mano: " + nJugadores.get(0).getNombreJ() + "\n");


      } else if (nJugadores.get(1).getMano() == true){
        lineaFichero3 = ("Mano: " + nJugadores.get(2).getNombreJ() + "\n");


      } else if (nJugadores.get(2).getMano() == true){
        lineaFichero3 = ("Mano: " + nJugadores.get(1).getNombreJ() + "\n");


      } else if (nJugadores.get(3).getMano() == true){
        lineaFichero3 = ("Mano: " + nJugadores.get(3).getNombreJ() + "\n");

      }

      lineaFichero5 = (puntos [4] + " " + puntos [5] + "\n");

      if (puntos[4] > puntos[5]) {
        	lineaFichero6 = ("Gana: " + nParejas.get(0).getNombreP() + "\n");

      } else if (puntos[4] < puntos[5]) {
        	lineaFichero6 = ("Gana: " + nParejas.get(1).getNombreP() + "\n");

      } else {
        	if (nJugadores.get(0).getMano() == true || nJugadores.get(1).getMano() == true){
          		lineaFichero6 = ("Gana: " + nParejas.get(0).getNombreP() + "\n");

        	} else if (nJugadores.get(2).getMano() == true || nJugadores.get(3).getMano() == true){
        	  	lineaFichero6 = ("Gana: " + nParejas.get(1).getNombreP() + "\n");
        	}
      }

 	    writer.write (lineaFichero1);
 	    writer.write (lineaFichero2);
 	    writer.write (lineaFichero3);
 	    writer.write (lineaFichero4 + "\n");
      writer.write (lineaFichero5);
      writer.write (lineaFichero6);

 	    writer.close ();

    } catch (Exception e) {
      e.printStackTrace ();
    }
  }
}
