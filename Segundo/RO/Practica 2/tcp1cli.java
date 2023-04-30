import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.math.BigInteger;
import java.net.ConnectException;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.util.Arrays;
import java.util.Scanner;

public class tcp1cli {
    
    private static int timeout = 15000;
    private static Scanner scanner = new Scanner (System.in);

    public static void main (String [] args) throws Exception {

        Socket socket;
        SocketAddress direccion;
        InetAddress ip;
        int puerto, operacion = -1, nBytes = 2;
        long resultado;
        String entrada;
        byte recepcion [] = new byte [10];
        ByteArrayOutputStream envio = new ByteArrayOutputStream ();
        DataInputStream in;
        DataOutputStream out;

        if (args.length != 2) {

            System.out.println ("Número de argumentos incorrecto.\n   Sintaxis correcta: java tcp1ser IP puerto_servidor\n\n");
            return;
        }

        ip = InetAddress.getByName (args [0]);
        puerto = Integer.parseInt (args [1]);
        
        socket = new Socket ();

        try {

            System.out.println ("Conectando al servidor . . .");

            direccion = new InetSocketAddress (ip, puerto);
            socket.connect (direccion, timeout);

        } catch (ConnectException e) {

            System.out.println ("Tiempo de conexión finalizado. Cerrando cliente . . .\n");
            socket.close ();
            return;
        }

        System.out.println ("Cliente conectado. Bienvenido");
        in = new DataInputStream (socket.getInputStream ());
        out = new DataOutputStream (socket.getOutputStream ());

        while (true) {

            envio.reset ();

            System.out.print ("Inserte una operación en notación infija (Ej: 5 + 7, 4!): ");

            entrada = scanner.nextLine ();
            String datos [] = entrada.split (" ");

            if (datos [0].equals ("QUIT") || datos [0].equals ("quit")) {

                System.out.println ("Cerrando cliente ...\n");
                socket.close ();
                return;
            }

            if (datos.length == 1) {

                datos [0] = datos [0].substring (0, datos [0].length() - 1);

                operacion = 6;
                nBytes = 1;

            } else {

                nBytes = 2;

                switch (datos [1]) {

                    case "+":
                    
                        operacion = 1;
                        break;

                    case "-":

                        operacion = 2;
                        break;

                    case "*":

                        operacion = 3;
                        break;

                    case "/":

                        operacion = 4;
                        break;

                    case "%":
                    
                        operacion = 5;
                        break;
                }
            }  
            
            envio.write ((byte) operacion);
            envio.write ((byte) nBytes);
            envio.write (Byte.parseByte (datos [0]));

            if (nBytes == 2) {

                envio.write (Byte.parseByte (datos [2]));
            }

            out.write (envio.toByteArray ());
            System.out.println ("operación enviada. Esperando resultado . . .");

            in.read (recepcion);
            resultado = new BigInteger (Arrays.copyOfRange (recepcion, 2, recepcion.length)).longValue ();

            System.out.println("  -----  " + entrada + " = " + resultado + "  -----  ");
        }
    }
}