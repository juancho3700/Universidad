#include <stdio.h>
#include <stdlib.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <semaphore.h>

#define nNodos 3

typedef struct {

    long mtype;
    float ticket;
    int idOrigen,
        prioridad;

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
      
    int i = 0,
        error = 0,
        zonaMemoria,
        nConfirmaciones = 0,
        prioridadNodo = 0;
    zonaMem * memoria;
    key_t clave = ftok ("/home/selmo/Escritorio/Teleco/Tercero/PCCD/Ejercicio Tickets/", atoi (argv [1]));;
    datos mensajeIn, mensajeOut;

    zonaMemoria = shmget (clave, sizeof (zonaMem), IPC_CREAT | 0777);

    if (zonaMemoria == -1) {

        printf ("Error al crear la zona de memoria compartida. Cerrando programa ...\n\n");
        return 0;
    }

    printf ("\nCreada zona de memoria %i\n", zonaMemoria);
    memoria = shmat (zonaMemoria, NULL, 0);

    memoria->miId = msgget (clave, IPC_CREAT | 0777);

    if (memoria->miId == -1) {

        printf ("Error al crear la cola de mensajes. Cerrando programa ...\n\n");
        return 0;
    }

    printf ("Creada la cola de mensajes con ID %i\n", memoria->miId);

    error = sem_init (&memoria->disputaSC, 1, 0);

    if (error != 0) {

        printf ("Error al inicializar el semaforo de disputa. Cerrando programa ...\n\n");
        return 0;
    }

    error = sem_init (&memoria->entradaSC, 1, 0);

    if (error != 0) {

        printf ("Error al inicializar el semaforo de entrada. Cerrando programa ...\n\n");
        return 0;
    }

    error = sem_init (&memoria->maxProcesos, 1, 0);

    if (error != 0) {

        printf ("Error al inicializar el semaforo maximo. Cerrando programa ...\n\n");
        return 0;
    }

    error = sem_init (&memoria->mutexDatos, 1, 1);

    if (error != 0) {

        printf ("Error al inicializar el semaforo de exlusion. Cerrando programa ...\n\n");
        return 0;
    }

    printf ("Semaforos inicializados\n");

    memoria->minTicket = 0;
    memoria->quiero = 0;
    memoria->pendientes = 0;
    memoria->enSC = 0;
    memoria->esperandoSC = 0;
    memoria->numSinc = atoi (argv [1]);
    memoria->pasesSC = 0;
    memoria->esperandoMax = 0;

    for (i = 0; i < nNodos - 1; i++) {

        printf ("ID de la cola del usuario %i: ", i);
        scanf ("%i", &memoria->idNodos [i]);
    }




    while (1) {
      
        error = msgrcv (memoria->miId, &mensajeIn, sizeof (float) + sizeof (int), 0, 0);

        if (error == -1) {

            printf ("Error al recibir el mensaje. Reintentando ...\n");

        } else if (mensajeIn.mtype == 2) {

            nConfirmaciones ++;

            if (nConfirmaciones == (nNodos - 1)) {

                sem_post (&memoria->disputaSC);
                nConfirmaciones = 0;
            }

            printf ("Confirmacion recibida\n");

        } else if ((mensajeIn.prioridad == 5 && prioridadNodo == 5) || 
                    (memoria->quiero == 0 ||
                    (memoria->enSC == 0 &&
                      (memoria->ticket > mensajeIn.ticket ||
                        (memoria->ticket == mensajeIn.ticket &&
                         memoria->miId > mensajeIn.idOrigen))))) {

            memoria->minTicket = max (memoria->minTicket, mensajeIn.ticket);

            mensajeOut.mtype = 2;
            mensajeOut.ticket = 0;
            mensajeOut.idOrigen = memoria->miId;
            mensajeOut.prioridad = 0;

            do {

                error = msgsnd (mensajeIn.idOrigen, &mensajeOut, sizeof (float) + sizeof (int), 0);

                if (error != 0) {

                    printf ("Error al enviar la confirmacion. Reintentando ...\n");
                }

            } while (error != 0);

            printf ("Peticion confirmada\n");

        } else {

            memoria->colaNodos [memoria->pendientes] = mensajeIn.idOrigen;
            memoria->pendientes ++;
        }
    }
}

