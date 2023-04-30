import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.ByteBuffer;

public class tcp1ser {

    private static long acumulador = 0;

    public static void main (String[] args) throws Exception {

        long resultado = 0;
        int puerto, modo = -1, longitud, operando [] = new int [2];
        byte entrada [] = new byte [4];
        ByteBuffer conversor = ByteBuffer.allocate (Long.BYTES);
        ByteArrayOutputStream envio = new ByteArrayOutputStream ();
        ServerSocket serverSocket;
        Socket socket;
        DataInputStream in;
        DataOutputStream out;
        

        if (args.length != 1) {

            System.out.println ("Número de argumentos incorrecto.\n   Sintaxis correcta: java tcp1ser puerto_servidor\n\n");
            return;
        }

        puerto = Integer.parseInt (args [0]);

        serverSocket = new ServerSocket (puerto);
        System.out.println ("Servidor abierto. Esperando peticiones ...\n");

        while (true) {

            socket = serverSocket.accept ();
            System.out.println ("Cliente conectado");

            in = new DataInputStream (socket.getInputStream ());
            out = new DataOutputStream (socket.getOutputStream ());

            try {

                while (true) {
    
                    envio.reset ();
        
                    System.out.println ("Esperando operación . . .");
                    in.read (entrada);
    
                    modo = entrada [0];
                    longitud = entrada [1];
    
                    for (int i = 0; i < (int) longitud; i++) {
    
                        operando [i] = entrada [i + 2];
                    }
    
                    System.out.print ("Operación recibida: ");
    
                    switch (modo) {
    
                        case 1:
                            System.out.println (operando [0] + " + " + operando [1]);
                            resultado = operando [0] + operando [1];
                            break;
    
                        case 2:
                            System.out.println (operando [0] + " - " + operando [1]);
                            resultado = operando [0] - operando [1];
                            break;
    
                        case 3:
                            System.out.println (operando [0] + " * " + operando [1]);
                            resultado = operando [0] * operando [1];
                            break;
    
                        case 4:
                            System.out.println (operando [0] + " / " + operando [1]);
                            resultado = (long) Math.floor (operando [0] / operando [1]);
                            break;
    
                        case 5:
                            System.out.println (operando [0] + " % " + operando [1]);
                            resultado = operando [0] % operando [1];
                            break;
    
                        case 6:
                            System.out.println (operando [0] + "!");
                            resultado = 1;
    
                            do {
    
                                resultado *= operando [0];
                                operando [0] --;
    
                            } while (operando [0] > 1);
                            break;
                    }
    
                    acumulador += resultado;
    
                    System.out.println ("Resultado = " + resultado + " (Acumulador = " + acumulador + ")");
                    
                    envio.write (16);
                    envio.write (8);
                    
                    conversor.putLong (resultado);
                    envio.write (conversor.array ());
    
                    out.write (envio.toByteArray ());
    
                    System.out.println ("Resultado enviado");
                }

            } catch (Exception e) {

                System.out.println ("Cliente desconectado. Esperando nuevo cliente . . .");
            }
        }
    }
}