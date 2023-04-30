/*
    No hemos conseguido hacer que funcione el mutexDatos por algun motivo.
    Sin ese semaforo funciona perfecto, y los lugares donde deberia estar esta comentado
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <math.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <pthread.h>
#include <semaphore.h>

#define nNodos 3
#define maxPasesSC 2

typedef struct {

    long mtype;
    float ticket;
    int idOrigen;

} datos;

typedef struct {

    sem_t disputaSC,
        entradaSC,
        maxProcesos,
        mutexDatos;

    float ticket,
        minTicket;

    int quiero,
        miId,
        idNodos [nNodos - 1],
        colaNodos [nNodos - 1],
        pendientes,
        esperandoSC,
        enSC,
        pasesSC,
        numSinc,
        esperandoMax;

} zonaMem;

float max (float n1, float n2) {

    return (n1 > n2) ? n1 : n2;
}

int main (int argc, char const *argv[]) {

    int i, error = 0, zonaMemoria;
    key_t clave = ftok ("/home/selmo/Escritorio/Teleco/Tercero/PCCD/Ejercicio Tickets/", atoi (argv [1]));
    zonaMem * memoria;
    datos mensaje;

    zonaMemoria = shmget (clave, sizeof (zonaMem), 0);

    if (zonaMemoria == -1) {

        printf ("Error al encontrar la zona de memoria compartida. Cerrando programa ...\n\n");
        return 0;
    }
    
    memoria = shmat (zonaMemoria, NULL, 0);
    printf ("Enlazado en la zona de memoria %i\n", zonaMemoria);

    while (1) {

        printf ("\nEsperando ...\n");
        fflush (stdin);
        while (getchar () != '\n');
        printf ("Pasadita\n");

        // sem_wait (&memoria->mutexDatos);
        printf ("Get semafored");
        if (memoria->pasesSC == maxPasesSC) {

            memoria->esperandoMax ++;
            //sem_post (&memoria->mutexDatos);
            sem_wait (&memoria->maxProcesos);

            // sem_wait (&memoria->mutexDatos);
            memoria->esperandoMax --;
            memoria->pasesSC ++;

            if (memoria->esperandoMax > 0 && memoria->pasesSC < maxPasesSC) {

                sem_post (&memoria->maxProcesos);
            }

            //sem_post (&memoria->mutexDatos);
        }

        // sem_wait (&memoria->mutexDatos);
        memoria->esperandoSC ++;
        memoria->pasesSC ++;

        if (memoria->esperandoSC == 1 && memoria->enSC == 0) {

            //sem_post (&memoria->mutexDatos);
            printf ("Disputando la SC ...\n");

            srand ((unsigned) time (NULL));
            memoria->ticket = memoria->minTicket + (float) ((rand () % 1000) / 1000.0f);
            printf ("Ticket creado: %.3f\n", memoria->ticket);

            memoria->minTicket = max (memoria->minTicket, memoria->ticket);
            memoria->quiero = 1;

            mensaje.mtype = 1;
            mensaje.idOrigen = memoria->miId;
            mensaje.ticket = memoria->ticket;

            for (i = 0; i < nNodos - 1; i++) {

                do {

                    error = msgsnd (memoria->idNodos [i], &mensaje, sizeof (float) + sizeof (int), 0);

                    if (error == -1) {

                        printf ("Error al enviar la peticion al nodo %i. Reintentando ...\n", i);
                    }

                } while (error != 0);
            }

            printf ("Mensajes enviados correctamente\n");

            sem_wait (&memoria->disputaSC);
            printf ("Mensajes recibidos correctamente\n");

        } else {

            //sem_post (&memoria->mutexDatos);
            printf ("Esperando por la SC ...\n");
            sem_wait (&memoria->entradaSC);
        }

        // sem_wait (&memoria->mutexDatos);
        memoria->esperandoSC --;
        memoria->enSC ++;
        //sem_post (&memoria->mutexDatos);

        printf ("En la Seccion Critica\n");
        fflush (stdin);
        while (getchar () != '\n');

        printf ("Saliendo de la Seccion Critica ...\n");
        // sem_wait (&memoria->mutexDatos);
        memoria->enSC --;

        if (memoria->esperandoSC == 0) {

            memoria->quiero = 0;
            memoria->pasesSC = 0;
            if (memoria->esperandoMax > 0) {

                sem_post (&memoria->maxProcesos);
            }

            //sem_post (&memoria->mutexDatos);

            mensaje.mtype = 2;
            mensaje.idOrigen = memoria->miId;
            mensaje.ticket = 0;

            for (i = 0; i < memoria->pendientes; i++) {

                do {

                    error = msgsnd (memoria->colaNodos [i], &mensaje, sizeof (float) + sizeof (int), 0);

                    if (error != 0) {

                        printf ("Error al enviar la confirmacion al nodo pendiente %i. Reintendando ...\n", i);
                    }

                } while (error != 0);
            }

            printf ("Confirmaciones enviadas correctamente\n");

        } else {

            //sem_post (&memoria->mutexDatos);
            sem_post (&memoria->entradaSC);
        }
    }
}
