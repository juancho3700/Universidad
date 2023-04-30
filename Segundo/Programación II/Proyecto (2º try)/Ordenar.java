import java.util.Comparator;

/**
 * Clase que implementa el Comparator para ordenar las criaturas
 */

public class Ordenar implements Comparator <Criatura> {

    /**
     * Compara dos criaturas y devuelve 1 o -1 dependiendo de si una es mayor que la otra o al reves
     * @param bicho1 Primera criatura a comparar
     * @param bicho2 Segunda criatura a comparar
     * @return Devuelve 1 en caso de que la ID de bicho1 sea mayor y -1 en cualquier otro caso
     */

    public int compare (Criatura bicho1, Criatura bicho2) {

        int i1, i2;
        String clases = "belnow";

        if (bicho1.getId ().charAt (0) == bicho2.getId ().charAt (0)) {
            i1 = Integer.parseInt (bicho1.getId ().substring (1));
            i2 = Integer.parseInt (bicho2.getId ().substring (1));

        } else {
            i1 = clases.indexOf (bicho1.getId ().charAt (0));
            i2 = clases.indexOf (bicho2.getId ().charAt (0));

        }

        if (i1 > i2) {
            return 1;

        } else {
            return -1;

        }
    }
}