import java.util.ArrayList;
import java.util.Collections;

/**
 * Clase que implementa enteramente el juego por comandos
 */

public class Comanditos {

    private ArrayList <Criatura> bichos = new ArrayList <Criatura> ();
    private ArrayList <Jugador> jugadores = new ArrayList <Jugador> ();


    /**
     * Devuelve el ArrayList de jugadores guardados
     * @return Los jugadores guardados
     */

    public ArrayList <Jugador> getJugadores () {
        return jugadores;

    }


    /**
     * Devuelve el ArrayList de criaturas guardadas
     * @return Las criaturas guardadas
     */

    public ArrayList <Criatura> getBichos () {
        return bichos;

    }


    /**
     * Metodo que selecciona el comando que se esta utilizando y escribe los resultados
     * @param ficheroInstrucciones Fichero de instrucciones
     * @param ficheroSalida Fichero en el que se escribe la salida
     */

    public void comanditos (String ficheroInstrucciones, String ficheroSalida) {

        String res = "";
        boolean sobreescribir = false;
        String linea [] = {null, "ok"};
        String opcCom [] = {"#", "", "CargarJugadores", "CrearJugador", "BorrarJugador",
                            "VolcarJugadores", "CargarCriaturas", "CrearNinfa", "CrearOrco",
                            "CrearBruja", "CrearElfo", "CrearLamia", "BorrarCriatura",
                            "VolcarCriaturas", "MostrarCriatura", "Atacar", "VisitarLugarSagrado",
                            "GenerarAsignacionCriaturas", "JugarPartida"};
        int sel = 0;

        linea = GestorFichero.leerLineaFichero (ficheroInstrucciones, 0);

        for (int i = 1; linea [0] != null; i++) {

            String params [] = linea [0].split (" ", 2);

            for (int j = 0; j < opcCom.length; j++) {

                if (params [0].equals(opcCom [j])) {
                    sel = j;
                    break;

                }
            }

            switch (sel) {

                case 0:
                    break;

                case 1:
                    break;

                case 2:
                    res = cargarJugadores (params [1]);
                    break;

                case 3:
                    res = crearJugador (params [1]);
                    break;

                case 4:
                    res = borrarJugador (params [1]);
                    break;

                case 5:
                    res = volcarJugadores (params [1]);
                    break;

                case 6:
                    res = cargarCriaturas (params [1]);
                    break;

                case 7:
                    res = crearNinfa (params [1]);
                    break;

                case 8:
                    res = crearOrco (params [1]);
                    break;

                case 9:
                    res = crearBruja (params [1]);
                    break;

                case 10:
                    res = crearElfo (params [1]);
                    break;

                case 11:
                    res = crearLamia (params [1]);
                    break;

                case 12:
                    res = borrarCriatura (params [1]);
                    break;

                case 13:
                    res = volcarCriaturas (params [1]);
                    break;

                case 14:
                    res = mostrarCriatura (params [1]);
                    break;

                case 15:
                    res = atacar (params [1]);
                    break;

                case 16:
                    res = visitarLugarSagrado (params [1]);
                    break;

                case 17:
                    res = generarAsignacionCriaturas (params [1]);
                    break;

                case 18:
                    res = jugarPartida (params [1]);
                    break;

            }

            if (sel != 0 && sel != 1){

                linea [0] += ": " + res + "\n";
                GestorFichero.escribirFichero (linea[0], ficheroSalida, sobreescribir);
                sobreescribir = true;

            }

            linea = GestorFichero.leerLineaFichero (ficheroInstrucciones, i);
        }
    }


