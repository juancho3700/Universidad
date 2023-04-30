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
#define nHilos 3
#define maxPasesSC 2

typedef struct {

    long mtype;
    float ticket;
    int idOrigen;

} datos;

typedef struct {

    sem_t * sem_entrada,
          * sem_salida;
    int numHilo;


} datosHilos;

sem_t disputaSC,
      contSC,
      entradaSC,
      mutexDatos;

float ticket,
      minTicket = 0;

int quiero = 0,
    miId,
    idNodos [nUsuarios - 1],
    colaNodos [nUsuarios - 1],
    pendientes = 0,
    esperandoSC = 0,
    enSC = 0;

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

                sem_post (&disputaSC);
                nConfirmaciones = 0;
            }

            printf ("Confirmacion recibida\n");

        } else if (enSC == 0 && (quiero == 0 || ticket > mensajeIn.ticket || (ticket == mensajeIn.ticket && miId > mensajeIn.idOrigen))) {

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



void * funPrincipal (datosHilos * entrada) {

    datos mensaje;
    int error, i;

    printf ("Hilo %i iniciado\n", entrada->numHilo);

    while (1) {

        printf ("[Hilo %i] - Esperando ...\n", entrada->numHilo);
        sem_wait (entrada->sem_entrada);

        sem_wait (&contSC);
        sem_wait (&mutexDatos);
        esperandoSC ++;

        if (esperandoSC == 1 && enSC == 0) {

            sem_post (&mutexDatos);
            printf ("[Hilo %i] - Disputando por la SC ...\n", entrada->numHilo);

            srand ((unsigned) time (NULL));
            ticket = minTicket + (float) ((rand () % 1000) / 1000.0f);
            printf ("[Hilo %i] - Ticket creado: %.3f\n", entrada->numHilo, ticket);

            minTicket = max (minTicket, ticket);
            quiero = 1;

            mensaje.mtype = 1;
            mensaje.ticket = ticket;
            mensaje.idOrigen = miId;

            for (i = 0; i < nUsuarios - 1; i++) {

                do {

                    error = msgsnd (idNodos [i], &mensaje, sizeof (mensaje.ticket) + sizeof (mensaje.idOrigen), 0);

                    if (error == -1) {

                        printf ("Error al enviar la peticion al usuario %i. Reintentando ...\n", i + 1);
                    }

                } while (error != 0);
            }

            printf ("[Hilo %i] - Mensajes enviados correctamente\n", entrada->numHilo);

            sem_wait (&disputaSC);
            printf ("[Hilo %i] - Mensajes recibidos correctamente\n",entrada->numHilo);

        } else {

            sem_post (&mutexDatos);
            printf ("[Hilo %i] - Esperando por la SC ...\n", entrada->numHilo);
            sem_wait (&entradaSC);
        }

        sem_wait (&mutexDatos);
        esperandoSC --;
        enSC ++;
        sem_post (&mutexDatos);

        printf ("[Hilo %i] - Entrada a la SC\n", entrada->numHilo);
        sem_wait (entrada->sem_salida);

        printf ("[Hilo %i] - Saliendo de la SC ...\n", entrada->numHilo);
        sem_wait (&mutexDatos);
        enSC --;

        if (esperandoSC == 0) {

            sem_post (&mutexDatos);

            for (i = 0; i < maxPasesSC; i++) {

                sem_post (&contSC);
            }

            quiero = 0;

            mensaje.mtype = 2;
            mensaje.idOrigen = miId;
            mensaje.ticket = 0;

            for (i = 0; i < pendientes; i++) {

                do {
                    error = msgsnd (colaNodos [i], &mensaje, sizeof (mensaje.ticket) + sizeof (mensaje.idOrigen), 0);

                } while (error != 0);
            }

        } else {

            sem_post (&mutexDatos);
            sem_post (&entradaSC);
        }
    }   
}


int main (int argc, char const *argv[]) {

    key_t clave = ftok ("/home/selmo/Escritorio/Teleco/Tercero/PCCD/Ejercicio Tickets/", atoi (argv [1]));
    int error, i;
    pthread_t idHilo [nHilos + 1];
    sem_t sem_sinc [nHilos * 2];
    datosHilos argHilo [nHilos];

    miId = msgget (clave, IPC_CREAT | 0777);

    if (miId == -1) {

        printf ("Error al crear mi buzon. Cerrando programa ...\n\n");
        return (0);
    }

    printf ("Creado el buzon de ID = %i\n", miId);

    error = sem_init (&disputaSC, 0, 0);

    if (error == -1) {

        printf ("Error al inicializar el semaforo de disputa. Cerrando programa ...\n\n");
        return 0;
    }

    error = sem_init (&entradaSC, 0, 0);

    if (error == -1) {

        printf ("Error al inicializar el semaforo de entrada. Cerrando programa ...\n\n");
        return 0;
    }

    error = sem_init (&mutexDatos, 0, 1);

    for (i = 0; i < nUsuarios - 1; i++) {

        printf ("Introduzca la ID del usuario %i: ", i);
        scanf ("%i", &idNodos [i]);
    }

    error = sem_init (&contSC, 0, maxPasesSC);

    if (error == -1) {

        printf ("Error al iniciar el semaforo de contaje. Cerrando programa ...\n\n");
        return 0;
    }

    error = 0;

    for (i = 0; i < (nHilos * 2); i++) {

        error += sem_init (&sem_sinc [i], 0, 0);
    }

    if (error != 0) {

        printf ("Error al crear los semaforos de sincronizacion. Cerrando programa ...\n\n");
        return 0;
    }

    error = pthread_create (&idHilo [0], NULL, funRecepcion, NULL);

    if (error == -1) {

        printf ("Error al crear el hilo de recepcion. Cerrando programa ...\n\n");
        return 0;
    }

    for (i = 0; i < nHilos; i++) {

        argHilo [i].numHilo = i;
        argHilo [i].sem_entrada = &sem_sinc [i];
        argHilo [i].sem_salida = &sem_sinc [i + nHilos];

        error = pthread_create (&idHilo [i + 1], NULL, (void *) funPrincipal, &argHilo [i]);

        if (error == -1) {

            printf ("Error al crear el hilo %i. Cerrando programa ...\n\n", i);
            return 0;
        }
    }

    while (1) {

        sleep (1);

        printf ("\n   1 - Meter un proceso en la SC\n   2 - Sacar a un proceso de la SC\n   3 - Salir\n       Elige una opcion: ");
        scanf ("%i", &i);

        switch (i) {

            case 1:
                printf ("Que hilo desea meter en la SC (0 - %i): ", nHilos - 1);
                scanf ("%i", &i);

                sem_post (&sem_sinc [i]);
                break;

            case 2:
                printf ("Que hilo desea sacar de la seccion critica (0 - %i): ", nHilos - 1);
                scanf ("%i", &i);

                sem_post (&sem_sinc [i + nHilos]);
                break;

            case 3:

                printf ("Cerrando programa. Saluditos\n\n");

                do {

                    error = msgctl (miId, IPC_RMID, NULL);

                } while (error != 0);

                return 0;

            default:
                printf ("Opcion no valida. Vuelva a intentarlo\n");
        }
    }
}