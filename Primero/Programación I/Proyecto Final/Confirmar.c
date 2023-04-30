#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int confirmar(void) {
	char s;
	int salir = 1;
  
	printf("\nSeguro que desea salir del programa? (s/n): ");
	scanf ("%c", &s);
	while (fgetc (stdin) != '\n');

	s = tolower (s);
	if (s == 's'){
		salir = 0;
	}
	return (salir == 1);
}