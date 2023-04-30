public class MundoEncantado {

    /**
     * Clase principal del programa en la que se selecciona el modo de juego
     * @author Axel Valladares Pazo
     * @author Juan Anselmo Lopez Gomez
     * @param args Lee la linea proporcionada por consola y la interpreta de una forma u otra dependiendo de los parametros insertados
     */
    
    public static void main (String[] args) {

        if (args[0]. equals ("-j")) {

            String ficheroJugadores = null;
            String ficheroCriaturas = null;
            String ficheroReparto = null;
            String ficheroPartida = null;

            ficheroJugadores = args [1];
            ficheroCriaturas = args [3];

            if (args.length == 8) {
                ficheroReparto = args [5];
                ficheroPartida = args [7];

            } else if (args.length == 6) {

                if (args[4]. equals ("-r")) {
                    ficheroReparto = args [5];

                } else {
                    ficheroPartida = args [5];

                }
            }

            JuegoNormal partida = new JuegoNormal (ficheroJugadores, ficheroCriaturas, ficheroReparto, ficheroPartida);
            partida.inicioPartidaNormal ();

        } else if (args[0]. equals ("-i")) {

            String ficheroInstrucciones = null;
            String ficheroSalida = null;

            ficheroInstrucciones = args [1];

            if (args.length == 4) {
                ficheroSalida = args [3];

            }

            Comanditos comandos = new Comanditos ();
            comandos.comanditos (ficheroInstrucciones, ficheroSalida);
        }
    }
}