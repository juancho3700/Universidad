/*
    int msgget (key_t clave, int flags)

        accede a un buzón si la clave no es IPC_PRIVATE y flags = 0 

        - clave es la "contraseña" con la que se accede a dicho buzón
        - flags:
            + el byte menos significativo da los permisos a la cola de mensajes

        return: 
            + -1 si ha habido un error
            + el identificador del buzón en otro caso
*/


#include <stdio.h>
#include <sys/msg.h>
#include <sys/ipc.h>

int main (int argc, char const *argv[]) {
    
    int idCola = 0;
    key_t clave = ftok ("/home/selmo/Escritorio/TelecoSimple/Tercero/PCCD/Practica 6/", 10);

    if (clave == -1) {

        printf ("Error al generar la clave. Cerrando programa ...\n\n");
        return 0;
    }

    idCola = msgget (clave, IPC_CREAT | 0777);

    if (idCola == -1) {

        printf ("Error al generar la cola. Cerrando programa ...\n\n");
        return 0;
    }

    printf ("Se ha creado la cola con ID %i\n\n", idCola);
    return 0;
}