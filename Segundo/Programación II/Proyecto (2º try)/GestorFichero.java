import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.File;

/**
 * Clase que implementa la gestion de entrada y salida de texto, tanto a fichero como por pantalla
 */

public class GestorFichero {


  /**
   * Metodo que escribe la linea dada en el fichero proporcionado
   * @param lineaFichero Linea que se quiere escribir
   * @param archivo Nombre del archivo en el que se va a escribir (en caso de null se escribira por pantalla)
   * @param sobreescribir Si es false se sobreescribe el fichero proporcionado, si es true no
   * @return true en caso de que no haya error en la escritura y false en caso de que si lo haya
   */

  public static boolean escribirFichero (String lineaFichero, String archivo, boolean sobreescribir) {

    if (archivo == null) {
        System.out.print (lineaFichero);
        return true;

    } else {

      String nArchivo = "./" + archivo;

      try {

        BufferedWriter writer = new BufferedWriter (new FileWriter (new File (nArchivo), sobreescribir));
      
        writer.write (lineaFichero);
        writer.close ();
        return false;
      
      } catch (Exception e) {
        System.out.print ("No se puede escribir el fichero (" + e + ")\n\n");
        return true;
            
      }
    }
  }


  /**
   * Metodo que lee en un fichero la linea deseada
   * @param archivo Archivo a leer
   * @param nLineas Linea que se quiere leer
   * @return ret [0] es la linea leida y ret [1] el error: devolvera "ok" en caso de que no haya habido error y otros mensajes dependiendo del error que haya sucedido
   */

  public static String [] leerLineaFichero (String archivo, int nLineas) {
    String linea = null, err = null;

    try {

      FileReader fr = new FileReader (archivo);
      BufferedReader br = new BufferedReader (fr);

      for (int i = 0; i <= nLineas; i++) {

          linea = br.readLine ();
      
     }

      err = "ok";
      br.close ();

    } catch (FileNotFoundException e1) {

      System.out.print ("Error en la lectura del fichero (" + e1 + ")\n\n");
      err = "noEncontrado";

    } catch (Exception e2) {

      System.out.print ("Error en la lectura del fichero (" + e2 + ")\n\n");
      err = "WillyHaMuerto";

    }

    String ret [] = {linea, err};
    return ret;
  }
}