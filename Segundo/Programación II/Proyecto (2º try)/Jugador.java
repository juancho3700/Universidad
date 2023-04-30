import java.util.ArrayList;

/**
 * Clase que implementa el jugador
 */

public class Jugador {

    private int puntos = 0;
    private String nombre;
    private String id;
    public ArrayList <Criatura> bichos = new ArrayList <Criatura> ();
    public ArrayList <Criatura> bichosOrdenados = new ArrayList <Criatura> ();


    /**
     * Constructor de la clase Jugador
     * @param nId ID
     * @param nom Nombre
     */

    public Jugador (String nId, String nom) {
        id = nId;
        nombre = nom;

    }


    /**
     * Constructor de la clase Jugador
     */

    public Jugador () {

    }


    /**
     * Metodo que suma puntos al Jugador dependiendo del numero de criaturas vivas
     * @param ps Numero de puntos sumados por criatura viva
     * @return Puntos que se han sumado
     */

    public int sumaPuntos (int ps) {

        int puntosSumados = 0;

        for (Criatura bicho : bichos) {
            if (bicho.getVida () > 0) {
                puntos += ps;
                puntosSumados += ps;

            }
        }

        return puntosSumados;
    }


    /**
     * Metodo que copia un ArrayList de criaturas en el ArrayList propio del Jugador
     * @param nBichos ArrayList a copiar
     */

    public void copiarBichos (ArrayList <Criatura> nBichos) {
        bichos.clear ();
        bichos = nBichos;
        sigueVivo ();

    }


    /**
     * Metodo que mete una a una las criaturas de un ArrayList dado al ArrayList de criaturas propio del Jugador
     * @param nBichos ArrayList a copiar
     */

    public void meterBichos (ArrayList <Criatura> nBichos) {

        bichos.clear ();

        for (int i = 0; i < nBichos.size (); i++) {
            bichos.add (nBichos.get (i));

        }

        sigueVivo ();
    }


    /**
     * Metodo que calcula si el Jugador tiene criaturas vivas o no
     * @return true en caso de que haya alguna criatura viva o false en caso de que no
     */

    public boolean sigueVivo () {

        boolean vivo = false;

        for (Criatura bicho : bichos) {
            if (bicho.getVida () > 0) {
                vivo = true;
                break;

            } else {
                vivo = false;

            }
        }

        return vivo;
    }


    /**
     * Metodo que devuelve la ID de la criatura con mejor ataque o defensa y el valor del mismo
     * @param atq Indica si se precisa la criatura con mejor ataque (true) o mejor defensa (false)
     * @return mejorAtt [0] indica el indice de la mejor criatura y mejorAtt [1] el valor de la estadistica deseada
     */

    public int [] getMejorAtt (boolean atq) {

        int mejorAtt [] = {0, 0};

        for (int i = 0; i < bichos.size (); i++) {

            if (bichos.get (i).getVida () > 0) {

                if (atq == true) {

                    if (bichos.get (i).getAtaque () > mejorAtt [1]) {
                        mejorAtt [0] = i;
                        mejorAtt [1] = bichos.get (i).getAtaque ();

                    } else if (bichos.get (i).getAtaque () == mejorAtt [1]) {
                        if (bichos.get (i).getId ().compareTo (bichos.get (mejorAtt [0]).getId ()) < 0) {

                            mejorAtt[0] = i;
                            mejorAtt[1] = bichos.get (i).getAtaque ();
                        }
                    }

                } else {
                    if (bichos.get (i).getDefensa () > mejorAtt [1]) {
                        mejorAtt [0] = i;
                        mejorAtt [1] = bichos.get (i).getDefensa ();

                    } else if (bichos.get (i).getDefensa () == mejorAtt [1]) {
                        if (bichos.get (i).getId ().compareTo (bichos.get (mejorAtt [0]).getId ()) < 0) {

                            mejorAtt[0] = i;
                            mejorAtt[1] = bichos.get (i).getDefensa ();
                        }
                    }
                }
            } else {
                if (mejorAtt [0] == i) {
                    mejorAtt [0] = Math.min (mejorAtt [0] + 1, bichos.size () - 1);

                }
            }
        }

        for (int i = 0; i < bichos.size (); i++) {

            if (bichos.get (i).getId ().equals (bichos.get (mejorAtt [0]).getId ())) {
                mejorAtt [0] = i;
                break;

            }
        }

        return mejorAtt;
    }


    /**
     * Metodo que devuelve los puntos del Jugador
     * @return Los puntos del Jugador
     */

    public int getPuntos () {
        return puntos;

    }


    /**
     * Metodo que devuelve el nombre del Jugador
     * @return El nombre del Jugador
     */

    public String getNombre () {
        return nombre;

    }


    /**
     * Metodo que devuelve la ID del Jugador
     * @return La ID del Jugador
     */

    public String getId () {
        return id;

    }


    /**
     * Metodo que devuelve el ArrayList de criaturas del Jugador
     * @return El ArrayList de criaturas del Jugador
     */

    public ArrayList <Criatura> getBichos () {
        return bichos;

    }
}
