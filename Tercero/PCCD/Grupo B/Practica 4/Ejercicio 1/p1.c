/*
    NOTAS MUY GUAYS DEL PARAGUAY

    pthread_t: declara el identificador del hilo que se crea, necesario si quieres referirte al hilo en algun momento.
    attr: los atributos del hilo (si es NULL, usa los estandares)
    *start_routine: la función que va a hacer el hilo
    *restrict arg: los argumentos que le pasamos a la función

*/

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

int contador = 0, final = 0;

void *hagocosas (void *arg) {

    printf ("Hola, he sido creado, quiereme \n");
    char letra;


    do {
        letra = getchar ();
        contador ++;
        fflush (stdin); 

    } while (letra != 'q');

    printf ("Cerrando hilo, adios ...\n");
    final = 1;
    return arg;
}

int main () {

    int error = 0;
    pthread_t idHilo;


    error = pthread_create (&idHilo, NULL, hagocosas, NULL);
    
    printf ("%i\n", error);

    while (final == 0) {

        printf ("Ha usted tecleado por teclado : %i teclas \n", contador);
        sleep (2);
    }

    pthread_exit (NULL);
    return 0;
}