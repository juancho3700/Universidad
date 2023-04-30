#include <semaphore.h>

#ifndef ESTRUCTURA_DATOS_COMPARTIDOS

#define ESTRUCTURA_DATOS_COMPARTIDOS

#define nNodos 4
#define maxPasesSC 2
#define numPrios 4

typedef struct {

    sem_t disputaSC,
          entradaSC [numPrios],
          maxProcesos,
          mutexDatos,
          sem_p_consultas,
          finConsultas;

    float ticket,
          minTicket,
          ticketPendientes [(nNodos - 1) * numPrios];

    int miId,
        idNodos [nNodos - 1],
        colaNodos [(nNodos - 1) * numPrios] [2],
        pendientes,
        esperandoSC,
        enSC,
        pasesSC,
        numSinc,
        esperandoMax,
        prioridadNodo,
        nConfirmaciones,
        nProcesosPrio [numPrios],
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