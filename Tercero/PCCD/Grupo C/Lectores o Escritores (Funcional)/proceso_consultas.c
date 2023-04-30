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

typedef struct
{

    long mtype;
    float ticket;
    int idOrigen,
        prioridad;

} datos;

typedef struct
{

    sem_t disputaSC,
        entradaSC,
        maxProcesos,
        mutexDatos;

    float ticket,
        minTicket;

    int quiero,
        miId,
        idNodos[nNodos - 1],
        colaNodos[nNodos - 1],
        pendientes,
        esperandoSC,
        enSC,
        pasesSC,
        numSinc,
        esperandoMax,
        prioridadNodo;

} zonaMem;

float max(float n1, float n2)
{

    return (n1 > n2) ? n1 : n2;
}

int main(int argc, char const *argv[])
{

    int i, error = 0, zonaMemoria;
    key_t clave = ftok("/home/selmo/Escritorio/Teleco/Tercero/PCCD/Grupo C/", atoi(argv[1]));
    zonaMem *memoria;
    datos mensaje;

    sleep (0.5);

    zonaMemoria = shmget(clave, sizeof(zonaMem), 0);

    if (zonaMemoria == -1)
    {

        printf("Error al encontrar la zona de memoria compartida. Cerrando programa ...\n\n");
        return 0;
    }

    memoria = shmat(zonaMemoria, NULL, 0);
    printf("Enlazado en la zona de memoria %i\n", zonaMemoria);

    mensaje.idOrigen = memoria->miId;
    mensaje.mtype = 1;
    mensaje.prioridad = 5;
    mensaje.ticket = 0;

    while (1)
    {

        printf("\nEsperando ...\n");
        fflush(stdin);
        while (getchar() != '\n');
        printf("Pasadita\n");


        if (memoria->prioridadNodo == 0) {

            memoria->esperandoSC ++;
            memoria->prioridadNodo = mensaje.prioridad;

            for (i = 0; i < nNodos - 1; i++) {

                do {

                    error = msgsnd (memoria->idNodos[i], &mensaje, sizeof (datos) - sizeof (long), 0);

                    if (error == -1) {

                        printf("Error al enviar la peticion al nodo %i. Reintentando ...\n", i);
                    }

                } while (error != 0);
            }

            printf ("Mensajes enviados correctamente\n");

            sem_wait (&memoria->disputaSC);
            printf ("Mensajes recibidos correctamente\n");
            memoria->esperandoSC--;

        } else if (memoria->esperandoSC > 0) {

            memoria->esperandoSC ++;
            sem_wait (&memoria->entradaSC);
            memoria->esperandoSC --;
        }

        memoria->enSC ++;

        if (memoria->esperandoSC > 0) {

            sem_post (&memoria->entradaSC);
        }

        printf ("Entrada a la Seccion Critica\n");
        fflush (stdin);
        while (getchar () != '\n');

        printf ("Saliendo de la Seccion Critica\n\n");
        memoria->enSC --;

        if (memoria->enSC == 0) {

            memoria->prioridadNodo = 0;
        }
    }
}
