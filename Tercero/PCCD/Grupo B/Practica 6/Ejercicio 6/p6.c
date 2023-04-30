#include <stdio.h>
#include <sys/msg.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct {

    int mtype;
    int nTenedor;

} tenedor;

int idColaExclusion;


void comer (int numFilosofo, int idCola1, int idCola2) {

    tenedor ten [2], sitioComedor;

    printf ("[Filosofo %i] - Buscando sitio en el comedor ...\n", numFilosofo);
    msgrcv (idColaExclusion, &sitioComedor, sizeof (int), 0, 0);

    printf ("[Filosofo %i] - Intentando coger el tenedor %i ...\n", numFilosofo, numFilosofo);
    msgrcv (idCola1, &ten [0], sizeof (int), 0, 0);

    printf ("[Filosofo %i] - Intentando coger el tenedor %i ...\n", numFilosofo, (numFilosofo % 5) + 1);
    msgrcv (idCola2, &ten [1], sizeof (int), 0, 0);

    printf ("[Filosofo %i] - Comiendo ...\n", numFilosofo);

    sleep (12);

    printf ("[Filosofo %i] - Dejando el tenedor %i ...\n", numFilosofo, numFilosofo);
    msgsnd (idCola1, &ten [0], sizeof (int), 0);

    printf ("[Filosofo %i] - Dejando de tenedor %i ...\n", numFilosofo, (numFilosofo % 5) + 1);
    msgsnd (idCola2, &ten [1], sizeof (int), 0);

    printf ("[Filosofo %i] - Levantandose del comedor ...\n", numFilosofo);
    msgsnd (idColaExclusion, &sitioComedor, sizeof (int), 0);

    return;
}


int main (int argc, char const *argv[]) {
    
    int opcion, numFilosofo, idCola [5], i;

    for (i = 0; i < 5; i++) {

        printf ("ID de la cola del tenedor %i: ", i + 1);
        scanf ("%i", &idCola [i]);
    }

    printf ("ID de la cola de exclusion: ");
    scanf ("%i", &idColaExclusion);
    fflush (stdin);

    while (1) {

        printf ("\n   1 - Dar de comer\n   2 - Salir\n   Selecciona una opcion: ");
        scanf ("%i", &opcion);

        switch (opcion) {

            case 1:

                printf ("Selecciona a que filosofo se da de comer: ");
                scanf ("%i", &numFilosofo);
                fflush (stdin);

                comer (numFilosofo, idCola [numFilosofo - 1], idCola [(numFilosofo % 5)]);
                break;

            case 2:

                printf ("Cerrando programa ...\n\n");
                msgctl (idColaExclusion, IPC_RMID, NULL);

                for (i = 0; i < 5; i++) {

                    msgctl (idCola [i], IPC_RMID, NULL);
                }

                return 0;

            default:

                printf ("Seleccion no valida, vuelve a intentarlo\n");
        }
    }

    return 0;
}