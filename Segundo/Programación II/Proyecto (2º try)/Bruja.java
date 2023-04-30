import java.util.StringTokenizer;

/**
 * Clase que implementa a la criatura Bruja
 */

public class Bruja extends Criatura {

    private int sabiduria;
    private int magia;
    private int baston;
    private int vestido;
    
    
    /**
     * Constructor de la clase Bruja
     * @param atts Nombre, id y atributos de la criatura
     */

    public Bruja (String atts) {

        StringTokenizer separador = new StringTokenizer (atts, " ,");
        String params [] = new String [6];

        for (int i = 0; i < params.length; i++) {
            params [i] = separador.nextToken ();

            if (i != 0 && i != 1) {

                try {
                    Integer.parseInt(params[i]);

                } catch (Exception e) {
                    params[i] = params[i].substring(1, params[i].length());

                }
            }
        }

        id = params [0];
        nombre = params [1];
        sabiduria = Integer.parseInt (params [2]);
        magia = Integer.parseInt (params [3]);
        baston = Integer.parseInt (params [4]);
        vestido = Integer.parseInt (params [5]);
        templo = true;

        calculaStats ();
    }


    /**
     * Calcula el valor del ataque y la defensa de la Bruja
     */

    private void calculaStats () {

        ataque = (sabiduria + magia) * baston / 5;
        defensa = (sabiduria + magia) * vestido / 10;
    }


    /**
     * Reduce las estadisticas de la Bruja despues de un ataque o defensa
     * @param atq Indica si la criatura ha atacado o defendido
     */

    public void reduce (boolean atq) {

         vida -= 2;

        if (atq == true) {
            baston -= 1;

            if (baston < 1) {
                baston = 1;
            }

        } else {
            vestido -= 1;

            if (vestido < 1) {
                vestido = 1;
            }
        }

        if (vida < 0) {
            vida = 0;

        }

        calculaStats ();
    }


    /**
     * Aumenta las estadisticas de la Bruja segun los parametros de la visita al Templo Maldito
     */

    public void visita (){

        if (vida <= 0 || peleo == false) {
            return;

        } else {

            visitas += 1;
            int sumaBaston = (2 + visitas) / 2;
            int sumaVestido = visitas / 2;

            if (sumaBaston + baston > 10) {
                baston = 10;

            } else {
                baston += sumaBaston;

            }

            if (sumaVestido + vestido > 10) {
                vestido = 10;

            } else {
                vestido += sumaVestido;

            }
        }

        calculaStats ();
    }


    /**
     * Devuelve en un String los atributos de la Bruja
     * @return Devuelve los atributos
     */

    public String getStats () {

        stats = "S" + sabiduria + ",M" + magia + ",B" + baston + ",V" + vestido;
        return stats;

    }


    /**
     * Devuelve el lugar Sagrado al que va a recuperarse (Lago o Templo)
     * @return "T"
     */

    public String getLugar () {

        return "T";
    }
}
