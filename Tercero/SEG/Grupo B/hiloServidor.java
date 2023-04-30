import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.Socket;
import java.security.Key;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.KeyStore.PrivateKeyEntry;
import java.security.cert.Certificate;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class hiloServidor extends Thread {

    private static int tamanoClaves = 24;
    private int nHilo = 0, idRegistro, idNuevaSesion;
    private Socket socket;
    public static DataInputStream in;
    public static DataOutputStream out;
    public static String pathAlmacenServer;
    private static String passwordKS = "admin", passwordTS = "admin";
    private KeyStore keyStore, trustStore;
    public static ArrayList <Documento> documentos = new ArrayList <Documento> ();


    public hiloServidor (Socket socket, int id, String path, int idSesion) {

        this.socket = socket;
        idRegistro = id;
        pathAlmacenServer = path;
        idNuevaSesion = idSesion;

        try {

            in = new DataInputStream (new BufferedInputStream (socket.getInputStream ()));
            out = new DataOutputStream (socket.getOutputStream ());

        }catch (Exception e){
            e.printStackTrace ();
        }
    }





    private void desconectar () {

        try {
            socket.close ();

        } catch (Exception e) {

            System.out.println ("Error al cerrar el socket del hilo " + nHilo);
        }
    }





    public boolean [] ejecutarSocket () {

        boolean aumentarRegistro [] = {false, false};

        try {

            String seleccion = in.readUTF ();

            keyStore = KeyStore.getInstance ("JCEKS");
            keyStore.load (new FileInputStream (Servidor.archivoKeyStore), passwordKS.toCharArray ());
            trustStore = KeyStore.getInstance ("JCEKS");
            trustStore.load (new FileInputStream (Servidor.archivoTrustStore), passwordTS.toCharArray ());

            switch (seleccion) {

                case "REGISTRAR_DOCUMENTO" : 
                    System.out.println ("SE HA SELECCIONADO : REGISTRAR_DOCUMENTO");
                    aumentarRegistro = RegistrarDocumento ();
                    break;

                case "LISTAR_DOCUMENTO" : 
                    System.out.println ("SE HA SELECCIONADO : LISTAR_DOCUMENTO");
                    ListarDocumento ();
                    break;

                case "RECUPERAR_DOCUMENTO" :
                    System.out.println ("SE HA SELECCIONADO : RECUPERAR_DOCUMENTO");
                    RecuperarDocumento ();
                    break;

                default : 
                    System.out.println ("Error, seleccion no valida");
                    out.writeInt (-5);
                    break;
            }

        } catch (Exception e) {

            e.printStackTrace ();

        } finally {

            desconectar ();
        }
        
        return aumentarRegistro;
    }




    
    private boolean [] RegistrarDocumento () throws Exception {

        // Cosas para enviar
        byte [] firmaDoc = null, certificado = null;

        // Cosas para recibir
        byte [] certRecibido = null, claveCifrada = null, docRecibido = null, docFirmado = null;
        String nombreDoc, confidencialidad;

        // Cosas para trabajar
        byte [] docAlmacen = null;
        boolean [] cambioRegistros = {false, false};

        // Recibimos toda la información provniente del cliente

        certRecibido = new byte [in.readInt ()];
        in.read (certRecibido);
        nombreDoc = in.readUTF ();
        confidencialidad = in.readUTF ();

        if (confidencialidad.equals ("PRIVADO")) {

            claveCifrada = new byte [in.readInt ()];
            in.read (claveCifrada);
        }
        
        docRecibido = new byte [in.readInt ()];
        in.read (docRecibido);
        docFirmado = new byte [in.readInt ()];
        in.read (docFirmado);

        // Comprobamos la confidencialidad del archivo

        if (confidencialidad.equals ("PRIVADO")) {

            // Desciframos la clave simétrica y con ella el archivo

            PrivateKeyEntry privateKeyEntry = (PrivateKeyEntry) keyStore.getEntry ("rsa_server", new KeyStore.PasswordProtection (passwordKS.toCharArray ()));
            PrivateKey clavePrivada = privateKeyEntry.getPrivateKey ();

            byte[] claveSimetrica = CifraDescifra.descifrar (claveCifrada, clavePrivada, null, false);
            docRecibido = CifraDescifra.descifrar (docRecibido, new SecretKeySpec (claveSimetrica, "AES") , "CBC", true);

            // Ciframos el archivo con la clave simétrica del almacén

            Key claveAlmacen = keyStore.getKey ("aes_almacenamiento", passwordKS.toCharArray ());
            docAlmacen = CifraDescifra.cifrar (docRecibido, claveAlmacen, "CFB", true);

        } else if (confidencialidad.equals ("PUBLICO")) {

            docAlmacen = docRecibido;

        } else {

            System.out.println ("Tipo de confidencialidad incorrecto");
            out.writeInt (-32);
            return cambioRegistros;
        }

        // Comparamos el certificado y la firma con lo recibido

        Certificate certTS = trustStore.getCertificate ("rsa_cliente");
        PublicKey clavePublicaCliente = certTS.getPublicKey ();

        if (!Arrays.equals (certTS.getEncoded (), certRecibido)) {

            System.out.println ("Certificado del cliente incorrecto");
            out.writeInt (-1);
            return cambioRegistros;

        } else if (!CifraDescifra.comparaFirma (docRecibido, docFirmado, clavePublicaCliente)) {

            System.out.println ("Firma incorrecta");
            out.writeInt (-2);
            return cambioRegistros;
        }

        // Se escribe el documento en el almacén del servidor

        BufferedOutputStream bufferedOutputStream = new BufferedOutputStream (new FileOutputStream (pathAlmacenServer + nombreDoc));
        bufferedOutputStream.write (docAlmacen);
        bufferedOutputStream.close ();

        cambioRegistros [0] = true;

        // Se crea el sello temporal

        Calendar fecha = new GregorianCalendar ();
        fecha = GregorianCalendar.getInstance ();

        int ano = fecha.get (Calendar.YEAR);
        int mes = fecha.get (Calendar.MONTH) + 1;
        int dia = fecha.get (Calendar.DAY_OF_MONTH);
        int hora = fecha.get (Calendar.HOUR_OF_DAY);
        int minuto = fecha.get (Calendar.MINUTE);
        int segundo = fecha.get (Calendar.SECOND);

        String fechaString = dia + ";" + mes + ";" + ano + ";" + hora + ";" + minuto + ";" + segundo;

        // Generamos la firma para enviarla al cliente

        PrivateKeyEntry privateKeyEntry = (PrivateKeyEntry) keyStore.getEntry ("rsa_server",
                new KeyStore.PasswordProtection (passwordKS.toCharArray ()));
        PrivateKey clavePrivada = privateKeyEntry.getPrivateKey ();

        firmaDoc = CifraDescifra.firmar (docRecibido, clavePrivada);

        // Cogemos nuestro certificado para enviarlo

        certificado = keyStore.getCertificate ("rsa_server").getEncoded ();

        // Se crea la entrada de la tabla de documentos

        int idPropietario = idNuevaSesion;

        for (Documento doc : documentos) {

            if (Arrays.equals (certRecibido, doc.getCertPropietario ())) {

                idPropietario = doc.getPropietario ();
                cambioRegistros [1] = true;
                break;
            }
        }

        cambioRegistros [1] = !cambioRegistros [1];
        documentos.add (new Documento (idRegistro, idPropietario, nombreDoc, fechaString, confidencialidad, certRecibido));

        // Se envía toda la información

        out.writeInt (0);
        out.writeInt (idRegistro);
        out.writeUTF (fechaString);
        out.writeInt (idPropietario);
        out.writeInt (firmaDoc.length);
        out.write (firmaDoc);
        out.writeInt (certificado.length);
        out.write (certificado);

        return cambioRegistros;
    }





    private void ListarDocumento () throws Exception {

        // Cosas para recibir
        String confidencialidad;
        byte [] certRecibido = null;

        // Se lee todo lo que envia el cliente

        confidencialidad = in.readUTF ();
        certRecibido = new byte [in.readInt ()];
        in.read (certRecibido);

        // Se comprueba la confidencialidad del archivo y se leen en la lista de
        // documentos

        if (confidencialidad.equals ("PUBLICO")) {

            out.writeInt (0);

            for (Documento doc : documentos) {

                if (doc.getConfidencialidad ().equals (confidencialidad)) {

                    out.writeUTF (doc.getInfo ());
                }
            }

        } else if (confidencialidad.equals ("PRIVADO")) {

            out.writeInt (0);

            for (Documento doc : documentos) {

                if (doc.getConfidencialidad ().equals(confidencialidad) && Arrays.equals (certRecibido, doc.getCertPropietario ())) {

                    out.writeUTF (doc.getInfo ());
                }
            }

        } else {

            System.out.println ("Tipo de confidencialidad incorrecta");
            out.writeInt (-32);
            return;
        }

        out.writeUTF ("final");
    }




    
    private void RecuperarDocumento () throws Exception {

        //Cosas para recibir
        byte [] certEnviado = null;
        int idRegistro = -1;

        // Cosas para enviar
        byte [] certificado = null, docBytes = null, claveCifrada = null, docFirmado = null;

        // Cosas con las que trabajar
        int nDoc = -1;
        Documento documentoEnviar = new Documento ();
        boolean encontrado = false;

        // Se lee todo lo que manda el cliente

        certEnviado = new byte [in.readInt ()];
        in.read (certEnviado);
        idRegistro = in.readInt ();


        Certificate certificadoTS = Servidor.trustStore.getCertificate ("rsa_cliente");

        // Busca el documento en la lista
        
        for (int i = 0; i < documentos.size () && !encontrado; i++) {

            if (idRegistro == documentos.get (i).getId ()) {

                System.out.println("Encontrado archivo coincidente");

                documentoEnviar = documentos.get (i);
                encontrado = true;
                nDoc = i;
                
                // Lee el archivo a enviar
        
                BufferedInputStream bufferedInputStream = new BufferedInputStream (new FileInputStream (pathAlmacenServer + documentoEnviar.getNombre ()));
                docBytes = bufferedInputStream.readAllBytes ();
                bufferedInputStream.close ();
            }

        }
        
        if (encontrado == false) {

            System.out.println ("ID incorrecta");
            out.writeInt (-4);
            return;

        } else {

            System.out.println ("Documento encontrado");
        }
        
        // Pillamos la clave secreta del servidor
        
        PrivateKeyEntry privateKeyEntry = (PrivateKeyEntry) keyStore.getEntry ("rsa_server", new KeyStore.PasswordProtection (passwordKS.toCharArray ()));
        PrivateKey clavePrivada = privateKeyEntry.getPrivateKey ();
        
        
        if (documentoEnviar.getConfidencialidad ().equals ("PRIVADO")) {
            
            
            // Mira si el certificado enviado coincide con el guardado en el documento y en el TrustStore
            
            if (!Arrays.equals (documentoEnviar.getCertPropietario (), certEnviado)) {
                
                System.out.println ("Acceso denegado al documento");
                out.writeInt (-31);
                return;
                
            } else if (!Arrays.equals (certEnviado, certificadoTS.getEncoded ())) {
                
                System.out.println ("Error de certificado");
                out.writeInt (-1);
                return;
                
            } else {
                
                System.out.println ("Acceso permitido. Iniciando transferencia");
            }
            
            try {
                
                // Sacamos la clave del almacén, desciframos el archivo cifrado y lo firmamos
                
                Key claveAlmacen = keyStore.getKey ("aes_almacenamiento", passwordKS.toCharArray ());
                byte [] archivoDescifrado = CifraDescifra.descifrar (docBytes, claveAlmacen, "CFB", true);

                docFirmado = CifraDescifra.firmar (archivoDescifrado, clavePrivada);

                // Creamos una clave simétrica para cifrar el archivo
                
                KeyGenerator generadorClave = KeyGenerator.getInstance ("AES");
                generadorClave.init (tamanoClaves * 8);
                
                SecretKey claveAleatoria = generadorClave.generateKey ();

                // Se cifra el archivo con la clave generada

                docBytes = CifraDescifra.cifrar (archivoDescifrado, claveAleatoria, "CBC", true);

                // Se coge la clave pública del cliente para cifrar la clave simétrica
    
                X509Certificate certificadoCliente = (X509Certificate) Servidor.trustStore.getCertificate ("rsa_cliente");
                claveCifrada = CifraDescifra.cifrar (claveAleatoria.getEncoded (), certificadoCliente.getPublicKey (), null, false);

            } catch (Exception e) {

                e.printStackTrace ();
            }

        } else if (documentoEnviar.getConfidencialidad ().equals ("PUBLICO")) {

            System.out.println ("Acceso permitido. Iniciando transferencia");

            // Se firma el documento

            docFirmado = CifraDescifra.firmar (docBytes, clavePrivada);

        } else {

            System.out.println ("Error en la confidencialidad del archivo");
            out.writeInt (-32);
            return;
        }

        // Se guarda el certificado del servidor para enviárselo al cliente

        certificado = keyStore.getCertificate ("rsa_server").getEncoded ();

        // Se envía toda la información al cliente

        out.writeInt (0);
        out.writeUTF (documentoEnviar.getConfidencialidad ());
        out.writeInt (documentoEnviar.getId ());
        out.writeInt (documentoEnviar.getPropietario ());
        out.writeUTF (documentoEnviar.getSelloTemporal ());
        

        if (documentoEnviar.getConfidencialidad ().equals ("PRIVADO")) {

            out.writeInt (claveCifrada.length);
            out.write (claveCifrada);
        }

        out.writeInt (docBytes.length);
        out.write (docBytes);
        out.writeInt (docFirmado.length);
        out.write (docFirmado);
        out.writeInt (certificado.length);
        out.write (certificado);

        System.out.println ("Archivo enviado");

        // Se elimina la entrada de la tabla de documentos y el archivo del almacén

        documentos.remove (nDoc);
        new File (pathAlmacenServer + documentoEnviar.getNombre ()).delete ();
    }            
}
