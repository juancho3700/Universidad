import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;

public class tcp3ser {

    

    public static void main (String[] args) throws Exception {
        
        int puerto, nCliente = 0;
        

        if (args.length != 1) {

            System.out.println ("Sintaxis incorrecta\nInvocacion: java tcp3ser puerto\n");
            return;
        }

        puerto = Integer.parseInt (args [0]);

        ServerSocketChannel serverSocketChannel = ServerSocketChannel.open ();
        serverSocketChannel.socket ().bind (new InetSocketAddress (puerto));

        while (true) {

            SocketChannel socketChannel = serverSocketChannel.accept ();

            
        }

    }
}