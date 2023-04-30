import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.KeyStore.PrivateKeyEntry;
import java.security.cert.Certificate;
import java.security.cert.X509Certificate;
import java.util.Arrays;
import java.util.Scanner;
import java.util.StringTokenizer;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManagerFactory;

/*

ARGUMENTOS DE INVOCACIÓN:
- Archivo KeyStore
- Archivo TrustStore

*/

public class Cliente {
    
    // Variable "globales"
    protected static DataOutputStream out;
    protected static DataInputStream in;

    private static int puertoCliente = 9000; 
    private static String pathAlmacenCliente = "./AlmacenCliente/";
    private static String modoHash = "SHA-384";
    public static KeyStore keyStore, trustStore;
    public static SSLSocket sslSocket;
    
    //Cambiar los nombres/mover del main los que ya hay
    private static Scanner scanner = new Scanner (System.in);
    private static String passwordKS, passwordTS;
    private static String alias = "rsa_cliente";


    public static void main (String[] args) {
        
        // Variables

        SSLContext contexto;
        KeyManagerFactory keyManagerFactory;
        TrustManagerFactory trustManagerFactory;
        SSLSocketFactory sslSocketFactory = null;
        //SSLSocket sslSocket;

        String archivoKeyStore = null, archivoTrustStore = null;
        String [] cipherSuites = null;


        if (args.length == 2) {

            archivoKeyStore = args [0].trim ();
            archivoTrustStore = args [1].trim ();

        } else {

            System.out.println ("Argumentos incorrectos. Saluditos");
            System.exit(-1);

        }

        // Inicializar KeyStore y TrustStore        

        System.out.println ("\n\nSaluditos");

        Scanner entradaTeclado = new Scanner (System.in);

        System.setProperty ("javax.net.ssl.keyStore", archivoKeyStore);
        System.setProperty ("javax.net.ssl.trustStore", archivoTrustStore);

        System.out.print ("   Introduzca la password del keystore: ");
        passwordKS = entradaTeclado.nextLine ();

        try {

            keyManagerFactory = KeyManagerFactory.getInstance ("SunX509");
                keyStore = KeyStore.getInstance ("JCEKS");
                keyStore.load (new FileInputStream (pathAlmacenCliente + archivoKeyStore), passwordKS.toCharArray ());
            keyManagerFactory.init (keyStore, passwordKS.toCharArray ());

        } catch (Exception e) {

            System.out.println ("Contrasenha del KeyStore incorrecta. Cerrando sesion\n");
            entradaTeclado.close ();
            return;
        }

        System.setProperty ("javax.net.ssl.keyStoreType", "JCEKS");
        System.setProperty ("javax.net.ssl.keyStorePassword", passwordKS);

        System.out.print ("   Introduzca la password del truststore: ");
        passwordTS = entradaTeclado.nextLine ();

        try {

            trustManagerFactory = TrustManagerFactory.getInstance (TrustManagerFactory.getDefaultAlgorithm ());
                trustStore = KeyStore.getInstance ("JCEKS");
                trustStore.load (new FileInputStream (pathAlmacenCliente + archivoTrustStore), passwordTS.toCharArray ());
            trustManagerFactory.init (trustStore);

        } catch (Exception e) {

            System.out.println ("Contrasenha del TrustStore incorrecta. Cerrando sesion\n");
            entradaTeclado.close ();
            return;
        }

        System.setProperty ("javax.net.ssl.trustStoreType", "JCEKS");
        System.setProperty ("javax.net.ssl.trustStorePassword", passwordTS);

        try {

            // Inicializar la conexión SSL
            
            contexto = SSLContext.getInstance ("TLS");
            contexto.init (keyManagerFactory.getKeyManagers (), trustManagerFactory.getTrustManagers (), null);
            sslSocketFactory = contexto.getSocketFactory ();

            sslSocket = (SSLSocket) sslSocketFactory.createSocket ("localhost", puertoCliente);
            cipherSuites = sslSocketFactory.getDefaultCipherSuites ();
            sslSocket.setEnabledCipherSuites (cipherSuites);

            System.out.println ("\n --- Comienzo SSL CogidaDeManos");

            for (int i = 0; i < cipherSuites.length; i++) {

                try {
    
                    sslSocket.startHandshake ();
                                       
                } catch (Exception e) {
                    
                    e.printStackTrace ();
                    System.out.println ("Error en la cogida de manos - Cerrando programa ...");
                    System.exit (1);
                }
            }

            System.out.println ("\n --- Fin SSL CogidaDeManos");
            System.out.println (" --- Canal SSL con autenticacion de cliente y servidor finalizado");

            in = new DataInputStream (sslSocket.getInputStream ());
            out = new DataOutputStream (sslSocket.getOutputStream ());

            int prueba = 0;

            System.out.println ("\n 1. Registrar documento");
            System.out.println (" 2. Listar documento");
            System.out.println (" 3. Recuperar documento\n");
            System.out.print (" Elija una opcion: ");

            prueba = entradaTeclado.nextInt ();

            switch (prueba) {

                case 1 :    
                    RegistrarDocumento ();
                    break;

                case 2 : 
                    ListarDocumento ();
                    break;

                case 3 : 
                    RecuperarDocumento ();
                    break;
                
                default :
                    System.out.println ("\nOpcion no contemplada\n");
                    break;
                
            }
            
        } catch (Exception e) {

            e.printStackTrace ();
            System.exit (1);
        }

        entradaTeclado.close ();
    }





