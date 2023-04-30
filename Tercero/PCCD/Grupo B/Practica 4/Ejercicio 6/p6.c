#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h>
#include <pthread.h>
#include <unistd.h>

sem_t sem_Lectores, sem_Escritores, sem_mutex;
sem_t semAux_esperaLeer, semAux_esperaEscribir;
sem_t semAux_infoLeer, semAux_infoQuererLeer, semAux_infoQuererEscribir, semAux_infoEscribir;
int escribiendo = 0, leyendo = 0, queriendoLeer = 0, queriendoEscribir = 0;

typedef struct
{
    sem_t *semaforoIn;
    sem_t *semaforoOut;
    int id;
} envio;

int inicioSemaforosGlobales (int n2) {

    int error = 0;

    error += sem_init (&sem_Escritores, 0, 1);

    error += sem_init (&sem_Lectores, 0, n2);

    error += sem_init (&sem_mutex, 0, 1);

    error += sem_init (&semAux_esperaLeer, 0, 0);

    error += sem_init (&semAux_esperaEscribir, 0, 0);

    error += sem_init (&semAux_infoQuererLeer, 0, 1);

    error += sem_init (&semAux_infoLeer, 0, 1);

    return error;
}

void *funLector (envio *datos)
{

    while (1)
    {

        printf ("[Lector %i] -> Esperando a intentar leer ...\n", datos->id);
        sem_wait (datos->semaforoIn);

        printf ("[Lector %i] -> Intentando leer ...\n", datos->id);

        sem_wait (&semAux_infoQuererLeer);          // Acceso a quererLeer
        queriendoLeer ++;

        sem_wait (&semAux_infoQuererEscribir);      // Acceso a quererEscribir
        if (queriendoEscribir > 1) {

            sem_post (&semAux_infoQuererEscribir);  // Fin acceso a quererEscribir
            sem_post (&semAux_infoQuererLeer);      // Fin acceso a quererLeer
            sem_wait (&semAux_esperaEscribir);      // Espera a que acaben los escritores
        
        }  else if (queriendoLeer == 1) {

            sem_post (&semAux_infoQuererEscribir);  // Fin acceso a quererEscribir
            sem_post (&semAux_infoQuererLeer);      // Fin acceso a quererLeer
            sem_wait (&sem_mutex);                  // Espera a que acaben los escritores

            if (queriendoLeer > 1) {
                sem_post (&semAux_esperaLeer);      // Da paso a los demás lectores
            }

        } else if (leyendo == 0) {

            sem_post (&semAux_infoQuererEscribir);  // Fin acceso a quererEscribir
            sem_post (&semAux_infoQuererLeer);      // Fin acceso a quererLeer
            sem_wait (&semAux_esperaLeer);          // Espera a que el primer lector gane el paso a la SC
        }

        sem_wait (&sem_Lectores);                   // Espera a que haya menos de N2 lectores en la SC
        sem_wait (&semAux_infoLeer);                // Acceso a leyendo
        leyendo ++;
        sem_post (&semAux_infoLeer);                // Fin acceso a leyendo

        printf("[lector %i] -> Leyendo ...\n", datos->id);
        sem_wait (datos->semaforoOut);

        sem_wait (&semAux_infoLeer);                // Acceso a leyendo
        leyendo --;
        sem_post (&semAux_infoLeer);                // Fin acceso a leyendo

        sem_wait (&semAux_infoQuererLeer);          // Acceso a quererLeer
        queriendoLeer --;

        if (queriendoLeer == 0) {
            sem_post (&sem_mutex);                  // Libera la exclusión mutua con los escritores
        }

        sem_post (&semAux_infoQuererLeer);          // Fin acceso a quererLeer
        sem_post (&sem_Lectores);
        printf ("[Lector %i] -> Fin de la lectura\n", datos->id);
    }
}


