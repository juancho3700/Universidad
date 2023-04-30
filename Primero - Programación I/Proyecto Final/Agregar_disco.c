#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>


void A_titulo (char *titulo){
	int len, i;
	int rep = 1;

	while (rep == 1){
    	printf("Dame el titulo del disco: ");
    	fgets(titulo,33,stdin);
    
		rep = Comp_titulo (titulo);

  	} //Fin while 
}


void A_artista (char *artista){
	int len, i;
	int rep = 1;

	while (rep == 1){
    	printf("Dame el nombre del artista: ");
    	fgets(artista,26,stdin);
    
		rep = Comp_artista (artista);

  	} //Fin while 
}


void A_fecha (int *fecha){
  	int rep = 1;

  	while (rep == 1){
    	printf("Dame la fecha: ");
    	scanf("%i", fecha);
    
		rep = Comp_fecha (fecha);

  	}
}


void A_formato (char *formato){
  	
	int rep = 1;
  	
	char f[4][3] = {"LP\0", "CD\0", "DD\0", "MC\0"};

  	while (rep == 1){
    	printf("Dame el formato: ");
    	fscanf(stdin, " %s", formato);
    
		rep = Comp_formato (formato);

  	}
}


void A_precio (float *precio){
	int rep = 1;
	
	while (rep == 1){
    	printf("Dame el precio: ");
    	scanf("%f", precio);
    
		rep = Comp_precio (precio);

	}
}