    private static void RegistrarDocumento () throws Exception {

        // Cosas para enviar
        String nombreDoc = null, confidencialidad = null;
        byte[] docBytesEnviar = null, claveCifrada = null, docFirmado = null, certEnviar = null;

        // Cosas para recibir
        int error = 0, idRegistro = -1, idPropietario = -1;
        String selloTemporal;
        byte [] certRecibido = null, firmaRecibida = null;

        // Cosas con las que trabajar
        byte [] docSinCifrar = null, docHash = null;

        // Pedimos el archivo que hay que enviar, vemos si existe y se lee

        System.out.println ("\n\n***** REGISTRAR DOCUMENTO *****\n");
        System.out.print ("Introduzca el nombre del archivo a enviar: ");
        nombreDoc = scanner.nextLine ();

        try {

            File fichero = new File (pathAlmacenCliente + nombreDoc);

            if (!fichero.exists ()) {

                System.out.println ("El fichero especificado no existe. Cerrando sesión\n");
                return;

            } else {

                BufferedInputStream bufferedInputStream = new BufferedInputStream (new FileInputStream (fichero));
                docBytesEnviar = bufferedInputStream.readAllBytes ();
                docSinCifrar = docBytesEnviar;
                bufferedInputStream.close ();
            }

        } catch (Exception e) {

            System.out.println ("Error al leer el fichero. Cerrando sesión\n");
            return;
        }

        
        // Cogemos la clave secreta del cliente y firmamos el documento
        
        PrivateKeyEntry privateKeyEntry = (PrivateKeyEntry) keyStore.getEntry ("rsa_cliente", new KeyStore.PasswordProtection (passwordKS.toCharArray()));
        PrivateKey clavePrivada = privateKeyEntry.getPrivateKey ();

        docFirmado = CifraDescifra.firmar (docBytesEnviar, clavePrivada);

        // Se pide la confidencialidad del archivo y se comprueba que sea correcta
        // Si es privado se cifra el documento

        System.out.print ("Introduzca la confidencialidad del archivo (PUBLICO | PRIVADO): ");
        confidencialidad = scanner.nextLine ();

        if (confidencialidad.equals ("PRIVADO")) {

            // Creamos la clave aleatoria para cifrar el archivo

            KeyGenerator generadorClave = KeyGenerator.getInstance ("AES");
            generadorClave.init (192);

            SecretKey claveAleatoria = generadorClave.generateKey ();

            // Se cifra el documento con la clave generada

            docBytesEnviar = CifraDescifra.cifrar (docBytesEnviar, claveAleatoria, "CBC", true);

            // Se coge la clave pública del servidor para cifrar la clave simétrica

            X509Certificate certificado = (X509Certificate) trustStore.getCertificate ("rsa_server");
            claveCifrada = CifraDescifra.cifrar (claveAleatoria.getEncoded (), certificado.getPublicKey (), null, false);

        } else if (!confidencialidad.equals("PUBLICO")) {

            System.out.println("Tipo de confidencialidad incorrecta. Cerrando sesión\n");
        }


        // Cogemos el certificado del cliente para enviarlo

        certEnviar = keyStore.getCertificate ("rsa_cliente").getEncoded ();

        // Enviamos todo al servidor

        out.writeUTF ("REGISTRAR_DOCUMENTO");
        out.writeInt (certEnviar.length);
        out.write (certEnviar);
        out.writeUTF (nombreDoc);
        out.writeUTF (confidencialidad);

        if (confidencialidad.equals ("PRIVADO")) {
     
            out.writeInt (claveCifrada.length);
            out.write (claveCifrada);
        }

        out.writeInt (docBytesEnviar.length);
        out.write (docBytesEnviar);
        out.writeInt (docFirmado.length);
        out.write (docFirmado);

        // Leemos todo lo que envía el servidor

        error = in.readInt ();
        idRegistro = in.readInt ();
        selloTemporal = in.readUTF ();
        idPropietario = in.readInt ();
        firmaRecibida = new byte [in.readInt ()];
        in.read (firmaRecibida);
        certRecibido = new byte [in.readInt ()];
        in.read (certRecibido);

        if (!gestionaError (error)) {

            return;
        }

        // Cogemos el certificado del servidor de truststore y lo comparamos
        // con el recibido junto con la firma

        Certificate certTS = trustStore.getCertificate ("rsa_server");

        if (!Arrays.equals (certRecibido, certTS.getEncoded ())) {

            System.out.println("Certificado recibido incorrecto. Cerrando sesion\n");
            return;

        } else if (!CifraDescifra.comparaFirma (docSinCifrar, firmaRecibida, certTS.getPublicKey ())) {

            System.out.println ("Firma recibida incorrecta. Cerrando sesión\n");
            return;

        }

        StringTokenizer tokenizer = new StringTokenizer (selloTemporal, ";");

        System.out.println ("Documento registrado correctamente");
        System.out.println ("Tu usuario es el numero: " + idPropietario);
        System.out.println ("   Numero de registro: " + idRegistro);
        System.out.println ("   Momento del registro: " + tokenizer.nextToken () + "-"
                                                        + tokenizer.nextToken () + "-"
                                                        + tokenizer.nextToken () + " "
                                                        + tokenizer.nextToken () + ":"
                                                        + tokenizer.nextToken () + ":"
                                                        + tokenizer.nextToken () + "\n");

        // Computamos el hash para guardar el archivo

        docHash = CifraDescifra.calculaHash (docSinCifrar, modoHash);

        BufferedOutputStream bufferedOutputStream = new BufferedOutputStream (new FileOutputStream (pathAlmacenCliente + idRegistro + "-" + nombreDoc));
        bufferedOutputStream.write (docHash, 0, docHash.length);
        bufferedOutputStream.close ();

        new File (pathAlmacenCliente + nombreDoc).delete (); 
    }

    



