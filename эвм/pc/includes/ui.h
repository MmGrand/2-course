#ifndef PC_UI_H
#define PC_UI_H

#include "bigChars.h"

void read_console_value(int addr, int *value);
void write_console_value(int addr, int value);
void read_console_filename(char *filename, int max);
void interface_load(colors textColor, colors background, colors selectColor);
void interface_print();
extern int select_cell;

#endif //PC_UI_H
