#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

void plano (int n, char simb){
	int i;

	for (i = 0; i < n; i++){
		printf ("%c", simb);
	}
	printf ("\n");
}

void lado (int n, char simb){
	int i;
  
	for (i = 0; i < n; i++){
		if (i == 0 || i == (n - 1)){
			printf ("%c", simb);
		} else {
			printf (" ");
		}
	}
	printf ("\n");
}

void rotulo (int n, char *nom, char simb){
	int i;

	printf ("%c", simb);
	for (i = 0; i < ((n / 2) - ((strlen(nom) / 2) + 1)); i++){
		printf (" ");
	}
	printf ("%s", nom);
	for (i = 0; i < ((n / 2) - ((strlen(nom) / 2) + 1)); i++){
		printf (" ");
	}
	printf ("%c\n", simb);
}