    private static void ListarDocumento () throws Exception {

        // Cosas para enviar
        String confidencialidad;
        byte [] certKS = null;

        // Cosas para recibir
        String infoRecibida = "nada";
        int error = 0;

        // Cosas para trabajar
        int nDoc = 1;
        Scanner scanner = new Scanner (new InputStreamReader (System.in));

        // Se pide la confidencialidad de los documentos

        System.out.println ("\n\n***** LISTAR DOCUMENTO *****");
        System.out.print ("Introduce el tipo de documento a listar (PUBLICO | PRIVADO): ");
        confidencialidad = scanner.nextLine ();

        if (!confidencialidad.equals ("PUBLICO") && !confidencialidad.equals ("PRIVADO")) {

            System.out.println ("Confidencialidad incorrecta. Cerrando sesión\n");
            return;
        }

        // Cogemos el certificado del KeyStore

        certKS = keyStore.getCertificate ("rsa_cliente").getEncoded ();

        // Se envía toda la información

        out.writeUTF ("LISTAR_DOCUMENTO");
        out.writeUTF (confidencialidad);
        out.writeInt (certKS.length);
        out.write (certKS);

        // Se lee y se imprime toda la información recibida del servidor

        error = in.readInt ();
        infoRecibida = in.readUTF ();

        if (!gestionaError (error)) {

            return;
        }

        while (!infoRecibida.equals ("final")) {
            
            StringTokenizer tokenizer = new StringTokenizer (infoRecibida, ";");

            System.out.println ("------ DOCUMENTO " + nDoc + " ------");
            System.out.println ("ID registro: " + tokenizer.nextToken ());
            System.out.println ("ID propietario: " + tokenizer.nextToken ());
            System.out.println ("Nombre del archivo: " + tokenizer.nextToken ());
            System.out.println ("Fecha de registro: " + tokenizer.nextToken () + "-"
                                                      + tokenizer.nextToken () + "-"
                                                      + tokenizer.nextToken () + " "
                                                      + tokenizer.nextToken () + ":"
                                                      + tokenizer.nextToken () + ":"
                                                      + tokenizer.nextToken () + "\n");
            nDoc ++;
            infoRecibida = in.readUTF ();
        }
    }





