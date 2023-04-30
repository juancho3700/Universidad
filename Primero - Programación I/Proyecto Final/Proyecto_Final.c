#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include "Rotulo.h"
#include "Confirmar.h"
#include "Agregar_disco.h"
#include "Comparadores.h"

#define CARACTER '#'
#define N 50

struct unDisco{
	char titulo[33];
	char artista[26];
	int fecha;
	char formato[3];
	float precio;
	int lleno;
};

int main (){

	struct unDisco lista_discos[N];
	char Opcion;
  	int salir = 1;
  	int i;

  	for (i = 0; i < N; i++){
    	lista_discos[i].lleno = 0;
  	}

  	printf ("\n\n");
  	//Cuadro
  	plano (N, CARACTER);
  	lado (N, CARACTER);
  	rotulo (N, "MIS DISCOS", CARACTER);
  	lado (N, CARACTER);
  	plano(N, CARACTER);
  	printf ("\n");
  	//Fin cuadro


  	//Menu
  	while (salir != 0){
		printf ("\n\n");
    	printf ("A) Agregar un disco nuevo\n");
    	printf ("V) Ver datos de un disco\n");
    	printf ("T) Ver los datos de todos los discos\n");
    	printf ("L) Sacar un listado\n");
    	printf ("E) Eliminar un disco\n");
    	printf ("M) Modificar un disco existente\n\n");
    	printf ("S) Salir\n\n");
    	printf ("Elige una opcion: ");
    	scanf ("%c", &Opcion);

    	while (fgetc (stdin) != '\n');
    	printf ("\n");
    
    	Opcion = tolower(Opcion);
    
    	switch (Opcion){
      		case 'a':
        		printf ("Has seleccionado Agregar un disco\n\n");
        		A_titulo(lista_discos[0].titulo);
				A_artista(lista_discos[0].artista);
				A_fecha(&lista_discos[0].fecha);
				A_formato(lista_discos[0].formato);
    	    	break;
	
      		case 'v':
        		printf ("Has seleccionado Ver datos de un disco\n\n");
       			break;
	
	      	case 't':
    	    	printf ("Has seleccionado Ver datos de todos los discos\n\n");
				break;
	
    	  	case 'l':
        		printf ("Has seleccionado Lista de discos\n\n");
        		break;
	
    		case 'e':
        		printf ("Has seleccionado Eliminar un disco\n\n");
        		break;
	
			case 'm':
				printf ("Has seleccionado Modificar un disco existente\n\n");
				break;
	
    		case 's':
				salir = confirmar ();
    	    break;
	
    	default:
        	printf ("Has elegido una opcion no valida\n\n");
        	break;
		}
	}
  	//Fin menu

  	return 0;
}