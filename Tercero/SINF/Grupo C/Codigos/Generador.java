import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Random;

public class Generador {

    public static void main(String[] args) throws Exception {
        
        BufferedWriter bw = new BufferedWriter (new FileWriter(new File ("EventoFinal.sql")));
        String salida;
        Random random = new Random ();
        int año, mes, dia, hora;

        
        for (int i = 0; i < Integer.parseInt (args [0]); i++) {

            random = new Random ();

            año = random.nextInt (5) + 2022;
            mes = random.nextInt (11) + 1;
            dia = random.nextInt (10) + 10;
            hora = random.nextInt (20);
            
            salida = "call crearEvento (";
            salida += random.nextInt (15000) + ", ";
            salida += (random.nextInt (14) + 1) + ", ";

            salida += "\"" + año + "-" + mes + "-" + dia + " " + hora + ":00:00\", ";
            
            hora += 2;
            salida += "\"" + año + "-" + mes + "-" + dia + " " + hora + ":00:00\", ";

            dia -= 5;
            salida += "\"" + año + "-" + mes + "-" + dia + " " + hora + ":00:00\", ";

            dia += 2;
            salida += "\"" + año + "-" + mes + "-" + dia + " " + hora + ":00:00\", ";

            if (random.nextInt (2) == 0) {

                salida += "\"Abierto\"";

            } else {

                salida += "\"No Disponible\"";
            }

            salida += ");\n";
            bw.write (salida);
        }
    }
}