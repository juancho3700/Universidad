public class Documento {
    
    private String nombre;
    private String selloTemporal;
    private  int id,propietario;
    private String confidencialidad;
    private byte [] certPropietario;


    public Documento () {

    }


    public Documento (int idRegistro, int propietarioAux, String nombreDocumento, String estampitaTemporal,
                      String confidencialidadAux, byte [] certificadoAux) {

        id = idRegistro;
        propietario = propietarioAux;
        nombre = nombreDocumento;
        selloTemporal = estampitaTemporal;
        confidencialidad = confidencialidadAux;
        certPropietario = certificadoAux;

    }


    public String getInfo () {

        String envio = Integer.toString (id) + ";" + propietario + ";" + nombre + ";" + selloTemporal;
        return envio;
    }



    // GETTERS

    public String getNombre () {

        return nombre;
    }

    public int getPropietario () {

        return propietario;
    }

    public String getSelloTemporal () {

        return selloTemporal;
    }

    public int getId () {

        return id;
    }

    public String getConfidencialidad () {

        return confidencialidad;
    }

    public byte[] getCertPropietario () {

        return certPropietario;
    }
}
