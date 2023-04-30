#include <linux/list.h>
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/syscalls.h>
#include <linux/linkage.h>
#include <linux/pid_namespace.h>
#include <asm/cputime.h>
#include <linux/proyecto.h>

#define NUM_MAX_PROCESOS 10
#define NUM_MAX_PROCESOS_EXTRA 5
#define T_MAX 1

int contador_procesos = 0;
int contador_procesos_extra = 0;

//////// Función que clasifica los procesos de acuerdo a los Algoritmos de gestión de CPU propuestos ////////////

int clasificar_proceso (struct task_struct *pcb_proceso) {

    struct sched_param Parametros;
    printk (KERN_NOTICE "El proceso entra en clasificar_proceso ()"); 

    if (contador_procesos == NUM_MAX_PROCESOS) {

        if (!strcmp (pcb_proceso -> comm, "anulaciones") || !strcmp (pcb_proceso -> comm, "pagos") || !strcmp (pcb_proceso -> comm, "reservas") || !strcmp (pcb_proceso -> comm, "consultas")) {

            printk (KERN_NOTICE "La cola de procesos esta llena y no se puede encolar un proceso distinto a procesos de Administracion y Mantenimiento");
            sys_kill (pcb_proceso -> pid, 9);
            return -1;
        }

        if (!strcmp (pcb_proceso -> comm, "AdminMant")) {

            if (contador_procesos_extra == NUM_MAX_PROCESOS_EXTRA) {

                struct task_struct *proceso_aux;
                int prioridad = 90, pid_victima = 0;

                printk (KERN_NOTICE "Buscando victima a la que echar para dejar espacio . . .");
                
                for_each_process (proceso_aux) {

                    if (!strcmp (pcb_proceso -> comm, "anulaciones") && prioridad > 80) {

                        int prioridad = 80;
                        pid_victima = proceso_aux -> pid;

                    } else if (!strcmp (pcb_proceso -> comm, "pagos") && prioridad > 70) {

                        prioridad = 70;
                        pid_victima = proceso_aux -> pid;

                    } else if (!strcmp (pcb_proceso -> comm, "reservas") && prioridad > 60) {

                        prioridad = 60;
                        pid_victima = proceso_aux -> pid;

                    } else if (!strcmp (pcb_proceso -> comm, "reservas") && prioridad > 60) {

                        prioridad = 50;
                        pid_victima = proceso_aux -> pid;
                        break;

                    }
                }

                if (prioridad == 90) {

                    printk (KERN_NOTICE "No hay procesos para utilizar como victima. Finalizando proceso . . .");
                    sys_kill (pcb_proceso -> pid, 9);
                    return -1;

                } else {

                    printk (KERN_NOTICE "Se eliminara el proceso %i", pid_victima);
                    sys_kill (pid_victima, 9);
                    Parametros.sched_priority = 90 ;
                    sched_setscheduler (pcb_proceso, SCHED_RR, &Parametros);
                    return 0;
                }

            } else {

                printk (KERN_NOTICE "El proceso de Administracion y Mantenimiento se encolara en el sistema con un hueco de la cola extra");
                Parametros.sched_priority = 90 ;
                sched_setscheduler (pcb_proceso, SCHED_RR, &Parametros);
                contador_procesos ++;
                return 0;

            }
        }
    }

    if (!strcmp (pcb_proceso -> comm, "AdminMant")) {

        Parametros.sched_priority = 90 ;
        sched_setscheduler (pcb_proceso, SCHED_RR, &Parametros);
        contador_procesos ++;
        return 0;
    }

    if (!strcmp (pcb_proceso -> comm, "anulaciones")) {

        Parametros.sched_priority = 80 ;
        sched_setscheduler (pcb_proceso, SCHED_FIFO, &Parametros);
        contador_procesos ++;
        return 0;
    }

    if (!strcmp (pcb_proceso -> comm, "pagos")) {

        Parametros.sched_priority = 70 ;
        sched_setscheduler (pcb_proceso, SCHED_FIFO, &Parametros);
        contador_procesos ++;
        return 0;
    }

    if (!strcmp (pcb_proceso -> comm, "reservas")) {

        Parametros.sched_priority = 60 ;
        sched_setscheduler (pcb_proceso, SCHED_FIFO, &Parametros);
        contador_procesos ++;
        return 0;
    }

    if (!strcmp (pcb_proceso -> comm, "consultas")) {

        Parametros.sched_priority = 50 ;
        sched_setscheduler (pcb_proceso, SCHED_RR, &Parametros);
        contador_procesos ++;
        return 0;
    }

    return -1;
}


//////////// Funcion que mata a un proceso ////////////////////////
 
void finalizar_proceso (struct task_struct *pcb_proceso) {

    if (strcmp (pcb_proceso -> comm, "pagos" ) != 0 && strcmp (pcb_proceso -> comm, "anulaciones") != 0 && strcmp (pcb_proceso -> comm, "AdminMant") != 0 && strcmp (pcb_proceso -> comm, "consultas") != 0 && strcmp (pcb_proceso -> comm, "reservas") != 0) {

        return;
    }
    
    printk (KERN_NOTICE "entra en finalizar_proceso ()");
    sys_kill (pcb_proceso -> pid, 9);

    if (contador_procesos_extra > 0) {

        contador_procesos_extra --;

    } else {

        contador_procesos --;
    }

    return;
}

//////////////////////////////////////////////////////////////////

/////// Funcion que cuenta el tiempo que permanace un proceso en la CPU ///////////

void contar_tiempo_procesos () {

    struct task_struct *pcb_proceso;
    
    for_each_process (pcb_proceso) {

        if (!strcmp (pcb_proceso -> comm, "pagos" ) || !strcmp (pcb_proceso -> comm, "anulaciones") || !strcmp (pcb_proceso -> comm, "AdminMant") || 
            !strcmp (pcb_proceso -> comm, "consultas") || !strcmp (pcb_proceso -> comm, "reservas")) {

            unsigned long timing_process = cputime_to_secs (pcb_proceso -> utime);
            printk (KERN_NOTICE "Entra en contar_tiempo_proceso (). Comprobando proceso de PID %d\n", pcb_proceso -> pid);

            if(timing_process > T_MAX) {

                printk(KERN_NOTICE "El proceso (PID: %d) (TIPO: %s) se ha eliminado porque ha estado ejecutandose %lu segundos\n", pcb_proceso -> pid, pcb_proceso -> comm, timing_process);
                finalizar_proceso (pcb_proceso);
            }
        }
    }
}