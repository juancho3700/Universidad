#include <linux/list.h>
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/syscalls.h>
#include <linux/linkage.h>
#include <linux/pid_namespace.h>
#include <asm/cputime.h>

int clasificar_proceso (struct task_struct*);

void finalizar_proceso (struct task_struct*);

void contar_tiempo_procesos (void);