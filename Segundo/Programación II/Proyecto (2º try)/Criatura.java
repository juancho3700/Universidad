/**
 * Clase padre de las criaturas
 */

public class Criatura {

    String id;
    String stats;
    String nombre;
    int vida = 10;
    boolean templo = false;
    boolean lago = false;
    boolean peleo = false;
    int ataque;
    int defensa;
    int visitas = 0;


    /**
     * Metodo que reduce la vida de la criatura
     * @param damage Vida a reducir
     */

    public void reduceVida (int damage) {
        vida-= Math.max (damage, 0);
        
    }
    

    /**
     * Metodo que reduce las estadisticas de la criatura despues de un ataque o defensa
     * @param atq Indica si la criatura ha atacado o defendido
     */
    
    public void reduce (boolean atq) {

    }


    /**
     * Aumenta las estadisticas de la criatura segun los parametros de la visita al Lugar Sagrado correspondiente
     */

    public void visita() {

    }
    

    /**
     * Metodo que devuelve el valor del ataque de la criatura
     * @return Valor del ataque
     */

    public int getAtaque () {
        return ataque;

    }


    /**
     * Metodo que devuelve el valor de la defensa de la criatura
     * @return Valor de la defensa
     */

    public int getDefensa () {
        return defensa;

    }


    /**
     * Metodo que devuelve el nombre de la criatura
     * @return El nombre de la criatura
     */

    public String getNombre () {
        return nombre;

    }


    /**
     * Metodo que devuelve la ID de la criatura
     * @return La ID de la criatura
     */

    public String getId () {
        return id;
        
    }


    /**
     * Metodo que devuelva el valor de la vida de la criatura
     * @return El valor de la vida de la criatura
     */

    public int getVida () {
        return vida;
        
    }


    /**
     * Metodo que devuelve las estadisticas de la criatura
     * @return Las estadisticas de la criatura
     */

    public String getStats () {
        return stats;

    }


    /**
     * Metodo que devuelve el numero de visitas que ha hecho la criatura al Lugar Sagrado correspondiente
     * @return El numero de visitas al Lugar Sagrado
     */

    public int getNVisitas () {
        return visitas;
        
    }


    /**
     * Metodo que devuelve el Lugar Sagrado al que pertenece
     * @return null
     */

    public String getLugar () {
        return null;

    }


    /**
     * Metodo que indica si la criatura ha salido del bosque en la batalla
     * @param haPeleado true en caso de que haya salido del bosque y false en caso de que no
     */

    public void setPeleo (boolean haPeleado) {
        peleo = haPeleado;

    }


    /**
     * Metodo que devuelve los valores de ataque, defesa y vida de la criatura
     * @return Valor del ataque, defensa y vida
     */

    public String getAtts () {
        String atts = ataque + "," + defensa + "," + vida;
        return atts;
        
    }
}