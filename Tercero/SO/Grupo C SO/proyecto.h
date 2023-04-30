
#ifndef _TipoDelProceso_H
#define _TipoDelProceso_H
int TipoDelProceso(struct task_struct *);
#endif

#ifndef _clasificar_proceso_H
#define _clasificar_proceso_H
void clasificar_proceso(struct task_struct *, int );
#endif

#ifndef _contar_procesos_H
#define _contar_procesos_H
int contar_procesos(int);
#endif

#ifndef _matar_proceso_H
#define _matar_proceso_H
void matar_proceso(struct task_struct *);
#endif

#ifndef _contar_tiempo_proceso_H
#define _contar_tiempo_proceso_H
void contar_tiempo_proceso();
#endif

#ifndef _check_espacio_H
#define _check_espacio_H
void check_espacio( struct task_struct *,int , int );
#endif