    /**
     * Metodo que carga los jugadores del fichero de jugadores
     * @param entrada Fichero de jugadores
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String cargarJugadores (String entrada) { // Entrada = fichero
                                                     // Funciona

        int i = 0;
        String linea [] = GestorFichero.leerLineaFichero (entrada, i);
        String id = null, nombre = null;

        while (linea [0] != null) {

            if(linea[1] != "ok"){
                return "FAIL.";

            }

            for (int j = 0; i < linea [0].length (); j++) {

                if (linea [0].charAt (j) == ':') {

                    id = linea [0].substring (0, j);
                    nombre = linea [0].substring (j + 2, linea [0].length () - 1);
                    break;
                }
            }


            jugadores.add (new Jugador (id, nombre));
            i++;
            linea = GestorFichero.leerLineaFichero (entrada, i);

        }
        return "OK.";

    }


    /**
     * Metodo que crea un nuevo jugador en caso de no existir ninguno con la ID proporcionada
     * @param entrada ID + nombre
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String crearJugador (String entrada) { // Entrada = id, nombre
                                                  // Funciona

        String params [] = entrada.split (" ", 2);

        for (Jugador jugador : jugadores){

            if (jugador.getId ().equals (params[0])){
                return "FAIL.";

            }
        }

        jugadores.add (new Jugador (params [0], params [1]));
        return "OK.";


    }


    /**
     * Metodo que borra el jugador con la ID proporcionada en caso de que exista
     * @param entrada ID
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String borrarJugador (String entrada) { // Entrada = id
                                                   // Funciona

        for (int i = 0; i < jugadores.size (); i++) {

            if (jugadores.get (i).getId ().equals (entrada)) {

                jugadores.remove (i);
                return "OK.";
            }
        }
        return "FAIL.";
    }


    /**
     * Metodo que vuelca los jugadores guardados en el fichero proporcionado
     * @param entrada Fichero en el que se vuelcan los jugadores
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String volcarJugadores (String entrada) { // Entrada = fichero
                                                     // Funciona

        boolean error = false, sobreescribir = false;
        String linea = "", id, nombre;

        for (Jugador jugador : jugadores) {

            id = jugador.getId ();
            nombre = jugador.getNombre ();
            linea = id + ":{" + nombre + "}\n";
            error = GestorFichero.escribirFichero (linea, entrada, sobreescribir);


            if (error == true){
                return "FAIL.";
            }

            sobreescribir = true;
        }

        return "OK.";
    }


    /**
     * Metodo que carga las criaturas del fichero de criaturas
     * @param entrada Fichero de criaturas
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String cargarCriaturas (String entrada) { // Entrada = fichero
                                                     // Funciona

        int i = 0;
        String linea [] = GestorFichero.leerLineaFichero (entrada, i);

        while (linea [0] != null) {

            if (linea [1] != "ok"){
                return "FAIL.";
            }

            char tipo = linea [0].charAt (0);
            String atts = linea [0].substring (3, linea [0].length () - 1);

            switch (tipo) {

                case 'O':
                    bichos.add (new Orco (atts));
                    break;

                case 'N':
                    bichos.add (new Ninfa (atts));
                    break;

                case 'E':
                    bichos.add (new Elfo (atts));
                    break;

                case 'B':
                    bichos.add (new Bruja (atts));
                    break;

                case 'L':
                    bichos.add (new Lamia (atts));
                    break;
            }

            i++;
            linea = GestorFichero.leerLineaFichero (entrada, i);
        }

        return "OK.";
    }


    /**
     * Metodo que crea una Ninfa en caso de no existir otra criatura con la ID proporcionada
     * @param entrada ID + nombre + atributos
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String crearNinfa (String entrada) { // Entrada = id, nombre, div, vel, eng, var, arm
                                                // Funciona

        String params[] = entrada.split (" ");

        for( Criatura bicho : bichos){
            if (bicho.getId ().equals (params[0])){
                return "FAIL.";

            }
        }

        entrada = params [0] + " " + params [1] + " " + params [2] + " " + params [5] + " " +
                  params [3] + " " + params [4] + " " + params [6];

        bichos.add (new Ninfa (entrada));
        return "OK.";
    }


    /**
     * Metodo que crea un Orco en caso de no existir otra criatura con la ID proporcionada
     * @param entrada ID + nombre + atributos
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String crearOrco (String entrada) { // Entrada = id, nombre, fue, gar, esc
                                               // Funciona

        String params [] = entrada.split (" ",2);

        for(Criatura bicho : bichos){
            if (bicho.getId ().equals (params[0])){
                return "FAIL.";
            }
        }
        bichos.add (new Orco (entrada));
        return "OK.";
    }


    /**
     * Metodo que crea una Bruja en caso de no existir otra criatura con la ID proporcionada
     * @param entrada ID + nombre + atributos
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String crearBruja (String entrada) { // Entrada = id, nombre, sab, mag, bas, ves
                                                // Funciona

        String params [] = entrada.split (" ",2);

        for (Criatura bicho : bichos){
            if (bicho.getId ().equals (params[0])){
                return "FAIL.";
            }
        }
        bichos.add (new Bruja (entrada));
        return "OK.";
    }


    /**
     * Metodo que crea un Elfo en caso de no existir otra criatura con la ID proporcionada
     * @param entrada ID + nombre + atributos
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String crearElfo (String entrada) { // Entrada = id, nombre, inte, arc, cor
                                               // Funciona

        String params [] = entrada.split (" ",2);

        for(Criatura bicho : bichos){
            if (bicho.getId ().equals (params[0])){
                return "FAIL.";
            }
        }
        bichos.add (new Elfo (entrada));
        return "OK.";
    }


    /**
     * Metodo que crea una Lamia en caso de no existir otra criatura con la ID proporcionada
     * @param entrada ID + nombre + atributos
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String crearLamia (String entrada) { // Entrada = id, nombre, ast, sed, gar, mit
                                                // Funciona

        String params[] = entrada.split(" ",2);

        for (Criatura bicho : bichos){
            if (bicho.getId ().equals (params[0])){
                return "FAIL.";
            }
        }
        bichos.add (new Lamia (entrada));
        return "OK.";
    }


    /**
     * Metodo que borra la criatura con la ID proporcionada en caso de que exista
     * @param entrada ID
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String borrarCriatura (String entrada) { // Entrada = id
                                                    // Funciona

        for (int i = 0; i < bichos.size (); i++) {

            if (bichos.get (i).getId ().equals (entrada)) {

                bichos.remove (i);
                return "OK.";
            }
        }
        return "FAIL.";
    }


    /**
     * Metodo que vuelca las criaturas guardadas en el fichero proporcionado
     * @param entrada Fichero en el que se vuelcan las criaturas
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String volcarCriaturas (String entrada) { // Entrada = fichero
                                                     // Funciona

        String linea, id, nombre;
        boolean error = false, sobreescribir = false;

        ArrayList <Criatura> criaturas = bichos;
        Collections.sort (criaturas, new Ordenar ());

        for (Criatura bicho : criaturas) {
            id = bicho.getId ();
            nombre = bicho.getNombre ();

            linea = Character.toUpperCase (id.charAt (0)) + ":{" + id + "," + nombre + "," + bicho.getStats () + "}\n";

            if (linea.charAt (0) == 'W') {
                linea = "B" + linea.substring (1, linea.length ());

            }

            error = GestorFichero.escribirFichero (linea, entrada, sobreescribir);

            if (error == true) {
                return "FAIL.";
            }

            sobreescribir = true;
        }

        return "OK.";
    }


    /**
     * Muestra la criatura con ID proporcionada en caso de que exista
     * @param entrada ID
     * @return "OK" + datos de la criatura en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String mostrarCriatura (String entrada) { // Entrada = id
                                                     // Funciona

        for (Criatura bicho : bichos) {

            if (bicho.getId ().equals (entrada)) {

                String linea = Character.toUpperCase (bicho.getId ().charAt (0)) + ":{" + bicho.getId () + ","
                               + bicho.getNombre () + "," + bicho.getStats () + "," + bicho.getAtts () + "}";

                if (linea.charAt (0) == 'W') {
                    linea = "B" + linea.substring (1, linea.length ());
                }

                return linea;
            }
        }

        return "FAIL.";
    }


    /**
     * Metodo con el que la criatura ID1 ataca a la criatura ID2 en caso de que ambas existan
     * @param entrada ID atacante + ID defensor
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String atacar (String entrada) { // Entrada = idAtq, idDef

        boolean iAt = false, iDef = false, error = true;
        String params [] = entrada.split (" ", 2);
        ArrayList <Criatura> nBichos = new ArrayList <Criatura> ();

        for (Criatura bicho : bichos) {

            if (params [0].equals (bicho.getId ())) {

                if (nBichos.size () == 1) {
                    nBichos.add (nBichos.get (0));
                    nBichos.set (0, bicho);

                } else {
                    nBichos.add (bicho);

                }

                iAt = true;

            } else if (params [1].equals (bicho.getId ())) {
                nBichos.add (bicho);
                iDef = true;

            }

            if (iAt == true && iDef == true) {
                error = false;
                break;

            }
        }

        if (error == true) {
            return "FAIL.";
        }

        nBichos.get (1).reduceVida (nBichos.get (0).getAtaque () - nBichos.get (1).getDefensa ());

        nBichos.get (0).reduce (true);
        nBichos.get (1).reduce (false);

        return "OK.";
    }


    /**
     * Metodo con el que la criatura con ID proporcionada, en caso de existir, visita el Lugar Sagrado al que va a recuperarse
     * @param entrada ID
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String visitarLugarSagrado (String entrada) { // Entrada = id

        for (int i = 0; i < bichos.size (); i++) {

            if (bichos.get (i).getId ().equals (entrada)) {

                bichos.get (i).setPeleo (true);
                bichos.get (i).visita ();
                bichos.get (i).setPeleo (false);
                return "OK.";
            }
        }

        return "FAIL.";
    }


    /**
     * Metodo que genera un fichero de reparto con los jugadores y criaturas guardados
     * @param entrada Numero de repartos + fichero en el que escribirlos
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String generarAsignacionCriaturas (String entrada) { // Entrada = numLineas, fichero
                                                                // Funciona

        if (jugadores.size () < 2 || bichos.size () < Math.min (jugadores.size (), 4)) {
            return "FAIL.";

        }

        String params [] = entrada.split (" ", 2);
        String linea = new String ();
        boolean error = false, sobreescribir = false;
        int nJs = Math.min (jugadores.size (), 4); // numero de jugadores
        int bpj = Math.min ((int) Math.floor (bichos.size () / jugadores.size ()), 3); // bichos/jugador

        for (int i = 0; i < Integer.parseInt (params [0]); i++) {

            Collections.shuffle (bichos);
            linea = "";

            for (int j = 0; j < nJs; j++) {
                linea += jugadores.get (j).getId () + ":{";

                for (int k = bpj * j; k < bpj * (j + 1); k++) {

                    linea += bichos.get (k).getId ();

                    if (k < bpj * (j + 1) - 1) {
                        linea += ",";

                    }
                }

                linea += "}";

                if (j < nJs - 1) {
                    linea += ",";

                }
            }

            linea += "\n";
            error = GestorFichero.escribirFichero (linea, params [1], sobreescribir);
            sobreescribir = true;

            if (error == true) {
                return "FAIL.";

            }
        }

        return "OK.";
    }


    /**
     * Metodo con el que se juega una partida en modo normal con los jugadores y criaturas guardados
     * @param entrada fichero del reparto de criaturas + fichero de salida
     * @return "OK." en caso de no haber error y "FAIL." en cualquier otro caso
     */

    public String jugarPartida (String entrada) { // Entrada = ficheroReparto, ficheroSalida

        String params [] = entrada.split (" ", 2);
        String error = null;

        JuegoNormal partida = new JuegoNormal (null, null, params [0], params [1]);
        error = partida.partida (jugadores, bichos);

        return error;
    }
}
