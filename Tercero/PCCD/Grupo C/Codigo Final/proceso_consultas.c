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
#include <sys/time.h>
#include <signal.h>

#include "zonaMemoria.h"


float max (float n1, float n2) {

    return (n1 > n2) ? n1 : n2;
}


int main (int argc, char const *argv []) {

    int zonaMemoria;
    long timerLong;

    key_t clave = ftok (PATH_CLAVES, atoi (argv [0]));
    zonaMem * memoria = NULL;
    struct timeval timer;

    FILE * ficheroError = fopen ("salidaError.txt", "a");

    char archOut [50];
//    sprintf (archOut, "%s%s.txt", argv [1], argv [0]);
    sprintf (archOut, "%s.txt", argv [1]);
    FILE * ficheroOut = fopen (archOut, "a");

//    sprintf (archOut, "%s%s.txt", argv [3], argv [0]);
    sprintf (archOut, "%s.txt", argv [3]);
    FILE * ficheroStats = fopen (archOut, "a");

    sleep (0.5);

    zonaMemoria = shmget (clave, sizeof (zonaMem), 0);

    if (zonaMemoria == -1) {

        fprintf (ficheroError, "[Nodo %s, Consulta] - Error Zona Memoria\n", argv [0]);
        fclose (ficheroError);
        return 0;
    }

    memoria = shmat (zonaMemoria, NULL, 0);

    setbuf (ficheroOut, NULL);

    sem_wait (&memoria->mutexDatos);

    if (memoria->bloqueoConsultas != 0) {
        fprintf (ficheroOut, "[N%i, Consulta] - Bloqueo\n", memoria->miId);
        memoria->esperaConsultas ++;
        sem_post(&memoria->mutexDatos);

        sem_wait (&memoria->sem_p_consultas);

        sem_wait(&memoria->mutexDatos);
        memoria->esperaConsultas --;
    }

    memoria->numConsultas ++;

    if (memoria->bloqueoConsultas == 0 && memoria->esperaConsultas > 0) {

        sem_post (&memoria->sem_p_consultas);
    }

    sem_post (&memoria->mutexDatos);

    //fprintf (ficheroOut, "[N%i, Consulta] - SC\n", memoria->miId);
    gettimeofday(&timer, NULL);
    timerLong = timer.tv_sec * (10 ^ 6) + timer.tv_usec;
    fprintf(ficheroOut, "[N%i, Con] - In t = %ld\n", memoria->miId, timerLong);

    sleep ((float)(rand() % 51) / 1000.0f);

    // fprintf(ficheroOut, "[N%i, Con] - Out t = %ld\n", memoria->miId, timerLong);

    sem_wait (&memoria->mutexDatos);

    memoria->numConsultas --;

    if (memoria->esperaFinConsultas > 0 && memoria->numConsultas == 0) {

         sem_post (&memoria->finConsultas);

    }

    sem_post (&memoria->mutexDatos);
    fprintf (ficheroOut, "[N%i, Consulta] - END\n", memoria->miId);
    fclose (ficheroOut);
    fclose (ficheroStats);
    fclose(ficheroError);

    kill (getpid (), SIGCHLD);
    return 0;
}