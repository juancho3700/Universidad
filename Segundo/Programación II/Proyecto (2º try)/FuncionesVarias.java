import java.util.ArrayList;

/**
 * Clase que implementa funciones auxiliares
 */

public class FuncionesVarias {
    

    /**
     * Metodo que calcula cual es el jugador vencedor de un ArrayList dado
     * @param jugadores ArrayList del que se quiere saber el vencedor
     * @return ID del jugador vencedor
     */

    public static String getVencedor (ArrayList <Jugador> jugadores) {
        
        String idVencedor = null;
        int puntosVencedor = 0;
        
        for (Jugador jugador : jugadores) {

            if (jugador.getPuntos () > puntosVencedor) {
                idVencedor = jugador.getId ();
                puntosVencedor = jugador.getPuntos ();

            }
        }
        
        return idVencedor;
    }
}
