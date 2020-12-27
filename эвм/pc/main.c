#include <stdio.h>
#include <sys/time.h>
#include <string.h>
#include "bigChars.h"
#include "memory.h"
#include "readKey.h"
#include "ui.h"
#include "term.h"
#include "signals.h"
#include "asm.h"
#include "basic.h"
#include "cpu.h"
#include <signal.h>
#include <stdlib.h>

void read_console(int *value) {
    printf("Enter: ");
    rk_mytermregime(0, 0, 1, 1, 1);
    scanf("%X", value);
}

int main(int argc, char **argv) {
    eKeys key_down;
    int flag;
    signal(SIGUSR1, signalhangle);
    signal(SIGALRM, signalhangle);
    sc_memoryInit();
    sc_regInit();
    interface_load(WHITE, BLACK, GREEN);
    sc_regSet(FLAG_IGNORE_CLOCK, 1);
    while (1) {
        interface_print();
        rk_readkey(&key_down);
        if (key_down == VK_RUN) {
            sc_regSet(FLAG_IGNORE_CLOCK, 0);
            create_timer(0.05);
        } else if (key_down == VK_RESET) {
            create_timer(0);
            raise(SIGUSR1);
        } else if (key_down == VK_QUIT) {
            break;
        } else if (!sc_regGet(FLAG_IGNORE_CLOCK, &flag) && flag) {
            switch (key_down) {
                case VK_DARROW:
                    if (select_cell < 90)
                        select_cell += 10;
                    break;
                case VK_UARROW:
                    if (select_cell > 9)
                        select_cell -= 10;
                    break;
                case VK_LARROW:
                    if (select_cell > 0)
                        --select_cell;
                    break;
                case VK_RARROW:
                    if (select_cell < 99)
                        ++select_cell;
                    break;
                case VK_STEP:
                     CU();
                    break;
                case VK_LOAD: {
                    char filename[64];
                    read_console_filename(filename, 63);
                    char* ptr1 = strrchr(filename, '.');
                    if (ptr1 != NULL) {
                        if (strcmp(ptr1, ".sa") == 0) {
                            char *ptr = NULL;
                            int size = strlen(filename);
                            ptr = malloc(sizeof(char) * size);
                            for (int i = 0; i < size; i++) ptr[i] = filename[i];
                            ptr[size - 1] = 'o';
                            ptr[size] = '\0';
                            asm_to_object(filename, ptr);
                            sc_memoryLoad(ptr);
                        } else if (strcmp(ptr1, ".sb") == 0) {

                            char *ptr = NULL;
                            int size = strlen(filename);
                            ptr = malloc(sizeof(char) * size);
                            for (int i = 0; i < size; i++) ptr[i] = filename[i];
                            ptr[size - 1] = 'a';
                            ptr[size] = '\0';
                            basic_to_asm(filename, ptr);
                            filename[size - 1] = 'o';
                            filename[size] = '\0';
                            asm_to_object(ptr, filename);
                            sc_memoryLoad(filename);
                        } else if (strcmp(ptr1, ".so") == 0) {
                            sc_memoryLoad(filename);
                        }
                    }
                }
                    break;
                case VK_SAVE: {
                    char filename[64];
                    read_console_filename(filename, 63);
                    sc_memorySave(filename);
                }
                    break;
                case VK_F5: {
                    int val;
                    read_console(&val);
                    registers.accumulator = val & 0x7FFF;
                }
                    break;
                case VK_F6: {
                    int val;
                    read_console(&val);
                    registers.instruction_counter = ((unsigned short)val) & 0x7F;
                }
                    break;
            }
        }
    }
    mt_reset();
    return 0;
}