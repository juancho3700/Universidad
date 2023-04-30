import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;
import java.util.Scanner;

public class udpcli {

    public static void main (String [] args) throws UnknownHostException {

        Scanner scanner = new Scanner (System.in);
        int entrada = -1;
        byte [] buffer = new byte [4];
        DatagramSocket socket;
        DatagramPacket paquete;
        InetAddress direccionServer = InetAddress.getByName (args [0]);
        
        if (args.length != 2) {

            System.out.println ("Numero de argumentos de invocacion incorrecto" +
                                "Sintaxis correcta: java udpcli IPservidor PuertoServidor" +
                                "Cerrando programa ...\n\n");
            scanner.close ();
            return;
        }

        System.out.println ("Ponga los numeros que quiera enviar de 1 en 1\n" + 
                            "En cuanto se envie un 0 se considerara terminada la cadena\n");

        try {
            
            socket = new DatagramSocket ();
            paquete = new DatagramPacket (buffer, buffer.length, direccionServer, Integer.parseInt (args [1]));
            
            for (int i = 0; entrada != 0; i++) {
                
                System.out.print ("Entrada numero " + i + ": ");
                entrada = scanner.nextInt ();
                
                buffer = ByteBuffer.allocate (4).putInt (entrada).array ();
                paquete.setData (buffer);

                socket.send (paquete);
            }

            paquete = new DatagramPacket (buffer, buffer.length);
            socket.receive (paquete);

            int acul = ByteBuffer.wrap (paquete.getData ()).getInt ();
            System.out.println ("El acumulador del servidor ahora mismo vale " + acul + "\n");

            socket.close ();
            scanner.close ();

        } catch (SocketException e) {

            System.out.println ("Error al crear el socket. Cerrando programa ...\n\n");
            scanner.close ();
            return;

        } catch (Exception e) {

            System.out.println("Cagamos");
            e.printStackTrace ();
        }
    }
}