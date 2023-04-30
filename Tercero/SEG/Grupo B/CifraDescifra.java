import java.security.Key;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class CifraDescifra {
    
    public static byte [] descifrar (byte [] ficheroCifrado, Key clave, String tipoCifrado, boolean simetrico) {

        byte[] original = null;

        try {

            if (simetrico) {
                
                IvParameterSpec iv = new IvParameterSpec (new byte [16]);
                SecretKeySpec skeyspec = new SecretKeySpec (clave.getEncoded (), "AES");
    
                Cipher cipher = Cipher.getInstance ("AES/" + tipoCifrado + "/PKCS5Padding");
                cipher.init (Cipher.DECRYPT_MODE, skeyspec, iv);
                original = cipher.doFinal (ficheroCifrado);

            } else {

                Cipher cipher = Cipher.getInstance ("RSA/ECB/PKCS1Padding");
                cipher.init (Cipher.DECRYPT_MODE, clave);
                original = cipher.doFinal (ficheroCifrado);
            }

        } catch (Exception e) {

            e.printStackTrace ();
        }

        return original;
    }

    
    
    public static byte[] cifrar (byte [] ficheroCifrar, Key clave, String tipoCifrado, boolean simetrico) {
        
        byte[] cifrado = null;
        
        try {
            
            if (simetrico) {
                
                IvParameterSpec iv = new IvParameterSpec (new byte [16]);
                SecretKeySpec skeyspec = new SecretKeySpec (clave.getEncoded (), "AES");
                
                Cipher cipher = Cipher.getInstance ("AES/" + tipoCifrado + "/PKCS5Padding");
                cipher.init (Cipher.ENCRYPT_MODE, skeyspec, iv);
                cifrado = cipher.doFinal (ficheroCifrar);

            } else {
                
                Cipher cifrador = Cipher.getInstance ("RSA/ECB/PKCS1Padding");
                cifrador.init (Cipher.ENCRYPT_MODE, clave);
                cifrado = cifrador.doFinal (ficheroCifrar);
                
            }


        } catch (Exception e) {

            e.printStackTrace ();
            cifrado = null;
        }

        return cifrado;
    } 


    public static byte [] firmar (byte [] ficheroFirmar, PrivateKey clave) {

        byte [] firmado = null;

        try {

            Signature firmador = Signature.getInstance ("SHA1withRSA");
            firmador.initSign (clave);

            for (int i = 0; i < ficheroFirmar.length; i += 2048) {

                firmador.update (ficheroFirmar, i, Math.min (2048, ficheroFirmar.length - i));
            }

            firmado = firmador.sign ();

        } catch (Exception e) {
            
            e.printStackTrace();
            firmado = null;
        }

        return firmado;
    }


    public static boolean comparaFirma (byte [] docSinFirmar, byte [] docFirmado, PublicKey clave) {

        boolean firmaBien = false;

        try {

            Signature firmador = Signature.getInstance ("SHA1withRSA");
            firmador.initVerify (clave);

            for (int i = 0; i < docSinFirmar.length; i += 2048) {

                firmador.update(docSinFirmar, i, Math.min (2048, docSinFirmar.length - i));
            }

            if (firmador.verify (docFirmado)) {

                firmaBien = true;

            } else {

                firmaBien = false;
            }

        } catch (Exception e) {

            e.printStackTrace ();
            firmaBien = false;
        }

        return firmaBien;
    }


    public static byte [] calculaHash (byte [] docParaCifrar, String modo) {

        byte [] hash = null;

        try {

            MessageDigest messageDigest = MessageDigest.getInstance (modo);
            hash = messageDigest.digest (docParaCifrar);

        } catch (Exception e) {

            e.printStackTrace ();
        }

        return hash;
    }
}
