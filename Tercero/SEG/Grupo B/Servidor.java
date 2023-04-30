import java.io.FileInputStream;
import java.net.Socket;
import java.security.KeyStore;
import javax.net.ServerSocketFactory;
import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLServerSocket;
import javax.net.ssl.SSLServerSocketFactory;
import javax.net.ssl.TrustManagerFactory;

/*

ARGUMENTOS DE INVOCACIÓN
- Archivo KeyStore
- Password KeyStore
- Archivo TrustStore
- Tipo de Cifrado 

*/

public class Servidor {

    // Variables "globales"

    private static int puertoServidor = 9000;
    private static String passwordTS = "admin";
    public static KeyStore keyStore, trustStore;
    public static String pathAlmacenServer = "./AlmacenServidor/";
    public static String archivoKeyStore = null, archivoTrustStore = null, tipoCifrado = null;
    
    public static void main (String[] args) {
        
        // Variables
        
        String passwordKS = null;
        SSLServerSocketFactory sslServerSocketFactory = null;
        ServerSocketFactory serverSocketFactory = null;
        SSLServerSocket sslServerSocket = null;
        SSLContext context;
        KeyManagerFactory keyManagerFactory = null;
        TrustManagerFactory trustManagerFactory = null;
        
        int idSesion = 0, idRegistro = 0, idUsuario = 0;

        if (args.length == 4) {

            archivoKeyStore = pathAlmacenServer + args [0].trim ();
            passwordKS = args [1].trim ();
            archivoTrustStore = pathAlmacenServer + args [2].trim ();
            tipoCifrado = args [3].trim ();

        } else {

            System.out.println ("Argumentos incorrectos. Saluditos");
            System.exit (-1);

        }
        

        // Inicializar el KeyStore y el TrustStore
        
        System.setProperty("javax.net.ssl.keyStore", archivoKeyStore);
        System.setProperty("javax.net.ssl.keyStoreType", "JCEKS");
        System.setProperty("javax.net.ssl.keyStorePassword", passwordKS);

        System.setProperty("javax.net.ssl.trustStore", archivoTrustStore);
        System.setProperty("javax.net.ssl.trustStoreType", "JCEKS");
        System.setProperty("javax.net.ssl.trustStorePassword", passwordTS);

        try {

            System.out.println ("\n\n--- Iniciando servidor ---");

            keyManagerFactory = KeyManagerFactory.getInstance ("SunX509");
                keyStore = KeyStore.getInstance ("JCEKS");
                keyStore.load (new FileInputStream (archivoKeyStore), passwordKS.toCharArray ());
            
            keyManagerFactory.init (keyStore, passwordKS.toCharArray ());
            trustManagerFactory = TrustManagerFactory.getInstance (TrustManagerFactory.getDefaultAlgorithm ());
            
                trustStore = KeyStore.getInstance ("JCEKS");
                trustStore.load (new FileInputStream(archivoTrustStore), passwordTS.toCharArray ());
                trustManagerFactory.init (trustStore);
            

            // Inicializar la conexión SSL

            context = SSLContext.getInstance ("TLS");
            context.init (keyManagerFactory.getKeyManagers (), null, null);
            
            sslServerSocketFactory = context.getServerSocketFactory ();

                serverSocketFactory = sslServerSocketFactory;

                sslServerSocket = (SSLServerSocket) serverSocketFactory.createServerSocket (puertoServidor);
                sslServerSocket.setNeedClientAuth (true);

            System.out.println ("--- Servidor iniciado ---");

            // Proceso con el que se atienden peticiones

            while (true) {

                Socket cliente = sslServerSocket.accept ();
                hiloServidor hilo = new hiloServidor (cliente, idRegistro, pathAlmacenServer, idUsuario);
                
                System.out.println ("\nCreado hilo " + idSesion);
                
                boolean [] cambioRegistros = hilo.ejecutarSocket ();

                if (cambioRegistros [0]) {

                    idRegistro ++;
                }

                if (cambioRegistros[1]) {

                    idUsuario ++;
                }
                
                idSesion ++;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

    }

}