#include <linux/string.h>
#include <linux/list.h>
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/syscalls.h>
#include <linux/linkage.h>
#include <linux/proyecto.h>
#include <linux/pid_namespace.h>
#include <asm/cputime.h>
#include <linux/proyecto.h>

#define Numero_maximo_procesos  15;
#define Numero_maximo_procesos_espera  20;
#define tiempo_maximo  10;


//////// Función para obtener el tipo de proceso ////////

int TipoDelProceso(struct task_struct *p){
    printk(KERN_NOTICE "entra en TipoDelProceso()");
    char *NombreDelProceso;
    NombreDelProceso = p -> comm;
    
    if (!strcmp(NombreDelProceso,"AdminMant"))
    {
        return 10;
    }

    if (!strcmp(NombreDelProceso,"pagos"))
    {
        return 8;
    }

    if (!strcmp(NombreDelProceso,"anulaciones"))
    {
        return 6;
    }

    if (!strcmp(NombreDelProceso,"reservas"))
    {
        return 4;
    }

    if (!strcmp(NombreDelProceso,"consultas"))
    {
        return 2;
    }

    return 0;
}

////////////////////////////////////////////////////////////////

//////// Función que clasifica los procesos de acuerdo a los Algoritmos de gestión de CPU propuestos ////////////

void clasificar_proceso(struct task_struct *p, int nuestro_proceso){
    printk(KERN_NOTICE "entra en clasificar_proceso()");
    struct sched_param Parametros;
    //struct rlimit RL;  

    if (nuestro_proceso == 10){
        Parametros.sched_priority = 90 ;
        sched_setscheduler(p,SCHED_RR,&Parametros);
        //RL.rlim_cur = numero;
        //RL.rlim_max = numero;
        //do_prlimit(p,RLIMIT_CPU,&RL,NULL);
    }

    if (nuestro_proceso == 8){
        Parametros.sched_priority = 80 ;
        sched_setscheduler(p,SCHED_FIFO,&Parametros);
        //RL.rlim_cur = numero;
        //RL.rlim_max = numero;
        //do_prlimit(p,RLIMIT_CPU,&RL,NULL);
    }

    if (nuestro_proceso == 6){
        Parametros.sched_priority = 70 ;
        sched_setscheduler(p,SCHED_FIFO,&Parametros);
        //RL.rlim_cur = numero;
        //RL.rlim_max = numero;
        //do_prlimit(p,RLIMIT_CPU,&RL,NULL);
    }

    if (nuestro_proceso == 4){
        Parametros.sched_priority = 60 ;
        sched_setscheduler(p,SCHED_FIFO,&Parametros);
        //RL.rlim_cur = numero;
        //RL.rlim_max = numero;
        //do_prlimit(p,RLIMIT_CPU,&RL,NULL);
    }

    if (nuestro_proceso == 2){
        Parametros.sched_priority = 50 ;
        sched_setscheduler(p,SCHED_RR,&Parametros);
        //RL.rlim_cur = numero;
        //RL.rlim_max = numero;
        //do_prlimit(p,RLIMIT_CPU,&RL,NULL);
    }
    return;
}

///////////////////////////////////////////////////////////////

////// Función que nos permite contar los procesos que hay en la cola //////////

int contar_procesos(int nuestro_proceso){
    printk(KERN_NOTICE "entra en contar_procesos()");
    struct task_struct *p;
    static int contador = 0;

    switch (nuetro_proceso)
    {
    case 10:
        contador++;
        break;
    
    case 8:
        contador++;
        break;

    case 6:
        contador++;
        break;

    case 4:
        contador++;
        break;

    case 2:
        contador++;
        break;

    case 20:
        contador--;
        break;

    default:
        return contador;
    }
    return contador;
}

///////////////////////////////////////////////////////////////////

//////////// Funcion que mata a un proceso ////////////////////////
 
 void matar_proceso(struct task_struct *p){    //si check_espacio devuelve un 2, llamo a esta funcion mandando como parametro "current"
    printk(KERN_NOTICE "entra en matar_proceso()");

    sys_kill(p->pid,9);
    contar_procesos(20);
    //kill_pid( find_vpid(p->pid), SIGKILL, 0 );
    return;

 }

//////////////////////////////////////////////////////////////////

/////// Funcion que cuenta el tiempo que permanace un proceso en la CPU ///////////

void contar_tiempo_proceso(){
    printk(KERN_NOTICE "entra en contar_tiempo_proceso()");
    struct task_struct *p;
    for_each_process(p) {

        if( !strcmp(p->comm, "pagos" ) || !strcmp(p->comm, "anulaciones")|| !strcmp(p->comm, "AdminMant") || 
             !strcmp(p->comm, "consultas")  || !strcmp(p->comm, "reservas") ) {

            unsigned long timing_process = cputime_to_secs( p->utime );

            if( timing_process > tiempo_maximo ) {
                printk(KERN_NOTICE "El proceso (PID: %d) (TIPO: %s) se ha eliminado porque ha estado ejecutandose %lu segundos\n", p->pid, p->comm, timing_process);
                matar_proceso(p);
            }

        }
    }
}

///////////////////////////////////////////////////////////////////////////////////

///////// Funcion que comprueba el estado de la cola de procesos /////////////////

void check_espacio( struct task_struct *p,int contador_procesos, int nuestro_proceso) {
    printk(KERN_NOTICE "entra en check_espacio");
    if (contador_procesos < Numero_maximo_procesos && nuestro_proceso != 0 ){
        clasificar_proceso(p,nuestro_proceso);
    }
    
    if (contador_procesos >= Numero_maximo_procesos && nuestro_proceso != 0){
        
        if (contador_procesos < Numero_maximo_procesos_espera && nuestro_proceso == 10){
    
            clasificar_proceso(p,nuestro_proceso);
        }
        
        matar_proceso(p);
    }
    
    return;

}

/////////////////////////////////////////////////////////////////////////////////
