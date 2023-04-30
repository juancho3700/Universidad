import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.ConnectException;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.util.Scanner;

public class tcp2cli {

    private static int tiempoConexion = 15000; // Milisegundos
    private static Scanner scanner = new Scanner (System.in);
    public static void main (String[] args) throws Exception {

        int puerto, acumulador;
        String entrada, datos [];
        Socket socket;
        InetAddress ip;
        SocketAddress direccion;
        DataOutputStream dataOut;
        DataInputStream dataIn;
        
        if (args.length != 2) {

            System.out.println ("Sintaxis incorrecta\nInvocacion: java tcp2cli IP puerto\n");
            return;
        }
        
        ip = InetAddress.getByName (args [0]);
        puerto = Integer.parseInt (args [1]);
        socket  = new Socket ();

        try {
            
            System.out.println ("Conectando con el servidor ...\n");
            
            direccion = new InetSocketAddress (ip, puerto);
            socket.connect (direccion, tiempoConexion);

        } catch (ConnectException e) {

            System.out.println ("Tiempo de conexion finalizado. Cerrando cliente ...\n");
            socket.close ();
            return;
        }

        System.out.println ("Cliente conectado. Bienvenido\n");

        while (true) {

            System.out.println ("Introduce los numeros a enviar al servidor separados por espacios y terminando en 0:");
            entrada = scanner.nextLine ();

            datos = entrada.split (" ");

            if (datos [0] == "0") {

                System.out.println ("Detectado 0 al inicio de la cadena. Cerrando programa ...\n");
                socket.close ();
                return;

            } else if (!datos [datos.length - 1].equals ("0")) {

                System.out.println ("Error en la sintaxis de la cadena. Vuelva a intentarlo ...\n");

            } else if ((datos [0].trim ()).equals ("0")) {
            
                System.out.println ("Cerrando programa ...\n");
                socket.close ();
                return;
            
            } else {

                dataOut = new DataOutputStream (socket.getOutputStream ());
                dataOut.writeUTF (entrada);

                dataIn = new DataInputStream (socket.getInputStream ());
                acumulador = dataIn.readInt ();

                System.out.println ("El acumulador del servidor vale " + acumulador + "\n");
            }
        }
    }
}