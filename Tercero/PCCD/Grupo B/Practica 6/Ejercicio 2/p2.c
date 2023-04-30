/* NOTAS PUTA MADRE

    int msgctl (int idCola, int cmd, struct msqid_ds *buf)
        Hace la operación especificada en cmd en la cola con id idCola
*/

#include <stdio.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <stdlib.h>


int main(int argc, char const *argv[]) {
    
    int idCola = atoi (argv [1]);
    int error = msgctl (idCola, IPC_RMID, NULL);

    if (error != 0) {

        printf ("Error al eliminar la cola con ID %i. Cerrando programa ...\n\n", idCola);
        return 0;
    }

    printf ("Se ha eliminado la cola con ID %i\n\n", idCola);
    return 0;
}
