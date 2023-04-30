#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#define N 50

struct unDisco{
  char titulo[33];
  char artista[26];
  int fecha;
  char formato[3];
  float precio;
  int lleno;
};

void Listado (){
	
	struct unDisco lista_discos[N];
	char opcion;
	int i, rep = 1;
	
	printf ("G) General\n");
	printf ("A) Por artista\n");
	printf ("F) Por formato\n");
	printf ("Y) Por fecha\n\n");
	printf ("Elige una opcion: ");
	
	scanf ("%c", &opcion);
	opcion = toupper (opcion);
	
	printf ("%c", opcion);
	
	switch (opcion){
		case "G":
			printf ("\nListado general de los discos\n\n");
			for (i = 0; rep == 1; i++){
				if (lista_discos[i].lleno == 0){
					printf ("%s | %s | %i | %s | %f", lista_discos[i].titulo, lista_discos[i].artista, lista_discos[i].fecha, lista_discos[i].formato, lista_discos[i].precio);
				} else {
					break;
				}
				break;
			}
		
		case "A":
				
	}
	
}


int main (){
	
	Listado();
	
	
	return 0;
}
