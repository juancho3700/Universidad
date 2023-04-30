/*
TIPOS DE MENSAJE DE LA COLA:

    - 1: Cola de acabo (lo que le dice al proveedor que tiene que volver a proveer)
    - 2: Cola de provisto (lo que le dice a los fumadores que el proveedor ha provisto)
    - 3: Cola de art1
    - 4: Cola de art2
    - 5: Cola de art3
*/

#include <stdio.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <unistd.h>
#include <pthread.h>
#include <time.h>
#include <stdlib.h>

typedef struct { // Estructura para el hilo

    int numFumador;
    int numArt1, numArt2;

} datosHilo;

typedef struct { // Estructura para la cola de mensajes

    long mtype;

} datos;

int idCola;
int colaAcabo = 1, colaProvisto = 2;

void *funFumador (datosHilo *data) {

    datos mensaje [3];
    int tam;

    printf ("El fumador %i busca los articulos %i y %i\n", data->numFumador, data->numArt1, data->numArt2);

    while (1) {

        printf ("[Fumador %i] - Esperando por el proveedor ...\n", data->numFumador);
        tam = msgrcv (idCola, &mensaje [0], sizeof (int), colaProvisto, 0);

        printf ("[Fumador %i] - Confirmacion de proveedor recibida\n", data->numFumador);

        if (tam == -1) {

            printf ("Error al recibir la confirmacion del proveedor. Matando fumador ...\n\n");
            return 0;
        }

        tam = msgrcv (idCola, &mensaje [1], sizeof (int), data->numArt1, 0);

        if (tam == 0) {

            tam = msgrcv (idCola, &mensaje [2], sizeof (int), data->numArt2, IPC_NOWAIT);

            if (tam == -1) {

                printf ("[Fumador %i] - No es lo que busca ...\n", data->numFumador);
                msgsnd (idCola, &mensaje [1], sizeof (int), 0);

            } else {

                printf ("[Fumador %i] - Fumando cigarrito puta madre ...\n", data->numFumador);
                sleep (2);

                mensaje [0].mtype = colaAcabo;
                msgsnd (idCola, &mensaje [0], sizeof (int), 0);
            }

        } else {

            printf ("[Fumador %i] - El proveedor no tiene nada para mi\n", data->numFumador);
            msgsnd (idCola, &mensaje [1], sizeof (int), 0);
        }
    }

    return 0;
}

int main (int argc, char const *argv[]) {
    
    int  i, error, art [2];
    pthread_t idHilos[3];
    datosHilo envioHilos[3];
    datos mensaje [3], fumadores [3];
    key_t clave = ftok ("/home/selmo/Escritorio/TelecoSimple/Tercero/PCCD/Practica 6/", 10);

    if (clave == -1) {

        printf ("Error al generar la clave de la cola. Cerrando programa ...\n\n");
        return 0;
    }

    idCola = msgget (clave, IPC_CREAT | 0777);

    if (idCola == -1) {

        printf ("Error al crear la cola de mensajes. Cerrando programa ...\n\n");
        return 0;
    }

    srand (time (NULL));

    for (i = 0; i < 3; i++) {

        envioHilos [i].numFumador = i + 1;
        envioHilos [i].numArt1 = i + 3;
        envioHilos [i].numArt2 = ((i + 1) % 3) + 3;
        
        error = pthread_create (&idHilos [i], NULL, (void *) funFumador, &envioHilos [i]);

        if (error != 0) {

            printf ("Error al crear al fumador %i. Cerrando programa ...\n\n", i + 1);
            return 0;
        }
    }

    while (1) {

        sleep (1);

        printf ("[Proovedor] - Busca en la chaqueta ...\n");
        art [0] = rand () % 3;

        switch (art [0]) {

            case 0:
                printf ("[Proveedor] - Ha encontrado papel en su chaqueta\n");
                break;

            case 1:
                printf ("[Proveedor] - Ha encontrado tabaco en la chaqueta\n");
                break;

            case 2:
                printf ("[Proveedor] - Ha encontrado cerillas en su chaqueta\n");
                break;
        }

        mensaje [1].mtype = art [0] + 3;
        error = msgsnd (idCola, &mensaje [1], sizeof (int), 0);

        if (error != 0) {

            printf ("Error al proveer el primer articulo. Cerrando programa ...\n\n");
            return 0;
        }

        do {
            art [1] = rand () % 3;

        } while (art [0] == art [1]);

        switch (art [1]) {

            case 0:
                printf("[Proveedor] - Ha encontrado papel en su chaqueta\n");
                break;

            case 1:
                printf("[Proveedor] - Ha encontrado tabaco en la chaqueta\n");
                break;

            case 2:
                printf("[Proveedor] - Ha encontrado cerillas en su chaqueta\n");
                break;
        }

        mensaje [2].mtype = art [1] + 3;
        error = msgsnd (idCola, &mensaje [2], sizeof (int), 0);

        if (error != 0) {

            printf ("Error al proveer el segundo articulo. Cerrando programa ...\n\n");
            return 0;
        }

        for (i = 0; i < 3; i++) {

            fumadores [i].mtype = colaProvisto;
            error = msgsnd (idCola, &fumadores [i], sizeof (int), 0);

            if (error != 0) {

                printf ("Error al darle paso a los fumadores. Cerrando programa ...\n\n");
                return 0;
            }
        }

        printf ("[Proveedor] - Esperando a los fumadores ...\n");
        error = msgrcv (idCola, &mensaje [0], sizeof (int), colaAcabo, 0);

        if (error == -1) {

            printf ("Error al recibir el paso de los fumadores. Cerrando programa ...\n\n");
            return 0;
        }
    }

    return 0;
}