void *funEscritor (envio *datos)
{

    while (1)
    {

        printf ("[Escritor %i] -> Esperando a intentar escribir ...\n", datos->id);
        sem_wait (datos->semaforoIn);

        printf ("[Escritor %i] -> Intentando escribir ...\n", datos->id);
        sem_wait (&semAux_infoQuererEscribir);      // Acceso a quererEscribir
        queriendoEscribir ++;
        sem_post (&semAux_infoQuererEscribir);      // Fin acceso a quererEscribir

        sem_wait (&sem_mutex);                      // Espera a que acaben los lectores
        sem_wait (&semAux_infoEscribir);            // Acceso a escribiendo
        escribiendo ++;
        sem_post (&semAux_infoEscribir);            // Fin acceso a escribiendo

        printf("[Escritor %i] -> Escribiendo ...\n", datos->id);
        sem_wait (datos->semaforoOut);

        if (queriendoEscribir == 1) {

            sem_post (&semAux_esperaEscribir);      // Da paso a los lectores si hay esperando
        }

        sem_post (&sem_mutex);                      // Libera la exclusión mutua

        printf ("[Escritor %i] -> Fin de la lectura\n", datos->id);
        
        sem_wait (&semAux_infoEscribir);            // Acceso a escribiendo
        escribiendo --;
        sem_post (&semAux_infoEscribir);            // Fin acceso escribiendo

        sem_wait (&semAux_infoQuererEscribir);      // Acceso a quererEscribir
        queriendoEscribir --;
        sem_post (&semAux_infoQuererEscribir);      // Fin acceso a quererEscribir
    }
}




int main (int argc, char const *argv[])
{
    
    int nLectores = atoi (argv [1]), nEscritores = atoi (argv [3]), error, i, opcion, id;
    sem_t semaforoLec [2 * nLectores], semaforoEsc [2 * nEscritores];
    pthread_t hilosLectores [nLectores], hilosEscritores [nEscritores];
    envio datosLectores [nLectores], datosEscritores [nEscritores];
    
    error = inicioSemaforosGlobales (atoi (argv [2]));

    if (error != 0)
    {

        printf ("Error al crear un semaforo global. Cerrando programa ...\n\n");
        return 0;
    }

    for (i = 0; i < 2 * nLectores; i++) {

        error = sem_init (&semaforoLec [i], 0, 0);

        if (error != 0) {

            printf ("Error al crear el semaforo del lector %i. Cerando programa ...\n\n", i);
            return 0;
        }
    }

    for (i = 0; i < 2 * nEscritores; i++) {

        error = sem_init (&semaforoEsc [i], 0, 0);

        if (error != 0) {

            printf ("Error al crear el semaforo del escritor %i. Cerrando programa ...\n\n", i);
            return 0;
        }
    }

    for (i = 0; i < nLectores; i++) {

        datosLectores [i]. id = i + 1;
        datosLectores [i]. semaforoIn = &semaforoLec [i];
        datosLectores [i]. semaforoOut = &semaforoLec [i + nLectores];
    
        error = pthread_create (&hilosLectores [i], NULL, (void *) funLector, &datosLectores [i]);

        if (error != 0) {

            printf ("Error al crear el lector %i. Cerrando programa ...\n\n", i + 1);
            return 0;
        }
    }

    for (i = 0; i < nEscritores; i++) {

        datosEscritores [i]. id = i + 1;
        datosEscritores [i]. semaforoIn = &semaforoEsc [i];
        datosEscritores [i]. semaforoOut = &semaforoEsc [i + nEscritores];

        error = pthread_create (&hilosEscritores [i], NULL, (void *) funEscritor, &datosEscritores [i]);

        if (error != 0) {

            printf ("Error al crear el lector %i. Cerrando programa ...\n\n", i + 1);
            return 0;
        }
    }

    while (1) {

        sleep (1);

        printf (" 1 - Intentar Leer\n 2 - Finalizar leer\n 3 - Intentar escribir\n 4 - Finalizar escribir\n 5 - Salir\n\n   Elige una opcion: ");
        scanf ("%i", &opcion);
        fflush (stdin);

        switch (opcion) {

            case 1:
                printf ("Introduzca el numero del lector (de 1 a %i): ", nLectores);
                scanf ("%i", &id);
                fflush (stdin);

                sem_post (&semaforoLec [id - 1]);
                break;

            case 2:

                printf ("Introduzca el numero del lector (de 1 a %i): ", nLectores);
                scanf ("%i", &id);
                fflush (stdin);

                sem_post (&semaforoLec [id + nLectores - 1]);
                break;

            case 3:

                printf ("Introduzca el numero del escritor (de 1 a %i): ", nEscritores);
                scanf ("%i", &id);
                fflush (stdin);

                sem_post (&semaforoEsc [id - 1]);
                break;

            case 4:

                printf ("Introduzca el numero del escritor (de 1 a %i): ", nEscritores);
                scanf ("%i", &id);
                fflush (stdin);

                sem_post (&semaforoEsc [id + nEscritores - 1]);
                break;

            case 5:

                printf ("Cerrando programa ...\n\n");
                return 0;

            default:

                printf ("Opcion no valida. Vuelve a intentarlo\n\n");
        }

    }
}

