clear
gcc -Wall inicio+receptor.c -o rec -lpthread
gcc -Wall proceso_general.c -o p -lpthread
gcc -Wall proceso_consultas.c -o cons -lpthread
#gcc -Wall inicio.c -o inicio -lpthread