    public static void RecuperarDocumento () throws Exception {

        // Cosas para enviar
        int idRegistro = -1;
        byte []  certificado = null;

        // Cosas para recibir
        int idRegistroRecibido, idPropietario;
        String confidencialidad, selloTemporal;
        byte [] claveCifrada = null, doc = null, docFirmado = null, certificadoRecibido = null;
        
        // Cosas con las que trabajar
        String nombreDoc, nombreDocHash;
        byte [] docHash = null, docGuardado = null;
        StringTokenizer tokenizer;

        // Se consiguen los datos del archivo a recuperar

        System.out.print ("  ID del registro del documento a recuperar: ");
        idRegistro = scanner.nextInt();

        // Se saca el certificado del cliente para enviarlo al servidor

        certificado = keyStore.getCertificate (alias).getEncoded ();
        
        // Se envía toda la información necesaria al servidor
        
        out.writeUTF ("RECUPERAR_DOCUMENTO");
        out.writeInt (certificado.length);
        out.write (certificado);
        out.writeInt (idRegistro);

        // Lectura de los datos enviados por el servidor

        int error = in.readInt ();
        
        if (!gestionaError (error)) {

            return;
        }
        
        confidencialidad = in.readUTF ();
        idRegistroRecibido = in.readInt ();
        idPropietario = in.readInt ();
        selloTemporal = in.readUTF ();
        
        // Se muestra la información del documento recibida

        tokenizer = new StringTokenizer (selloTemporal, ";");
        
        System.out.println ("Tipo de confidencialidad: " + confidencialidad);
        System.out.println ("ID registro: " + idRegistroRecibido);
        System.out.println ("ID del propietario: " + idPropietario);
        System.out.println ("Fecha del registro: " + tokenizer.nextToken () + "-"
                                                   + tokenizer.nextToken () + "-"
                                                   + tokenizer.nextToken () + " "
                                                   + tokenizer.nextToken () + ":"
                                                   + tokenizer.nextToken () + ":"
                                                   + tokenizer.nextToken () + "\n");
        

        if (confidencialidad.equals ("PRIVADO")) {

            claveCifrada = new byte [in.readInt ()];
            in.read (claveCifrada);
        }

        doc = new byte [in.readInt ()];
        in.read (doc);
        docFirmado = new byte [in.readInt ()];
        in.read (docFirmado);
        certificadoRecibido = new byte [in.readInt ()];
        in.read (certificadoRecibido);

        // Se saca el certificado para comparar con el recibido

        X509Certificate certificadoServidorTS = (X509Certificate) trustStore.getCertificate ("rsa_server");
        byte [] certificadoServidor = certificadoServidorTS.getEncoded ();

        PublicKey publicKey = trustStore.getCertificate("rsa_server").getPublicKey ();

        
        if (Arrays.equals (certificadoRecibido, certificadoServidor) == false) {
            
            System.out.println ("Certificado del servidor incorrecto, cerrando sesión\n");
            return;
        }
        
        // Se descifra la clave simétrica y con ella el documento en caso de ser privado
        
        if (confidencialidad.equals ("PRIVADO")) {
            
            PrivateKeyEntry privateKeyEntry = (PrivateKeyEntry) keyStore.getEntry ("rsa_cliente", new KeyStore.PasswordProtection (passwordKS.toCharArray ()));
            PrivateKey clavePrivada = privateKeyEntry.getPrivateKey ();
            
            byte [] claveSimetrica = CifraDescifra.descifrar (claveCifrada, clavePrivada, null, false);
            doc = CifraDescifra.descifrar (doc, new SecretKeySpec (claveSimetrica, "AES"), "CBC", true);
        }

        if (!CifraDescifra.comparaFirma (doc, docFirmado, publicKey)) {

            System.out.println ("Fallo de firma del registrador. Cerrando sesion\n");
            return;
        }

        scanner.nextLine ();

        System.out.print ("Introduzca nombre para el fichero : ");
        nombreDoc = scanner.nextLine ();

        docHash = CifraDescifra.calculaHash (doc, modoHash);
        
        System.out.print ("Inserte el nombre del archivo codificado: ");
        nombreDocHash = scanner.nextLine ();

        BufferedInputStream bufferedInputStream = new BufferedInputStream (new FileInputStream (pathAlmacenCliente + nombreDocHash));
        docGuardado = bufferedInputStream.readAllBytes ();
        bufferedInputStream.close ();

        if (!Arrays.equals (docGuardado, docHash)) {

            System.out.println ("ERROR. El registrador ha modificado el archivo. Cerrando sesion\n");

        } else {

            try {
    
                BufferedOutputStream bufferedOutputStream = new BufferedOutputStream (new FileOutputStream (new File (pathAlmacenCliente + nombreDoc)));
                bufferedOutputStream.write (doc);
                bufferedOutputStream.close ();

                new File (pathAlmacenCliente + nombreDocHash).delete ();
    
            } catch (Exception e) {
    
                e.printStackTrace ();
            }
        }
    }





    private static boolean gestionaError (int error) {

        switch (error) {

            case 0:
                return true;

            case -1:
                System.out.println ("Certificado enviado incorrecto. Cerrando sesion\n");
                return false;

            case -2:
                System.out.println ("Firma enviada incorrecta. Cerrando sesion\n");
                return false;

            case -31:
                System.out.println ("Acceso denegado al documento. Cerrando sesion\n");
                return false;

            case -32:
                System.out.println ("Tipo de confidencialidad incorrecta. Cerrando sesion\n");
                return false;

            case -4:
                System.out.println ("Error con la ID del documento registrado. Cerrando sesion\n");
                return false;

            case -5:
                System.out.println ("Seleccion incorrecta. Cerrando sesion\n");
                return false;

            default:

                System.out.println ("Error desconocido. Cerrando sesion\n");
                return false;
        }
    }
}
