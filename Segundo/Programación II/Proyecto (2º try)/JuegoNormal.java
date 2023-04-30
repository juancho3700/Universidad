import java.util.ArrayList;
import java.util.Collections;
import java.util.StringTokenizer;

/**
 * Clase que implementa el modo de juego normal
 */

public class JuegoNormal {

    private String ficheroJugadores = null;
    private String ficheroCriaturas = null;
    private String ficheroReparto = null;
    private String ficheroPartida = null;


    /**
     * Constructor de la clase JuegoNormal
     * @param f1 Fichero de jugadores
     * @param f2 Fichero de criaturas
     * @param f3 Fichero de reparto
     * @param f4 Fichero de salida
     */

    public JuegoNormal (String f1, String f2, String f3, String f4) {

        ficheroJugadores = f1;
        ficheroCriaturas = f2;
        ficheroReparto = f3;
        ficheroPartida = f4;

    }


    /**
     * Metodo que carga los jugadores y criaturas de sus correspondientes ficheros antes de comenzar la partida
     */

    public void inicioPartidaNormal () {

        ArrayList <Jugador> jugadores = new ArrayList <Jugador> ();
        ArrayList <Criatura> bichos = new ArrayList <Criatura> ();
        String error = "ok";
        Comanditos comandos = new Comanditos ();

        comandos.cargarJugadores (ficheroJugadores);
        comandos.cargarCriaturas (ficheroCriaturas);

        jugadores = comandos.getJugadores ();
        bichos = comandos.getBichos ();

        error = this.partida (jugadores, bichos);

        if (error.equals ("FAIL.")) {
            System.out.println ("No se ha podido leer / escribir el fichero deseado.");

        }
    }


    /**
     * Metodo que ejecuta la partida en modo normal
     * @param jugadores Jugadores con los que se va a jugar
     * @param bichos Criaturas con las que se va a jugar
     * @return "OK." en caso de no haber ningun error en la ejecucion y "FAIL." en cualquier otro caso
     */

