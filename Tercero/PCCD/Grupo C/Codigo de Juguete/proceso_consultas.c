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


int main (int argc, char const *argv[]) {

    int zonaMemoria;
    key_t clave = ftok ("/home/selmo/Escritorio/Teleco/Tercero/PCCD/Grupo C/", atoi(argv[1]));
    zonaMem *memoria;

    sleep (0.5);

    zonaMemoria = shmget (clave, sizeof (zonaMem), 0);

    if (zonaMemoria == -1)
    {

        printf ("Error al encontrar la zona de memoria compartida. Cerrando programa ...\n\n");
        return 0;
    }

    memoria = shmat (zonaMemoria, NULL, 0);
    printf ("Enlazado en la zona de memoria %i\n", zonaMemoria);

    printf ("\nEsperando ...\n");
    fflush (stdin);
    while (getchar () != '\n');
    printf ("Pasadita\n");

    printf ("BloqueoConsultas = %i\n", memoria->bloqueoConsultas);

    if (memoria->bloqueoConsultas != 0) {

        memoria->esperaConsultas ++;
        sem_wait (&memoria->sem_p_consultas);
        memoria->esperaConsultas --;
    }

    memoria->numConsultas ++;

    if (memoria->bloqueoConsultas == 0 && memoria->esperaConsultas > 0) {

        sem_post (&memoria->sem_p_consultas);
    }

    printf ("Entrada a la Seccion Critica \n");
    fflush (stdin);
    while (getchar () != '\n');

    memoria->numConsultas --;

    if (memoria->esperaFinConsultas > 0 && memoria->numConsultas == 0) {

        sem_post (&memoria->finConsultas);

    }
}