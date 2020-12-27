#include "signals.h"
#include <stdio.h>
#include "ui.h"
#include <signal.h>
#include <sys/time.h>
#include "memory.h"
#include "cpu.h"

void signalhangle(int signal) {
    switch (signal) {
        case SIGALRM: {
            int val;
            if (!sc_regGet(FLAG_IGNORE_CLOCK, &val) && !val) {
                CU();
                interface_print();
            }
        }
            break;
        case SIGUSR1: {
            sc_memoryInit();
            sc_regInit();
            registers.instruction_counter = 0;
            registers.accumulator = 0;
            sc_regSet(FLAG_IGNORE_CLOCK, 1);
            select_cell = 0;
        }
            break;
    }
}

void create_timer(double interval) {
    struct itimerval nval;
    nval.it_value.tv_sec = nval.it_interval.tv_sec = (long)interval;
    nval.it_value.tv_usec = nval.it_interval.tv_usec = (long)((interval - (long)interval) * 1000000);
    setitimer (ITIMER_REAL, &nval, NULL);
}