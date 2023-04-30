import java.util.StringTokenizer;

/**
 * Clase que implementa a la criatura Ninfa
 */

public class Ninfa extends Criatura {

    private int divinidad;
    private int velocidad;
    private int enganho;
    private int varita;
    private int armadura;


    /**
     * Constructor de la clase Ninfa
     * @param atts Nombre, id y atributos de la criatura
     */
    
     public Ninfa (String atts) {

        StringTokenizer separador = new StringTokenizer (atts, " ,");
        String params [] = new String [7];

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
        divinidad = Integer.parseInt (params [2]);
        varita = Integer.parseInt (params [3]);
        velocidad = Integer.parseInt (params [4]);
        enganho = Integer.parseInt (params [5]);
        armadura = Integer.parseInt (params [6]);
        lago = true;
        
        calculaStats ();
    }


    /**
     * Calcula el valor del ataque y la defensa de la Ninfa
     */
    
     private void calculaStats (){

        ataque = divinidad * (velocidad + enganho) + varita / 100;
        defensa = divinidad * (velocidad + enganho) + armadura / 200;
    }
    

    /**
     * Reduce las estadisticas de la Ninfa despues de un ataque o defensa
     * @param atq Indica si la criatura ha atacado o defendido
     */
    
     public void reduce (boolean atq){

        vida -= 2;
        if (atq == true) {
            varita -= 5;

            if (varita < 0) {
                varita = 0;
            }

        } else {
            armadura -= 5;

            if (armadura < 0) {
                armadura = 0;
            }
        }

        if (vida < 0) {
            vida = 0;
            
        }

        calculaStats ();
    }


    /**
     * Aumenta las estadisticas de la Ninfa segun los parametros de la visita al Lago Sagrado
     */
    
     public void visita (){

        if (vida <= 0 || peleo == false) {
            return;

        } else {
            visitas += 1;
            int sumaVida = 2 + 2 * visitas;
            int sumaVarita = 3 * visitas;
            int sumaArmadura = 3 * visitas;

            if (sumaVida + vida > 10) {
                vida = 10;

            } else {
                vida += sumaVida;

            }

            if (sumaVarita + varita > 1000) {
                varita = 1000;

            } else {
                varita += sumaVarita;

            }

            if (sumaArmadura + armadura > 1000) {
                armadura = 1000;

            } else {
                armadura += sumaArmadura;

            }
        }

        if (vida < 0) {
            vida = 0;

        }

        calculaStats ();
    }


    /**
     * Devuelve en un String los atributos de la Ninfa
     * @return Devuelve los atributos
     */

    public String getStats () {

        stats = "D" + divinidad + ",V" + varita + ",R" + velocidad + ",E" + enganho + ",A" + armadura;
        return stats;
    }


    /**
     * Devuelve el Lugar Sagrado al que va a recuperarse (Lago o Templo)
     * @return "L"
     */

    public String getLugar() {

        return "L";
    }
}