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

#include "zonaMemoria.h"


float max (float n1, float n2) {

    return (n1 > n2) ? n1 : n2;
}


int min(int n1, int n2) {

    return (n1 < n2) ? n1 : n2;
}


int main (int argc, char const *argv[]) {

    int i,
        j,
        error = 0,
        zonaMemoria,
        prioridad = atoi (argv [2]);

    key_t clave = ftok ("/home/selmo/Escritorio/Teleco/Tercero/PCCD/Grupo C/", atoi (argv [1]));
    zonaMem * memoria;
    datos mensaje;

    sleep (0.5);

    zonaMemoria = shmget (clave, sizeof (zonaMem), 0);

    if (zonaMemoria == -1) {

        printf ("Error al encontrar la zona de memoria compartida. Cerrando programa ...\n\n");
        return 0;
    }

    
    memoria = shmat (zonaMemoria, NULL, 0);
    printf ("Enlazado en la zona de memoria %i\n", zonaMemoria);

    //while (1) {

        printf ("\nEsperando ...\n");
        fflush (stdin);
        while (getchar () != '\n');
        printf ("Pasadita\n");

        if (memoria->bloqueoConsultas == 0) {

            memoria->bloqueoConsultas = 1;
        }


        if (memoria->pasesSC == maxPasesSC) {

            memoria->esperandoMax ++;
            sem_wait (&memoria->maxProcesos);

            memoria->esperandoMax --;

            if (memoria->esperandoMax > 0 && memoria->pasesSC < maxPasesSC) {

                sem_post (&memoria->maxProcesos);
            }
        }

        printf ("Esperando por la Seccion Critica ...\n");

        memoria->esperandoSC ++;
        memoria->pasesSC ++;
        memoria->nProcesosPrio [prioridad - 1] ++;

        if (memoria->enSC == 0 && (prioridad < memoria->prioridadNodo || memoria->prioridadNodo == 0)) {

            memoria->prioridadNodo = prioridad;

            printf ("Disputando la SC ...\n");

            srand ((unsigned) time (NULL));
            memoria->ticket = memoria->minTicket + (float) ((rand () % 1000) / 1000.0f);
            printf ("Ticket creado: %.3f\n", memoria->ticket);

            memoria->minTicket = max (memoria->minTicket, memoria->ticket);
            memoria->nConfirmaciones = 0;

            mensaje.mtype = 1;
            mensaje.idOrigen = memoria->miId;
            mensaje.ticket = memoria->ticket;
            mensaje.prioridad = prioridad;
            
            for (i = 0; i < nNodos - 1; i++) {

                do {

                    error = msgsnd (memoria->idNodos [i], &mensaje, sizeof (datos) - sizeof (long), 0);

                    if (error == -1) {

                        perror ("Error al enviar la peticion al nodo.\n");
                        return 0;
                    }

                } while (error != 0);
            }

            printf ("Peticiones enviadas\n");
        }

        sem_wait (&memoria->entradaSC [prioridad - 1]);
        memoria->prioridadExterna = memoria->prioridadNodo;

        printf ("Confirmaciones recibidas\n");
        memoria->enSC ++;
        
        if (memoria->prioridadExterna != 0) {

            memoria->prioridadExterna = memoria->prioridadNodo;
        }

        printf ("En la Seccion Critica\n");
        fflush (stdin);
        while (getchar () != '\n');

        printf ("Saliendo de la Seccion Critica ...\n");
        memoria->esperandoSC --;
        memoria->enSC --;
        memoria->nProcesosPrio [prioridad - 1] --;

        if (memoria->pendientes == 0) {

            memoria->prioridadExterna = 0;
        }

        if (memoria->esperandoSC == 0) {

            memoria->prioridadNodo = 0;

            if (memoria->pendientes == 0 && memoria->esperandoMax != 0) {

                memoria->pasesSC = 0;
                sem_post (&memoria->maxProcesos);

            } else if (memoria->pendientes == 0 && memoria->esperandoMax == 0) {

                memoria->pasesSC = 0;

                printf ("Desbloqueando consultas\n");

                if (memoria->esperaConsultas > 0) {

                    sem_post (&memoria->sem_p_consultas);
                }

                mensaje.mtype = 3;
                mensaje.idOrigen = memoria->miId;
                mensaje.ticket = 0;
                mensaje.prioridad = 0;

                for (i = 0; i < (nNodos - 1); i++) {

                    do {

                        error = msgsnd(memoria->idNodos[i], &mensaje, sizeof(datos) - sizeof(long), 0);

                        if (error != 0) {

                            printf ("Error al enviar el mensaje al nodo %i. Reintentando ...\n", i);
                        }

                    } while (error != 0);
                }

                memoria->bloqueoConsultas = 0;

            } else {

                mensaje.mtype = 2;
                mensaje.idOrigen = memoria->miId;

                for (i = 0; i < memoria->pendientes; i++) {

                    mensaje.prioridad = memoria->colaNodos [i] [1];
                    mensaje.ticket = memoria->ticketPendientes [i];
                    
                    do {

                        error = msgsnd (memoria->colaNodos [i] [0], &mensaje, sizeof (datos) - sizeof (long), 0);

                        if (error != 0) {

                            printf("Error al enviar el mensaje al nodo %i. Reintentando ...\n", i);
                        }

                    } while (error != 0);
                }

                memoria->pendientes = 0;
                memoria->pasesSC = 0;
                sem_post (&memoria->maxProcesos);
            }

        } else {

            for (i = 0; i < numPrios; i++) {

                if (memoria->nProcesosPrio [i] > 0) {

                    memoria->prioridadNodo = i + 1;
                    memoria->prioridadExterna = 10;

                    for (j = 0; j < memoria->pendientes; j++) {

                        memoria->prioridadExterna = min (memoria->prioridadExterna, memoria->colaNodos [j] [1]);
                    }

                    if (memoria->prioridadExterna == 10) {
                     
                        memoria->prioridadExterna = 0;
                    }

                    if (memoria->prioridadNodo > memoria->prioridadExterna && memoria->prioridadExterna != 0) {

                        mensaje.mtype = 2;
                        mensaje.idOrigen = memoria->miId;
                        mensaje.ticket = 0;

                        srand ((unsigned)time (NULL));
                        memoria->ticket = memoria->minTicket + (float) ((rand () % 1000) / 1000.0f);

                        memoria->minTicket = max (memoria->minTicket, memoria->ticket);

                        int colaNodosAux [memoria->pendientes] [2], pendientesAux = 0;
                        float ticketPendientesAux [memoria->pendientes];

                        for (j = 0; j < memoria->pendientes; j++) {

                            mensaje.prioridad = memoria->colaNodos [j] [1];
                            mensaje.ticket = memoria->ticketPendientes [j];

                            if (memoria->prioridadNodo > mensaje.prioridad ||
                               (memoria->prioridadNodo == mensaje.prioridad && (memoria->ticket > mensaje.ticket ||
                                                                               (memoria->ticket == mensaje.ticket && memoria->miId > memoria->colaNodos [j] [0])))) {
                                
                                do {

                                    error = msgsnd (memoria->colaNodos [j] [0], &mensaje, sizeof (datos) - sizeof (long), 0);

                                    if (error != 0) {

                                        printf ("Error al enviar el mensaje al nodo %i. Reintentando ...\n", j);
                                    }

                                } while (error != 0);

                            } else {

                                colaNodosAux [pendientesAux] [0] = memoria->colaNodos [j] [0];
                                colaNodosAux [pendientesAux] [1] = memoria->colaNodos [j] [1];
                                ticketPendientesAux [pendientesAux] = memoria->ticketPendientes [j];
                                pendientesAux ++;
                            }
                        }

                        for (memoria->pendientes = 0; memoria->pendientes < pendientesAux; memoria->pendientes ++) {

                            memoria->colaNodos [memoria->pendientes] [0] = colaNodosAux [memoria->pendientes] [0];
                            memoria->colaNodos [memoria->pendientes] [1] = colaNodosAux [memoria->pendientes] [1];
                            memoria->ticketPendientes [memoria->pendientes] = ticketPendientesAux [memoria->pendientes];
                        }

                        memoria->nConfirmaciones = 0;

                        mensaje.mtype = 1;
                        mensaje.idOrigen = memoria->miId;
                        mensaje.ticket = memoria->ticket;
                        mensaje.prioridad = memoria->prioridadNodo;

                        printf ("Ticket regenerado :: %.3f\n", memoria->ticket);

                        for (j = 0; j < nNodos - 1; j++) {

                            do {

                                error = msgsnd (memoria->idNodos[j], &mensaje, sizeof (datos) - sizeof (long), 0);

                                if (error == -1) {

                                    printf("Error al enviar la peticion al nodo %i. Reintentando ...\n", j);
                                }

                            } while (error != 0);
                        }

                        memoria->pasesSC = memoria->esperandoSC;

                        if (memoria->esperandoMax > 0 && memoria->pasesSC < maxPasesSC) {

                            sem_post (&memoria->maxProcesos);
                        }

                    } else {

                        printf ("Prioridad de fuera = %i, Prioridad de mi nodo = %i\n", memoria->prioridadExterna, memoria->prioridadNodo);
                        printf ("Dando paso al proceso de prioridad %i\n", i + 1);
                        sem_post (&memoria->entradaSC [i]);
                    }

                    break;
                }
            }
        }
    //}

    return 0;
}