import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.File;

public class GestorFichero {

  public static boolean escribirFichero (String lineaFichero, String archivo, boolean sobreescribir) {

    String nArchivo = "./" + archivo;

    try {
      BufferedWriter writer = new BufferedWriter (new FileWriter (new File (nArchivo), sobreescribir));

      writer.write (lineaFichero);
      writer.close ();
      return true;

    } catch (Exception e) {
      return true;
    }
  }


  public static String leerLineaFichero (String archivo, int nLineas) {
    String ret = null;

    try {
      FileReader fr = new FileReader (archivo);
      BufferedReader br = new BufferedReader (fr);

      for (int i = 0; i <= nLineas; i++) {
          ret = br.readLine ();
      }

      ret.trim ();
      br.close ();

    } catch (FileNotFoundException e1) {
      e1.printStackTrace ();

    } catch (Exception e2) {
      System.out.println (e2.getMessage ());

    }

    return ret;
  }
}
