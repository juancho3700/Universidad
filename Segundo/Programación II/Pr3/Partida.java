import java.util.ArrayList;
import java.util.Scanner;
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;

public class Partida {

  public static void main(String[] args) {

    Baraja nBaraja = new Baraja ();
    Scanner keyb = new Scanner (System.in);
    int opcion = 0;
    boolean fin = false, fallo = false;
    String lineaFichero = new String ();

    try {
      BufferedWriter writer = new BufferedWriter (new FileWriter (new File ("./salida.txt")));

      do {
        System.out.println ("1. Crear Baraja");
        System.out.println ("2. Barajar");
        System.out.println ("3. Obtener N cartas");
        System.out.println ("4. Restablecer la baraja");
        System.out.println ("5. Ordenar la baraja");
        System.out.println ("6. Salir\n");

        opcion = keyb.nextInt ();

        switch (opcion) {

          case 1:
            fallo = nBaraja.restablecerBaraja ();

            if (fallo == false){
              lineaFichero = "Crear baraja: Ejecucion OK\n";
              writer.write (lineaFichero);
            }

            break;


          case 2:
            nBaraja.barajar ();

            if (fallo == false){
              lineaFichero = "Barajar: Ejecucion OK\n";
              writer.write (lineaFichero);
            }

            break;


          case 3:
              System.out.print ("Cuantas cartas quieres obtener: ");
              opcion = keyb.nextInt ();

              int nC = 40 - nBaraja.getNumCarta ();

              if (opcion > nC){
                lineaFichero = "Obtener " + opcion + " cartas: No hay suficientes cartas\n";
                writer.write (lineaFichero);
                break;
              }

              fallo = nBaraja.sacarCartas (opcion);

              if (fallo == false){
                lineaFichero = "Sacar " + opcion + " cartas: Ejecucion OK\n";
                writer.write (lineaFichero);
              }

              opcion = 3;
              break;


          case 4:
            fallo = nBaraja.restablecerBaraja ();

            if (fallo == false){
              lineaFichero = "Restablecer la baraja: Ejecucion OK\n";
              writer.write (lineaFichero);
            }

            break;


          case 5:
            fallo = nBaraja.ordenarBaraja ();

            if (fallo == false){
              lineaFichero = "Ordenar la baraja: Ejecucion OK\n";
              writer.write (lineaFichero);
            }

            break;


          case 6:
            fin = true;
            break;


          default:
            System.out.println ("Opcion no valida\n");
            break;
        }

      } while (fin == false);

      System.out.println ("Fin del programa\n");
      writer.close ();

    } catch (Exception e) {
      e.printStackTrace ();
    }
  }
}
