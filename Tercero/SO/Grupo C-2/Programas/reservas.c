#include <stdio.h>
#include <unistd.h>

int main(){
    int pid = getpid();
    int a = 0, i, j;

    for (i = 0; i < 20000; i ++){     
        a++;
        for (j = 0; j < 20000; j ++){
            a++;
                
        }
        if ((i%5000) == 0) {
            printf("El proceso reservas.c con PID: %d, sigue ejecutándose\n", pid);
        }
    }
    printf("\nEl proceso reservas.c ha terminado.\n");
    return 0;

}