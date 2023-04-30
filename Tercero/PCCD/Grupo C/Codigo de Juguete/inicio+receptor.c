#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <semaphore.h>

#include "zonaMemoria.h"


float max (float n1, float n2) {

    return (n1 > n2) ? n1 : n2;
}

int min (int n1, int n2) {

    return (n1 < n2) ? n1 : n2;
}



int main (int argc, char const *argv[]) {

    int i = 0,
        error = 0,
        zonaMemoria;
    zonaMem * memoria;
    key_t clave = ftok ("/home/selmo/Escritorio/Teleco/Tercero/PCCD/Grupo C/", atoi (argv [1]));;
    datos mensajeIn, mensajeOut;

    zonaMemoria = shmget (clave, sizeof (zonaMem), IPC_CREAT | 0777);

    if (zonaMemoria == -1) {

        perror ("Error al crear la zona de memoria compartida. Cerrando programa ...\n\n");
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


    for (i = 0; i < numPrios; i++) {

        error = sem_init(&memoria->entradaSC[i], 1, 0);

        if (error != 0) {

            printf ("Error al inicializar el semaforo de entrada. Cerrando programa ...\n\n");
            return 0;
        }
    }


    error = sem_init (&memoria->maxProcesos, 1, 0);

    if (error != 0) {

        printf ("Error al inicializar el semaforo maximo. Cerrando programa ...\n\n");
        return 0;
    }

    error = sem_init (&memoria->mutexDatos, 1, 1);

    if (error != 0) {

        printf ("Error al inicializar el semaforo de exclusion. Cerrando programa ...\n\n");
        return 0;
    }

    error = sem_init (&memoria->sem_p_consultas, 1, 0);

    if (error != 0) {

        printf ("Error al inicializar el semaforo de consultas. Cerrando programa ...\n\n");
        return 0;
    }

    error = sem_init (&memoria->finConsultas, 1, 0);

    if (error != 0)
    {

        printf("Error al inicializar el semaforo de fin de consultas. Cerrando programa ...\n\n");
        return 0;
    }

    printf ("Semaforos inicializados\n\n\n\n");

    memoria->minTicket = 0;

    memoria->pendientes = 0;
    memoria->esperandoSC = 0;
    memoria->enSC = 0;
    memoria->pasesSC = 0;
    memoria->numSinc = atoi (argv [1]);
    memoria->esperandoMax = 0;
    memoria->prioridadNodo = 0;
    memoria->nConfirmaciones = 0;
    memoria->nProcesosPrio [0] = 0;
    memoria->nProcesosPrio [1] = 0;
    memoria->nProcesosPrio [2] = 0;
    memoria->nProcesosPrio [3] = 0;
    memoria->esperaConsultas = 0;
    memoria->prioridadExterna = 0;
    memoria->bloqueoConsultas = 0;
    memoria->numConsultas = 0;

    for (i = 0; i < nNodos - 1; i++) {

        memoria->idNodos [i] = atoi (argv [i + 2]);
    }

    while (1) {

        do {

            error = msgrcv (memoria->miId, &mensajeIn, sizeof (datos) - sizeof (long), 0, 0);

            if (error == -1) {

                printf ("Error al recibir el mensaje. Reintentando ...\n");

            }

        } while (error == -1);

      
        if (memoria->bloqueoConsultas == 0) {

            memoria->bloqueoConsultas = 1;

            if (memoria->numConsultas > 0) {

                memoria->esperaFinConsultas ++;
                sem_wait (&memoria->finConsultas);
                memoria->esperaFinConsultas --;

                printf ("Consultas terminadas y bloqueadas\n");
            }
        }

        printf ("BloqueoConsultas = %i\n", memoria->bloqueoConsultas);

        switch (mensajeIn.mtype) {

            case 1:

                if (memoria->prioridadNodo > mensajeIn.prioridad && memoria->enSC == 0) {

                    printf ("Reenviando peticiones ...\n");

                    srand((unsigned)time(NULL));
                    memoria->ticket = memoria->minTicket + (float)((rand() % 1000) / 1000.0f);
                    printf("Ticket creado: %.3f\n", memoria->ticket);

                    memoria->minTicket = max(memoria->minTicket, memoria->ticket);
                    memoria->nConfirmaciones = 0;

                    mensajeOut.idOrigen = memoria->miId;
                    mensajeOut.mtype = 1;
                    mensajeOut.ticket = memoria->ticket;
                    mensajeOut.prioridad = memoria->prioridadNodo;

                    for (i = 0; i < nNodos - 1; i++) {

                        do {

                            error = msgsnd (memoria->idNodos[i], &mensajeOut, sizeof (datos) - sizeof (long), 0);

                            if (error == -1) {

                                printf ("Error al enviar la peticion al nodo %i. Reintentando ...\n", i);
                            }

                        } while (error != 0);
                    }

                    printf("Peticiones enviadas\n");
                }

                if (memoria->prioridadExterna == 0) {

                    memoria->prioridadExterna = mensajeIn.prioridad;

                } else {

                    memoria->prioridadExterna = min (memoria->prioridadExterna, mensajeIn.prioridad);
                }

                if (memoria->esperandoSC == 0 ||
                   (memoria->enSC == 0 && (memoria->prioridadNodo > mensajeIn.prioridad ||
                                          (memoria->prioridadNodo == mensajeIn.prioridad && (memoria->ticket > mensajeIn.ticket ||
                                                                                            (memoria->ticket == mensajeIn.ticket && memoria->miId > mensajeIn.idOrigen)))))) {
                
                    memoria->minTicket = max (memoria->minTicket, mensajeIn.ticket);

                    mensajeOut.mtype = 2;
                    mensajeOut.idOrigen = memoria->miId;
                    mensajeOut.ticket = mensajeIn.ticket;
                    mensajeOut.prioridad = mensajeIn.prioridad;

                    do {

                        error = msgsnd (mensajeIn.idOrigen, &mensajeOut, sizeof (datos) - sizeof (long), 0);

                        if (error != 0) {

                            printf ("Error al enviar la confirmacion. Reintentando ...\n");
                        }

                    } while (error != 0);

                    //printf ("Peticion confirmada\n");

                } else {

                    memoria->colaNodos [memoria->pendientes] [0] = mensajeIn.idOrigen;
                    memoria->colaNodos [memoria->pendientes] [1] = mensajeIn.prioridad;
                    memoria->ticketPendientes [memoria->pendientes] = mensajeIn.ticket;

                    memoria->pendientes += 1;

                    printf ("Peticion anhadida a pendientes\n");
                }

                break;

            case 2:

                if (mensajeIn.prioridad == memoria->prioridadNodo && mensajeIn.ticket == memoria->ticket) {

                    memoria->nConfirmaciones ++;

                    if (memoria->nConfirmaciones == (nNodos - 1)) {

                        sem_post (&memoria->entradaSC [memoria->prioridadNodo - 1]);
                        memoria->nConfirmaciones = 0;
                    }
                }

                break;

            case 3:

                if (memoria->esperandoSC == 0) {

                    memoria->bloqueoConsultas = 0;

                    if (memoria->esperaConsultas > 0) {

                        sem_post (&memoria->sem_p_consultas);
                    }
                }

                printf ("Consultas desbloqueadas\n");

                break;
        }
    }
}