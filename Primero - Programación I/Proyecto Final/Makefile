CC = gcc -Wall -lm

all: Proyecto_Final


Comparadores.o: Comparadores.c Comparadores.h

	$(CC) -c Comparadores.o



Rotulo.o: Rotulo.c Rotulo.h

	$(CC) -c Rotulo.c



Agregar_disco: Agregar_disco.c Agregar_disco.h Comparadores.o

	$(CC) -c Agregar_disco.c Comparadores.o



Confirmar.o: Confirmar.c Confirmar.h

	$(CC) -c Confirmar.c



Proyecto_Final: Proyecto_Final.c Rotulo.o Agregar_disco.o Confirmar.o

	$(CC) Proyecto_Final.c Rotulo.o Agregar_disco.o Confirmar.o -o Proyecto_Final



clean:

	 rm -f *.bak *.o