#include <stdio.h>
#include <sys/msg.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct {

    int mtype;
    int nTenedor;

} tenedor;


void comer (int numFilosofo, int idCola) {

    tenedor ten [2], sitioComedor;

    printf ("[Filosofo %i] - Buscando sitio en el comedor ...\n", numFilosofo);
    msgrcv (idCola, &sitioComedor, sizeof (int), 6, 0);

    printf ("[Filosofo %i] - Intentando coger el tenedor %i ...\n", numFilosofo, numFilosofo);
    msgrcv (idCola, &ten [0], sizeof (int), numFilosofo, 0);

    printf ("[Filosofo %i] - Intentando coger el tenedor %i ...\n", numFilosofo, (numFilosofo % 5) + 1);
    msgrcv (idCola, &ten [1], sizeof (int), (numFilosofo % 5) + 1, 0);

    printf ("[Filosofo %i] - Comiendo ...\n", numFilosofo);

    sleep (20);

    printf ("[Filosofo %i] - Dejando el tenedor %i ...\n", numFilosofo, numFilosofo);
    msgsnd (idCola, &ten [0], sizeof (int), 0);

    printf ("[Filosofo %i] - Dejando de tenedor %i ...\n", numFilosofo, (numFilosofo % 5) + 1);
    msgsnd (idCola, &ten [1], sizeof (int), 0);

    printf ("[Filosofo %i] - Levantandose del comedor ...\n", numFilosofo);
    msgsnd (idCola, &sitioComedor, sizeof (int), 0);

    return;
}


int main (int argc, char const *argv[]) {
    
    int opcion, numFilosofo, idCola = atoi (argv [1]);

    while (1) {

        printf ("\n   1 - Dar de comer\n   2 - Salir\n   Selecciona una opcion: ");
        scanf ("%i", &opcion);
        fflush (stdin);

        switch (opcion) {

            case 1:

                printf ("Selecciona a que filosofo se da de comer: ");
                scanf ("%i", &numFilosofo);
                fflush (stdin);

                comer (numFilosofo, idCola);
                break;

            case 2:

                printf ("Cerrando programa ...\n\n");
                msgctl (idCola, IPC_RMID, NULL);
                return 0;

            default:

                printf ("Seleccion no valida, vuelve a intentarlo\n");
        }
    }

    return 0;
}