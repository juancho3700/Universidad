/*
    int msgsnd (int idCola, const void *msgp, size_t tamaño, int flags)
        - Cola a la que envías el mensaje
        - Estructura definida
            + int tipo: Tipo de mensaje (> 0)
            + char *texto: mensaje a enviar
        - Tamaño del mensaje

    return:
        + -1 si ha habido error
        + 0 en otro caso
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
    
    int idCola = atoi (argv [1]), error = 0;
    datos mensaje;

    mensaje.mtext = "Primer mensaje";
    mensaje.mtype = atoi (argv [2]);

    error = msgsnd (idCola, &mensaje, sizeof (mensaje.mtext), 0);

    if (error != 0) {
        printf ("Error al enviar el mensaje a la cola. Cerrando programa ...\n\n");
        return 0;
    }

    printf ("Enviado mensaje :%s: a la cola %i\n\n", mensaje.mtext, idCola);
    return 0;
}
