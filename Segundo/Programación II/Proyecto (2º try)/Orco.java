import java.util.StringTokenizer;

/**
 * Clase que implementa a la criatura Orco
 */

public class Orco extends Criatura {

    private int fuerza;
    private int garrote;
    private int escudo;


    /**
     * Constructor de la clase Orco
     * @param atts Nombre, id y atributos del Orco
     */

    public Orco (String atts) {

        StringTokenizer separador = new StringTokenizer (atts, " ,");
        String params [] = new String [5];

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
        fuerza = Integer.parseInt (params [2]);
        garrote = Integer.parseInt (params [3]);
        escudo = Integer.parseInt (params [4]);
        templo = true;
        
        calculaStats ();
    }


    /**
     * Calcula el valor del ataque y la defensa del Orco
     */

    private void calculaStats () {

        ataque= (fuerza + garrote) / 5;
        defensa= (fuerza + escudo) / 20;
    }


    /**
     * Reduce las estadisticas del Orco despues de un ataque o defensa
     * @param atq Indica si la criatura ha atacado o defendido
     */

    public void reduce (boolean atq){

        if (atq == true) {
            vida -= 1;
            garrote -= 3;

            if (garrote < 0) {
                garrote = 0;

            }
            
        } else {
            vida -= 3;
            escudo -= 3;

            if (escudo < 0) {
                escudo = 0;

            }
        }

        if (vida < 0) {
            vida = 0;
            
        }

        calculaStats ();
    }


    /**
     * Aumenta las estadisticas del Orco segun los parametros de la visita al Templo Maldito
     */

    public void visita (){

        if (vida <= 0 || peleo == false) {
            return;

        } else {
            visitas += 1;
            int sumaGarrote = 2 * visitas;
            int sumaEscudo = visitas;

            if (sumaGarrote + garrote > 90) {
                garrote = 90;

            } else {
                garrote += sumaGarrote;

            }

            if (sumaEscudo + escudo > 90) {
                escudo = 90;

            } else {
                escudo += sumaEscudo;

            }
        }

        calculaStats ();
    }


    /**
     * Devuelve un String los atributos del Orco
     * @return Devuelve los atributos
     */

    public String getStats () {

        stats = "F" + fuerza + ",G" + garrote + ",E" + escudo;
        return stats;
    }


    /**
     * Devuelve el Lugar Sagrado al que va a recuperarse (Lago o Templo)
     */

    public String getLugar () {

        return "T";
    }
}