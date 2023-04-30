import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketTimeoutException;
import java.nio.ByteBuffer;

/* ARGUMENTOS DE ENTRADA:
    - Fichero de entrada
    - IP destino
    - Puerto destino
    - IP del emulador de red
    - Puerto del emulador de red
*/

public class ro2021send {

    public static void main (String[] args) {
        
        if (args.length != 5) {
            System.out.println ("Sintaxis de invocacion incorrecta\n    java ro2021send in_file dest_IP dest_port emul_IP emul_port\n");
            return;

        }

        byte cadenaPaquete [] = new byte [1472];
        byte cadenaIn [] = new byte [7];
        boolean ackOut = false, ackIn;
        int nBytes = 1465, timeout = 450;


        try {

            DatagramSocket socket = new DatagramSocket ();
            DatagramPacket paqueteOut = new DatagramPacket (cadenaPaquete, cadenaPaquete.length, InetAddress.getByName (args [1]), Integer.parseInt(args [2]));
            DatagramPacket paqueteIn = new DatagramPacket (cadenaIn, cadenaIn.length);
            byte ipDestino [] = InetAddress.getByName (args [1]).getAddress ();
            byte puertoDestino [] = ByteBuffer.allocate (2).putShort (Short.parseShort (args [2])).array ();
            BufferedInputStream input = new BufferedInputStream (new FileInputStream ("./" + args [0]));

            for (int cont = 0; nBytes == 1465; cont += 1465) {

                byte leido [] = new byte [1465];
                nBytes = input.read (leido, cont, leido.length);

                System.arraycopy (ipDestino, 0, cadenaPaquete, 0, ipDestino.length);
                System.arraycopy (puertoDestino, 0, cadenaPaquete, ipDestino.length, puertoDestino.length);
                cadenaPaquete [ipDestino.length + puertoDestino.length] = (byte) (ackOut?1:0);
                System.arraycopy (leido, 0, cadenaPaquete, ipDestino.length + puertoDestino.length + 1, leido.length);
                
                paqueteOut.setData (cadenaPaquete);
                // Hacer aquí los cálculos para el tiempo del timeout
                socket.setSoTimeout(timeout);

                do {

                    /*
                    Aqui envias el paquete, lo recibes y si el ack que se recibe es diferente
                    al que se tiene, se sale del do while; en otro caso, se sigue enviando hasta
                    que el caso anterior ocurra
                    */

                    try {
                        socket.send (paqueteOut);
                        socket.receive (paqueteIn);

                        ackIn = paqueteIn.getData () [7] != 0;

                    } catch (SocketTimeoutException ex) {
                        ackIn = ackOut;
                    }

                    ackIn = paqueteIn.getData () [7] != 0;


                } while (ackIn == ackOut); //Mientras no se pida el siguiente paquete se reenvia

                ackOut = !ackOut;
            }

            input.close ();
            socket.close ();
        
        } catch (Exception e) {
            e.printStackTrace ();

        }
    }
}