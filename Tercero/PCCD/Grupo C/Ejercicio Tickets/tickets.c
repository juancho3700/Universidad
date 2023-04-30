#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <math.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <pthread.h>
#include <semaphore.h>

#define nUsuarios 3

typedef struct {

    int mtype;
    float ticket;
    int idOrigen;

} datos;

sem_t entradaSC;
float ticket, minTicket = 0;
int quiero = 0;
int miId;
int colaNodos [nUsuarios - 1], pendientes = 0;

float max (float n1, float n2) {

    return (n1 > n2) ? n1 : n2;
}

void * funRecepcion () {

    int error, nConfirmaciones;
    datos mensajeIn, mensajeOut;

    while (1) {

        error = msgrcv (miId, &mensajeIn, sizeof (mensajeIn.ticket) + sizeof (mensajeIn.idOrigen), 0, 0);

        if (error == -1) {

            printf ("Error al recibir mensaje. Reintentando ...\n\n");

        } else if (mensajeIn.mtype == 2) {

            nConfirmaciones ++;

            if (nConfirmaciones == (nUsuarios - 1)) {

                sem_post (&entradaSC);
                nConfirmaciones = 0;
            }

            printf ("Confirmacion recibida\n");

        } else if (quiero == 0 || ticket > mensajeIn.ticket || (ticket == mensajeIn.ticket && miId > mensajeIn.idOrigen)) {

            minTicket = max (minTicket, mensajeIn.ticket);

            mensajeOut.idOrigen = miId;
            mensajeOut.ticket = 0;
            mensajeOut.mtype = 2;

            do {

                error = msgsnd (mensajeIn.idOrigen, &mensajeOut, sizeof (mensajeIn.ticket) + sizeof (mensajeIn.idOrigen), 0);

                if (error == -1) {

                    perror ("Error al enviar la confirmacion. Reintentando ...\n");
                }
            } while (error != 0);

            printf ("Confirmacion enviada\n");

        } else {

            colaNodos [pendientes] = mensajeIn.idOrigen;
            pendientes ++;
        }
    }
}


int main (int argc, char const *argv[]) {

    key_t clave = ftok ("/home/selmo/Escritorio/Teleco/Tercero/PCCD/Practica 6/", atoi (argv [1]));
    int error, i, idNodos [nUsuarios - 1];
    datos mensajeIn, mensajeOut;
    pthread_t idHilo;

    miId = msgget (clave, IPC_CREAT | 0777);

    if (miId == -1) {

        printf ("Error al crear mi buzon. Cerrando programa ...\n\n");
        return (0);
    }

    printf ("Creado el buzon de ID = %i\n", miId);

    error = sem_init (&entradaSC, 0, 0);

    if (error == -1) {

        printf ("Error al inicializar el semaforo. Cerrando programa ...\n\n");
        return 0;
    }

    for (i = 0; i < nUsuarios - 1; i++) {

        printf ("Introduzca la ID del usuario %i: ", i);
        scanf ("%i", &idNodos [i]);
    }

    error = pthread_create (&idHilo, NULL, funRecepcion, NULL);

    if (error == -1) {

        printf ("Error al crear el hilo de recepcion. Cerrando programa ...\n\n");
        return 0;
    }

    while (1) {

        sleep (1);
        fflush (stdin);
        printf ("\nEsperando ...");
        while (getchar () != 'n');

        srand ((unsigned) time (NULL));
        ticket = minTicket + (float) ((rand () % 1000) / 1000.0f);
        quiero = 1;

        mensajeOut.mtype = 1;
        mensajeOut.ticket = ticket;
        mensajeOut.idOrigen = miId;

        for (i = 0; i < nUsuarios - 1; i++) {

            do {

                error = msgsnd (idNodos [i], &mensajeOut, sizeof (mensajeOut.ticket) + sizeof (mensajeOut.idOrigen), 0);

                if (error == -1) {

                    printf ("Error al enviar la peticion al usuario %i. Reintentando ...\n", i + 1);
                }

            } while (error != 0);
        }

        printf ("Mensajes enviados correctamente\n");

        sem_wait (&entradaSC);

        printf ("Mensajes recibidos correctamente\n");
        printf ("--- SECCION CRITICA ---");
        while (getchar () != 'n');

        mensajeOut.mtype = 2;
        mensajeOut.idOrigen = miId;
        quiero = 0;

        for (i = 0; i < pendientes; i++) {

            do {

                error = msgsnd (colaNodos [i], &mensajeOut, sizeof (mensajeOut.ticket) + sizeof (mensajeOut.idOrigen), 0);

                if (error == -1) {

                    printf ("Error al enviar la confirmacion al usuario pendiente %i. Reintentando ...\n", i);
                }

            } while (error != 0);
        }
    }
}