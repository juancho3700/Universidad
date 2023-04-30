import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ConnectException;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Scanner;

public class tcp3cli {

    private static int tiempoConexion = 15000;
    private static Scanner scanner = new Scanner (System.in);
    public static void main (String[] args) throws Exception {
        
        int puerto;
        InetAddress ip;

        if (args.length != 2 && args.length != 3) {

            System.out.println ("Sintaxis de invocacion incorrecta\nInvocacion: java tcp2cli IP puerto\nSi se quiere utilizar el modo UDP agregar -u al final\n");
            return;

        } else if (args.length == 3 && !(args [2].toLowerCase ()).equals ("-u")) {

            System.out.println ("Sintaxis de invocacion incorrecta\nInvocacion: java tcp2cli IP puerto\nSi se quiere utilizar el modo UDP agregar -u al final\n");
            return;
        }

        ip = InetAddress.getByName (args [0]);
        puerto = Integer.parseInt (args [1]);

        if (args.length == 2) {

            clienteTCP (ip, puerto);

        } else {

            clienteUDP (ip, puerto);
        }
    }
    
    
    static void clienteUDP (InetAddress ip, int puerto) {
        
        
    }
    
    
    
    static void clienteTCP (InetAddress ip, int puerto) throws IOException {

        int acumulador;
        String entrada, datos [];

        Socket socket;
        InetSocketAddress direccion;
        DataInputStream dataIn;
        DataOutputStream dataOut;

        socket = new Socket ();
    
        try {
    
            System.out.println ("Conectando con el servidor ...\n");
    
            direccion = new InetSocketAddress (ip, puerto);
            socket.connect (direccion, tiempoConexion);
    
        } catch (ConnectException e) {
    
            System.out.println ("Tiempo de conexion finalizado. Cerrando programa ...\n");
            socket.close ();
            return;
        }
    
        System.out.println ("Cliente conectado. Bienvenido\n");
    
    
        while (true) {
    
            System.out.println ("Introduce los numeros a enviar al servidor separados por espacios y terminados en 0: ");
            entrada = scanner.nextLine ();
    
            datos = entrada.split (" ");
    
            if (datos [0].equals ("0")) {
    
                System.out.println ("Detectado 0 al inicio de la cadena. Cerrando programa ...\n");
                socket.close ();
                return;
    
            } else if (!datos [datos.length - 1].equals ("0")) {
    
                System.out.println ("Error en la sintaxis de la cadena. Vuelva a intentarlo\n");
    
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