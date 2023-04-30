#include <semaphore.h>

#ifndef ESTRUCTURA_DATOS_COMPARTIDOS

#define ESTRUCTURA_DATOS_COMPARTIDOS

#define PATH_CLAVES "/home/selmo/Escritorio/Teleco/Tercero/PCCD/Grupo C/Codigo Final/"

#define MAX_nNodos 100
#define MAX_maxPasesSC 1000
#define MAX_numPrios 10

typedef struct {

    int nNodos,
        maxPasesSC,
        numPrios;

    sem_t disputaSC,
          entradaSC [MAX_numPrios],
          maxProcesos,
          mutexDatos,
          sem_p_consultas,
          finConsultas;
    
    float ticket,
          minTicket,
          ticketPendientes [(MAX_nNodos - 1) * MAX_numPrios];

    int miId,
        idNodos [MAX_nNodos - 1],
        colaNodos [(MAX_nNodos - 1) * MAX_numPrios] [2],
        pendientes,
        esperandoSC,
        enSC,
        pasesSC,
        numProc,
        esperandoMax,
        prioridadNodo,
        nConfirmaciones,
        nProcesosPrio [MAX_numPrios],
        esperaFinConsultas,
        esperaConsultas,
        prioridadExterna,
        bloqueoConsultas,
        numConsultas;

} zonaMem;


typedef struct {

    long mtype;
    float ticket;
    int idOrigen,
        prioridad;

} datos;

#endif


/*

    Prioridades:
    1.- Mantenimiento
    2.- Anulaciones
    3.- Pagos / Administración
    4.- Reservas
    5.- Consultas


    Mtypes:
    1.- Peticion
    2.- Confirmacion
    3.- Desbloqueo de consultas

*/