    public String partida (ArrayList <Jugador> jugadores, ArrayList <Criatura> bichos) {

        ArrayList <Criatura> bichosAux = new ArrayList <Criatura> ();
        ArrayList <Jugador> jugadoresPartida = new ArrayList <Jugador> ();
        ArrayList <Jugador> jugadoresSalida = new ArrayList <Jugador> ();
        boolean fin = false, sobreescribir = false, error = false;
        String lineaEntrada [] = {"", null};
        String lineaSalida = null, token = "";
        int sumaPuntos = 0, nBatallas = 1, nLineas = 0;

        if (jugadores.size () < 2) {
            return "FAIL.";

        } else if (bichos.size () < Math.min (jugadores.size (), 4)) {
            return "FAIL.";

        }

        do {

            int atq = 0;
            jugadoresPartida.clear ();

            for (Criatura bicho : bichos) {
                bicho.setPeleo (false);

            }

            if (ficheroReparto == null) {

                int bpj = Math.min ((int) Math.floor (bichos.size () / jugadores.size ()), 3);
                int maxJs = Math.min (jugadores.size (), 4);
                Collections.shuffle (bichos);

                for (int i = 0; i < maxJs; i++) {

                    jugadoresPartida.add (jugadores.get (i));
                    bichosAux.clear ();

                    if (nBatallas == 1) {
                        jugadoresSalida.add (jugadores.get (i));

                    }

                    for (int j = i * bpj; j < bpj * (i + 1); j++) {
                        bichosAux.add (bichos.get (j));
                        bichosAux.get (j).setPeleo (true);

                    }

                    jugadoresPartida.get (i).meterBichos (bichosAux);
                    jugadoresSalida.get (i).copiarBichos (jugadoresPartida.get (i).getBichos ());
                    bichosAux.clear();
                }

            } else {

                lineaEntrada = GestorFichero.leerLineaFichero (ficheroReparto, nLineas);

                if (lineaEntrada [0] == null) {
                    nLineas = 0;
                    lineaEntrada = GestorFichero.leerLineaFichero (ficheroReparto, nLineas);
                }

                StringTokenizer separador = new StringTokenizer (lineaEntrada [0], ",{}:");

                if (lineaEntrada [1] != "ok") {
                    return "FAIL.";

                }

                do {

                    token = separador.nextToken ();

                    if (separador.countTokens () == 15 || separador.countTokens () == 11 ||
                        separador.countTokens () == 7 || separador.countTokens () == 3) {

                        for (Jugador jugador : jugadores) {

                            if (jugador.getId ().equals (token)) {
                                jugadoresPartida.add (jugador);

                                if (nBatallas == 1) {
                                    jugadoresSalida.add (jugador);

                                }

                                break;
                            }
                        }

                    } else if (token == "") {

                    } else {

                        for (Criatura bicho : bichos) {

                            if (bicho.getId ().equals (token)) {
                                bicho.setPeleo (true);
                                bichosAux.add (bicho);
                                break;

                            }
                        }
                    }

                    if (separador.countTokens () == 12 || separador.countTokens () == 8 ||
                        separador.countTokens () == 4 || separador.countTokens () == 0) {

                        jugadoresPartida.get (jugadoresPartida.size () - 1).meterBichos (bichosAux);
                        bichosAux.clear ();

                    }

                } while (separador.hasMoreTokens ());

                nLineas++;
            }

            lineaSalida = "BATALLA_" + nBatallas + " ";

            for (Jugador jugador : jugadoresSalida) {
                lineaSalida += jugador.getId () + ":{";

                for (Criatura bicho : jugador.bichos) {
                    lineaSalida += "(" + bicho.getId () + "," + bicho.getVida () + "),";

                }

                lineaSalida = lineaSalida.substring (0, lineaSalida.length () - 1) + "},";
            }

            lineaSalida = lineaSalida.substring (0, lineaSalida.length () - 1) + "\n";

            for (int j = 0; j < jugadoresPartida.size (); j++) {

                if (jugadoresPartida.get (j).sigueVivo () == false) {

                    jugadoresPartida.remove (j);
                    j--;
                }
            }

            for (int nLuchas = 1; nLuchas <= 10; nLuchas++) {                
                
                for (int j = 0; j < jugadoresPartida.size (); j++) {
                    
                    if (jugadoresPartida.get (j).sigueVivo () == false) {
                        
                        jugadoresPartida.remove (j);
                    }
                }
                
                if (jugadoresPartida.size () == 0) {
                    lineaSalida += "\n  FIN BATALLA: No hay jugadores activos.\n";
                    break;
                    
                } else if (jugadoresPartida.size () == 1) {
                    lineaSalida += "\n  FIN BATALLA: Solo hay un jugador activo.\n";
                    break;
    
                }

                int def = atq + 1;
                lineaSalida += "  LUCHA " + nLuchas + ": ";

                if (def == jugadoresPartida.size ()) {
                    def = 0;
                }

                int mejorAtq [] = jugadoresPartida.get (atq).getMejorAtt (true);
                int mejorDef [] = jugadoresPartida.get (def).getMejorAtt (false);

                Jugador jugador = jugadoresPartida.get (atq);
                Criatura bicho = jugador.bichos.get (mejorAtq [0]);

                bicho.setPeleo (true);

                lineaSalida += jugador. getId() + "-" + bicho.getId ().toUpperCase ()
                               .charAt(0);

                if (lineaSalida.charAt (lineaSalida.length () - 1) == 'W') {
                    lineaSalida = lineaSalida.substring (0, lineaSalida.length () - 2) + "-B";
                
                }

                lineaSalida += ":{" + bicho.getId () + "," + bicho.getNombre () + "," +
                               bicho.getStats () + "} --> ";

                jugador = jugadoresPartida.get (def);
                bicho = jugador.bichos.get (mejorDef [0]);

                bicho.setPeleo (true);

                lineaSalida += jugador.getId () + "-" + bicho.getId ().toUpperCase ()
                               .charAt (0);

                if (lineaSalida.charAt (lineaSalida.length () - 1) == 'W') {
                    lineaSalida = lineaSalida.substring (0, lineaSalida.length() - 2) + "-B";

                }

                lineaSalida += ":{" + bicho.getId () + "," + bicho.getNombre () + "," +
                               bicho.getStats () + "}\n";

                jugadoresPartida.get (def).bichos.get (mejorDef [0]).reduceVida (mejorAtq [1] - mejorDef [1]);
                jugadoresPartida.get (atq).bichos.get (mejorAtq [0]).reduce (true);
                jugadoresPartida.get (def).bichos.get (mejorDef [0]).reduce (false);

                for (int j = 0; j < jugadoresPartida.size (); j++) {

                    if (jugadoresPartida.get (j).sigueVivo () == false) {
                        jugadoresPartida.remove (j);
                        
                        if (j <= atq) {
                            atq--;
                            
                        }
                        
                        j -= 1;
                    }
                }


                lineaSalida += "  ";
                for (Jugador jjAux : jugadoresSalida) {
                    lineaSalida += "" + jjAux.getId () + ":{";

                    for (Criatura bAux : jjAux.bichos) {
                        lineaSalida += "(" + bAux.getId () + "," + bAux.getVida () + "),";

                    }

                    lineaSalida = lineaSalida.substring (0, lineaSalida.length () - 1) + "},";
                }

                lineaSalida = lineaSalida.substring (0, lineaSalida.length () - 1) + "\n";

                atq++;

                if (atq == jugadoresPartida.size ()) {
                    atq = 0;

                }

                if (nLuchas == 10) {
                    lineaSalida += "\n  FIN BATALLA: Ya se han producido 10 luchas.\n";

                }

            } // Fin del for de las luchas

            nBatallas++;

            if (jugadoresPartida.size () <= 1) {
                sumaPuntos = 2;

            } else {
                sumaPuntos = 1;

            }

            lineaSalida += "  PUNTOS CONSEGUIDOS: ";

            for (Jugador jugador : jugadoresSalida) {
                lineaSalida += jugador.getId () + "=" + jugador.sumaPuntos (sumaPuntos) + ",";

            }

            lineaSalida = lineaSalida.substring (0, lineaSalida.length () - 1) + "\n\n";


            for (Criatura bicho : bichos) {

                if (bicho.getVida () > 0) {
                    fin = false;
                    break;

                } else {
                    fin = true;

                }
            }

            for (Criatura bicho : bichos) {
                bicho.visita ();
                bicho.setPeleo (false);

            }

            for (Jugador jugador : jugadoresSalida) {

                if (jugador.getPuntos () >= 10) {

                    fin = true;
                    break;
                }
            }

            error = GestorFichero.escribirFichero (lineaSalida, ficheroPartida, sobreescribir);
            sobreescribir = true;

            if (error == true) {
                return "FAIL.";

            }

        } while (fin == false);

        lineaSalida = "VISITAS A LOS LUGARES SAGRADOS:\n  Lago Sagrado: {";

        Collections.sort (bichos, new Ordenar());

        for (Criatura bicho : bichos) {

            if (bicho.getNVisitas () > 0 && bicho.getLugar ().equals ("L")) {
                lineaSalida += bicho.getId () + "=" + bicho.getNVisitas () + ", ";

            }
        }

        lineaSalida = lineaSalida.substring (0, lineaSalida.length () - 2) + "}\n  Templo Maldito: {";

        for (Criatura bicho : bichos) {

            if (bicho.getNVisitas () > 0 && bicho.getLugar ().equals ("T")) {
                lineaSalida += bicho.getId () + "=" + bicho.getNVisitas () + ", ";

            }
        }

        lineaSalida = lineaSalida.substring (0, lineaSalida.length () - 2) + "}\n\nPUNTUACIONES:\n";
        String idVencedor = FuncionesVarias.getVencedor (jugadoresSalida);

        for (Jugador jugador : jugadoresSalida) {
            lineaSalida += "  " + jugador.getNombre () + " (" + jugador.getId () + ") = " + jugador.getPuntos ();

            if (idVencedor.equals (jugador.getId ())) {

                if (jugador.getPuntos () >= 10) {
                    lineaSalida += " (VENCEDOR)";

                }
            }

            lineaSalida += "\n";
        }

        error = GestorFichero.escribirFichero (lineaSalida, ficheroPartida, sobreescribir);

        if (error == true) {
            return "FAIL.";

        } else {
            return "OK.";

        }
    }
}
