#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>




int Comp_titulo (char *titulo){
	int len, i;	

	len = strlen (titulo);
	
	if (titulo [len - 1] != '\n'){
		printf ("Longitud excesiva\n\n");
		while (fgetc(stdin) != '\n');
		return 0;
		
	} else {
		if (len == 1){
			printf ("Longitud nula\n\n");
			return 0;
			
		} else {
			for (i = 0; i < len ; i++){
				if (titulo[i] == ' '){
					printf ("Caracteres ilegales\n\n");
					return 0;
				}
			}
		}
	}
	return 1;
}
	
	


int Comp_artista (char *artista){
	int len, i;
	
	len = strlen (artista);
	if (artista [len - 1] != '\n'){
		printf ("Longitud excesiva\n\n");
		while (fgetc (stdin) != '\n');
		return 0;
		
	} else {
		if (len == 1){
			printf ("Longitud nula\n\n");
			return 0;
			
		} else {
			for (i = 1; i < len; i++){
				if (artista[i] == ' '){
					printf ("caracteres ilegales\n\n");
					return 0;
				}
			}
		}
	}
	return 1;
}




int Comp_fecha (int *fecha){
  	
    printf("Dame la fecha: ");
    scanf("%i", fecha);
    
    if ((*fecha) < 1900 || (*fecha) > 2018){
      	printf("Valor dado incorrecto. Debe estar en [1900, 2018]\n\n");
      	while (fgetc(stdin) != '\n');
      	return 0;
      	
    } else{
    	while (fgetc(stdin) != '\n');
    	
	}
	return 1;
}




int Comp_formato (char *formato){
	
	char f [4][3] = ("LP\0", "CD\0", "DD\0", "MC\0");
	
    if (strcmp (formato, f[0]) == 0 || strcmp (formato, f[1]) == 0 || strcmp (formato, f[2]) == 0 || strcmp (formato, f[3]) == 0){
		printf ("Formato no aceptado (LP, CD, DD o MC)\n\n")
		return 0;	
	}
	
	return 1;
}




int Comp_precio (float *precio){
	
	if ((*precio) < 0 || (*precio) > 250){
		printf ("Valor dado incorrecto. Debe estar entre [0.00, 250.00]\n\n");
		return 0;
	}
	
	return 1;
}