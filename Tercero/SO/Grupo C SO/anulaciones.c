#include <stdio.h>

int main(){
    int a = 0;

    for (int i = 0; i < 20000; i ++){     
        a++;
        for (int j = 0; j < 20000; j ++){
            a++;
            if (j == 20001)
            {
                printf("El proceso anulaciones.c sigue ejecutándose\n");
            }       
        }
    }
    printf("El proceso anulaciones.c ha terminado.\n");
    return 0;

}