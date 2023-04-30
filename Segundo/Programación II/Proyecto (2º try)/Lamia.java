import java.util.StringTokenizer;

/**
 * Clase que implementa a la criatura Lamia
 */

public class Lamia extends Criatura {

    private int astucia;
    private int seduccion;
    private int garras;
    private int miton;


    /**
     * Costructor de la clase Lamia
     * @param atts Nombre, id y atributos de la criatura
     */
    
     public Lamia (String atts) {

        StringTokenizer separador = new StringTokenizer (atts, " ,");
        String params [] = new String [6];

        for (int i = 0; i < params.length; i++) {
            params [i] = separador.nextToken ();

            if (i != 0 && i != 1) {

                try {
                    Integer.parseInt (params [i]);

                } catch (Exception e) {
                    params [i] = params [i].substring (1, params [i].length ());

                }
            }
        }

        id = params [0];
        nombre = params [1];
        astucia = Integer.parseInt (params [2]);
        seduccion = Integer.parseInt (params [3]);
        garras = Integer.parseInt (params [4]);
        miton = Integer.parseInt (params [5]);

        calculaStats ();
    }


    /**
     * Calcula el valor del ataque y la defensa de la Lamia
     */

    private void calculaStats () {

        ataque = (astucia + garras) / 5;
        defensa = (seduccion + miton) / 20;
    }


    /**
     * Reduce las estadisticas de la Lamia despues de un ataque o defensa
     * @param atq Indica si la criatura ha atacado o defendido
     */

    public void reduce (boolean atq) {

        if (atq == true) {
            vida -= 1;
            garras -= 5;

            if (garras < 0) {
                garras = 0;
            }
            
        } else {
            vida -= 3;
            miton -= 3;

            if (miton < 0) {
                miton = 0;
            }
        }

        if (vida < 0) {
            vida = 0;

        }

        calculaStats ();
    }


    /**
     * Devuelve en un String los atributos de la Lamia
     * @return Devuelve los atributos
     */

    public String getStats () {

        stats = "A" + astucia + ",S" + seduccion + ",G" + garras + ",M" + miton;
        return stats;
    }
}