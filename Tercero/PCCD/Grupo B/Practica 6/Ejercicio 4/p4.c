/*
    ssize_t msgrcv (int idCola, void *msgp, size_t tamaño, long tipoMsg, int flags)
        - Cola en la que busca el mensaje
        - Donde se deja el mensaje (misma estructura que en el msgsnd)
        - Tamaño máximo del mensaje
        - Mensaje a leer
            + tipoMsg = 0: Se lee el primer mensaje
            + tipoMsg > 0: Se lee el primer mensaje del tipo tipoMsg
            + tipoMsg < 0: Se lee el primer mensaje con tamaño =< |tipoMsg|

        return:
            + -1 si ha habido error
            + en tamaño del mensaje en otro caso

*/

#include <stdio.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int mtype;
    char *mtext;

} datos;

int main(int argc, char const *argv[]) {
    
    int idCola = atoi (argv [1]), tamanho = 0;
    datos mensaje;

    mensaje.mtype = atoi (argv [2]);

    tamanho = msgrcv (idCola, &mensaje, sizeof (mensaje.mtext), mensaje.mtype, IPC_NOWAIT);

    if (tamanho == -1) {

        perror ("Error al recibir el mensaje");
        printf ("Cerrando programa ...\n\n");
        return 0;
    }

    printf ("Mensaje de tipo %i recibido correctamente\n\n", mensaje.mtype);
    return 0;
}
