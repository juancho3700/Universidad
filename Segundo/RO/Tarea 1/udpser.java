import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;
import java.nio.ByteBuffer;

public class udpser {

    public static void main (String[] args) {
        
        int acul = 0, i, recibido = -1;
        byte [] buffer = new byte [4];
        DatagramSocket socket = null;
        DatagramPacket paquete = new DatagramPacket (buffer, buffer.length);

        if (args.length != 1) {
            
            System.out.println ("Numero de argumentos de invocacion incorrecto\n" +
                                 "Sintaxis correcta: java udpser PuertoServidor\n" +
                                 "Cerrando servidor ... \n\n");
            return;
        }

        try {

            socket = new DatagramSocket (Integer.parseInt (args [0]));

            while (true) {
    
                System.out.println ("Esperando a la llegada de paquetes");

                for (i = 0; recibido != 0; i++) {

                    socket.receive (paquete);
                    recibido = ByteBuffer.wrap (paquete.getData ()).getInt ();

                    acul += recibido;
                    System.out.println ("El acumulador ahora mismo vale " + acul);
                }

                System.out.println ("En total se han recibido " + i + " paquetes. Procesando ...");

                buffer = ByteBuffer.allocate (4).putInt (acul).array ();
                paquete = new DatagramPacket (buffer, buffer.length, paquete.getAddress (), paquete.getPort ());
                socket.send (paquete);
                System.out.println ("Paquete enviado\n");
                recibido --;
            }

        } catch (SocketException e) {

            System.out.println ("Error al crear el socket. Cerrando servidor ...\n\n");
            return;

        } catch (Exception e) {

            e.printStackTrace ();
        }

        socket.close ();
    }
}