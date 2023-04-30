import java.util.StringTokenizer;

/**
 * Clase que implementa a la criatura Elfo
 */

public class Elfo extends Criatura {

    private int inteligencia;
    private int arco;
    private int coraza;
    
    
    /**
     * Constructor de la clase Elfo
     * @param atts Nombre, id y atributos de la criatura
     */

    public Elfo (String atts){

        StringTokenizer separador = new StringTokenizer (atts, " ,");
        String params [] = new String [5];

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
        inteligencia = Integer.parseInt (params [2]);
        arco = Integer.parseInt (params [3]);
        coraza = Integer.parseInt (params [4]);
        lago = true;

        calculaStats ();
    }


    /**
     * Calcula el valor del ataque y la defensa del Elfo
     */

    private void calculaStats (){

        ataque = (inteligencia * arco * arco) / 5;
        defensa = (inteligencia * coraza * coraza) / 10;

        if (vida == 0) {
            ataque = 0;
            defensa = 0;

        }
    }


    /**
     * Reduce las estadisticas del Elfo despues de un ataque o defensa
     * @param atq Indica si la criatura ha atacado o defendido
     */

    public void reduce (boolean atq){

        vida -= 3;

        arco -= 1;
        if (arco < 2){
            arco = 2;
        }

        coraza -= 1;
        if (coraza < 1) {
            coraza = 1;
        }

        if (vida < 0) {
            vida = 0;

        }

        calculaStats ();
    }


    /**
     * Aumenta las estadisticas del Elfo segun los parametros de la visita al Lago Sagrado
     */

    public void visita (){

        if (vida <= 0 || peleo == false) {
            return;

        } else {
            visitas += 1;
            int sumaVida = 3 * visitas;
            int sumaArcoCoraza = visitas / 2;

            if (sumaVida + vida > 10) {
                vida = 10;

            } else {
                vida += sumaVida;

            }

            if (sumaArcoCoraza + arco > 5) {
                arco = 5;

            } else {
                arco += sumaArcoCoraza;

            }

            if (sumaArcoCoraza + coraza > 5) {
                coraza = 5;

            } else {
                coraza += sumaArcoCoraza;

            }
        }

        calculaStats ();
    }


    /**
     * Devuelve en un String los atributos del Elfo
     * @return Devuelve los atributos
     */

    public String getStats () {

        stats = "I" + inteligencia + ",A" + arco + ",C" + coraza;
        return stats;
    }


    /**
     * Devuelve el lugar Sagrado al que va a recuperarse (Lago o Templo)
     * @return "L"
     */

    public String getLugar () {

        return "L";
    }
}
