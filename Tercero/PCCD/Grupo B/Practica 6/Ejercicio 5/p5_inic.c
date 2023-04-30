#include <stdio.h>
#include <sys/msg.h>
#include <stdlib.h>
#include <string.h>

typedef struct {

    long mtype;
    int nTenedor;

} datos;

int main (int argc, char const *argv[]) {

    key_t clave = ftok ("/home/selmo/Escritorio/TelecoSimple/Tercero/PCCD/Practica 6/", 10);
    int i, idCola, error;
    datos tenedor [9];

    idCola = msgget (clave, IPC_CREAT | 0777);

    if (idCola == -1) {

        printf ("Error al crear la cola de mensajes. Cerrando programa ...\n\n");
        return 0;
    }

    printf ("Se ha creado la cola %i\n", idCola);

    for (i = 0; i < 5; i++) {

        tenedor [i].mtype = i + 1;
        tenedor [i].nTenedor = i + 1;

        error = msgsnd (idCola, &tenedor [i], sizeof (int), 0);

        if (error == -1) {

            printf ("Error al añadir el tenedor %i a la cola. Cerrando programa ...\n\n", i + 1);
            return 0;

        } else {

            printf ("El tenedor %i se ha añadido correctamente\n", i + 1);
        }
    }

    for (i = 5; i < 9; i++) {

        tenedor [i].mtype = 6;
        tenedor [i].nTenedor = 0;

        error = msgsnd (idCola, &tenedor [i], sizeof (int), 0);

        if (error == -1) {

            printf ("Error al enviar un mensaje a la cola. Cerrando programa ...\n\n");
            return 0;
        }
    }

    return 0;
}
