import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;

public class tcp2ser {

    public static class ModRunnable implements Runnable {

        Socket socket;
        int acumulador = 0, nCliente;
        String datos[];
        DataInputStream dataIn;
        DataOutputStream dataOut;

        public ModRunnable (Socket socketCliente, int numCliente) {

            socket = socketCliente;
            nCliente = numCliente;
        }

        @Override
        public void run () {

            try {
                
                dataIn = new DataInputStream (socket.getInputStream ());
                dataOut = new DataOutputStream (socket.getOutputStream ());

                while (true) {

                    datos = dataIn.readUTF ().split (" ");
                    System.out.println ("Mensaje recibido del cliente " + nCliente);

                    if (datos [0].equals ("0")) {

                        System.out.println ("Cerrando conexion con el cliente " + nCliente);
                        socket.close ();
                        return;
                    }

                    for (int i = 0; i < datos.length; i++) {

                        acumulador += Integer.parseInt (datos [i]);
                    }

                    System.out.println ("El acumulador del cliente " + nCliente + " vale " + acumulador + "\n");
                    dataOut.writeInt (acumulador);
                }

            } catch (SocketException ex) {
            
                System.out.println ("Se ha cortado la conexion con el cliente " + nCliente + ". Cerrando hilo ...\n");
                return;
                
            
            } catch (Exception e) {

                e.printStackTrace ();
            }
        }
    }

    public static void main (String[] args) {

        int puerto, nCliente = 0;
        Socket socket;
        ServerSocket serverSocket;

        if (args.length != 1) {

            System.out.println("Sintaxis incorrecta\nInvocacion: java tcp2ser puerto\n");
            return;
        }

        try {

            puerto = Integer.parseInt(args[0]);
            System.out.println("Iniciando servidor ...");
    
            serverSocket = new ServerSocket(puerto);
            System.out.println("Servidor iniciado\n");
    
            while (true) {
    
                socket = serverSocket.accept();
                nCliente ++;
                System.out.println("Conexion creada con el cliente " + nCliente);
    
                Thread thread = new Thread (new ModRunnable (socket, nCliente));
                thread.start ();
            }

        } catch (Exception e) {

            e.printStackTrace ();
        }
    }
}
