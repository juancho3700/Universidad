import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

/* ARGUMENTOS DE ENTRADA:
    - Fichero de salida
    - Puerto de escucha
*/

public class ro2021recv {

    public static void main (String[] args) {
        
        if (args.length != 5) {
            System.out.println("Sintaxis de invocacion incorrecta\n    java ro2021recv out_file listen_port\n");

        }

        byte cadenaOut [] = new byte [7], cadenaIn [] = new byte [1472];
        boolean ackOut = false, ackIn = false;
        int nBytes = 1465, cont = 0;

        try {

            DatagramSocket socket = new DatagramSocket (Integer.parseInt (args [1]));
            DatagramPacket paqueteIn = new DatagramPacket (cadenaIn, cadenaIn.length);

            byte ipDestino [] = new byte [4], puertoDestino [] = new byte [2], escribir [] = new byte [1465]; 
            BufferedOutputStream output = new BufferedOutputStream (new FileOutputStream("./" + args [0]));

            /*
            Llegan paquetes. Cuando te llega uno ves si el ack es el que tu quieres, si
            lo es aumentas el ack y envias de vuelta con esa nueva peticion. Si no, envia
            un mensaje con el ack que queria en un principio.

            Con el mensaje lee los bytes que contiene y los escribe en el fichero de
            salida.

            Cuando un mensaje contenga en el paquete de datos menso de 1465 bytes, se
            acaba el bucle de recepcion de mensajes
            */

            do {

                do {
                    socket.receive (paqueteIn);
                    
                    if (cont == 0) {
                        System.arraycopy (cadenaIn, 0, ipDestino, 0, ipDestino.length);
                        System.arraycopy(cadenaIn, ipDestino.length, puertoDestino, 0, puertoDestino.length);
                    
                    }
                    
                    ackIn = cadenaIn [7] != 0;
                    System.arraycopy(cadenaIn, ipDestino.length + puertoDestino.length + 1, escribir, 0, escribir.length);

                    if (ackIn == ackOut) {
                        output.write (escribir, cont, escribir.length);
                        cont += escribir.length;

                    }

                    ackIn = !ackIn;

                    System.arraycopy (ipDestino, 0, cadenaOut, 0, ipDestino.length);
                    System.arraycopy (puertoDestino, 0, cadenaOut, ipDestino.length, puertoDestino.length);
                    cadenaOut [ipDestino.length + puertoDestino.length] = (byte) (ackOut?1:0);

                    DatagramPacket paqueteOut = new DatagramPacket (cadenaOut, cadenaOut.length, paqueteIn.getAddress (), paqueteIn.getPort ());
                    socket.send (paqueteOut);

                } while (ackIn == ackOut);

                ackOut = !ackOut;
            } while (nBytes != 1465);

            output.close ();
            socket.close ();

        } catch (Exception e) {
            e.printStackTrace ();

        }
    }
}