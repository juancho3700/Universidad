#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[]){

    int pid = getpid();
    int a = 0, i, j;
    
    if (argc != 2) {
        // ! Funionamiento Normal

       
        for (i = 0; i < 20000; i ++){     
            a++;
            for (j = 0; j < 20000; j ++){
                a++;
                    
            }
            if ((i%5000) == 0) {
                printf("El proceso pagos.c con PID: %d, sigue ejecutándose\n", pid);
            }
        }
        printf("\nEl proceso pagos.c con PID: %d ha terminado.\n", pid);
        return 0;

    }
    else {
        // ! Funionamiento Largo ~ 8 segundos

        for (i = 0; i < 200000; i ++){     
            a++;
            for (j = 0; j < 20000; j ++){
                a++;
                    
            }
            if ((i%5000) == 0) {
                printf("El proceso pagos.c con PID: %d, sigue ejecutándose\n", pid);
            }
        }
        printf("\nEl proceso pagos.c con PID: %d ha terminado.\n", pid);
        return 0;


    }
    
    

}