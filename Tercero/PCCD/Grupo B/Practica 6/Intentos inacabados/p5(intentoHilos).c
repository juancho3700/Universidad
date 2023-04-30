/* NOTAS DE LAS COLAS

Tipos de mensaje:
    - 1  = Semáforo de avance del filosofo 1
    - 2  = Semáforo de avance del filosofo 2
    - 3  = Semáforo de avance del filosofo 3
    - 4  = Semáforo de avance del filosofo 4
    - 5  = Semáforo de avance del filosofo 5

    - 6  = Tenedor 1
    - 7  = Tenedor 2
    - 8  = Tenedor 3
    - 9  = Tenedor 4
    - 10 = Tenedor 5

    - 11 = Semaforo de 4
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <pthread.h>

int idCola, final = 0;

typedef struct {
    int mtype;
    char *mtext;

} datos;

typedef struct {
    int numFilosofo;

} datosHilo;

void *filosofo (datosHilo *entrada) {

    int tam;
    datos mensaje;

    sleep (0.5);

    while (1) {

        printf ("[Filosofo %i] - Pensando ...\n", entrada->numFilosofo);
        tam = msgrcv (idCola, &mensaje, sizeof (mensaje.mtext), entrada->numFilosofo, 0);

        if (tam == -1) {
            break;
        }

        printf ("[Filosofo %i] - Buscando sitio en el comedor ...\n", entrada->numFilosofo);
        tam = msgrcv (idCola, &mensaje, sizeof (mensaje.mtext), 11, 0);

        if (tam == -1) {
            break;
        }

        printf ("[Filosofo %i] - Cogiendo el tenedor %i ...\n", entrada->numFilosofo, entrada->numFilosofo);
        tam = msgrcv (idCola, &mensaje, sizeof(mensaje.mtext), 5 + entrada->numFilosofo, 0);

        if (tam == -1) {
            break;
        }

        printf ("[Filosofo %i] - Cogiendo el tenedor %i ...\n", entrada->numFilosofo, (entrada->numFilosofo + 1) % 5);
        tam = msgrcv(idCola, &mensaje, sizeof(mensaje.mtext), 5 + ((entrada->numFilosofo + 1) % 5), 0);

        if (tam == -1) {
            break;
        }

        printf ("[Filosofo %i] - Comiendo ...\n", entrada->numFilosofo);
        tam = msgrcv (idCola, &mensaje, sizeof (mensaje.mtext), entrada->numFilosofo, 0);

        if (tam == -1) {
            break;
        }

        mensaje.mtype = 5 + entrada->numFilosofo;
        mensaje.mtext = NULL;

        printf ("[Filosofo %i] - Soltando el tenedor %i ...\n", entrada->numFilosofo, entrada->numFilosofo);
        tam = msgsnd (idCola, &mensaje, sizeof (mensaje.mtext), IPC_NOWAIT);

        if (tam == -1)
        {
            break;
        }

        mensaje.mtype = 5 + ((entrada->numFilosofo + 1) % 5);
        mensaje.mtext = NULL;

        printf ("[Filosofo %i] - Soltando el tenedor %i ...\n", entrada->numFilosofo, (entrada->numFilosofo + 1) % 5);
        tam = msgsnd (idCola, &mensaje, sizeof (mensaje.mtext), IPC_NOWAIT);

        if (tam == -1)
        {
            break;
        }

        mensaje.mtype = 0;
        mensaje.mtext = NULL;
        tam = msgsnd (idCola, &mensaje, sizeof (mensaje.mtext), IPC_NOWAIT);
    }

    if (final == 0) {

        printf ("Error en el envio o recepción de mensajes de la cola en el filosofo %i. Matando filosofo ...\n\n", entrada->numFilosofo);
    }

    return 0;
}

int main (int argc, char const *argv[]) {
    
    int error = 0, i, opcion;
    pthread_t idFilosofo [5];
    datos mensaje [14];
    datosHilo mensajeHilo [5];
    key_t clave = ftok ("/home/selmo/Escritorio/TelecoSimple/Tercero/PCCD/Practica 6/", 10);

    if (clave == -1) {

        printf ("Error al generar la clave. Cerrando programa ...\n\n");
        return 0;
    }

    idCola = msgget(clave, IPC_CREAT | 0777);

    if (idCola == -1) {

        printf("Error al generar la cola. Cerrando programa ...\n\n");
        return 0;
    }

    printf("Generada la cola %i\n\n", idCola);

    for (i = 0; i < 5; i++) {

        mensajeHilo [i].numFilosofo = i + 1;
        error = pthread_create (&idFilosofo [i], NULL, (void *) filosofo, &mensajeHilo [i]);

        if (error != 0) {

            printf ("Error al crear el filosofo %i. Cerrando programa ...\n\n", i + 1);
            return 0;
        }
    }

    for (i = 0; i < 4; i++) {

        mensaje [i].mtype = 11;
        mensaje [i].mtext = "Cadena de relleno";
        error = msgsnd (idCola, &mensaje [i], sizeof (mensaje [i].mtext), IPC_NOWAIT);

        if (error != 0) {

            printf ("Error al enviar mensajes a la cola de tipo 0. Cerrando programa ...\n\n");
            return 0;
        }

    }

    for (i = 10; i <= 14; i++) {

        mensaje [i].mtype = i - 4;
        mensaje [i].mtext = "Cadena de relleno";
        error = msgsnd (idCola, &mensaje [i], sizeof (mensaje [i].mtext), IPC_NOWAIT);

        if (error != 0) {

            printf ("Error al enviar mensajes a la cola de tipo %i. Cerrando programa ...\n\n", i - 4);
            return 0;

        }
    }


    while (1) {

        sleep (1);

        printf ("\n   1 - Comer / Dejar de comer\n   2 - Salir\nElige una opcion: ");
        scanf ("%i", &opcion);
        fflush (stdin);

        switch (opcion) {

            case 1:
                printf ("Numero del filosofo al que cambiar de estado: ");
                scanf ("%i", &opcion);
                fflush (stdin);

                mensaje [opcion].mtype = opcion;
                mensaje [opcion].mtext = "Cadena de relleno";
                error = msgsnd (idCola, &mensaje [opcion], sizeof (mensaje [opcion].mtext), IPC_NOWAIT);

                printf ("Mensaje enviado al filosofo %i\n", opcion);

                if (error != 0) {

                    printf ("Error al cambiar el estado del filosofo %i\n", i);
                }

                break;

            case 2:
                final = 1;
                printf ("Cerrando programa ...\n\n");
                msgctl (idCola, IPC_RMID, NULL);
                return 0;

            default:
                printf ("Opcion no valida. Vuleva a intentarlo ...\n");
        }
    }

    return 0;
}