#ifndef PC_BIGCHARS_H
#define PC_BIGCHARS_H

#include "term.h"

#define ACS_ULCORNER "╔" /* upper left corner */
#define ACS_LLCORNER "╚" /* lower left corner */
#define ACS_URCORNER "╗" /* upper right corner */
#define ACS_LRCORNER "╝" /* lower right corner */
#define ACS_HLINE "-" /* horizontal line */
#define ACS_VLINE "│" /* vertical line */
#define ACS_CKBOARD "a" /* checker board (stipple) */

int bc_printA(char * str);
int bc_box(int x1, int y1, int x2, int y2);
int bc_printbigchar(int *big, int x, int y, colors color, colors background);
int bc_setbigcharpos(int * big, int x, int y, int value);
int bc_getbigcharpos(int * big, int x, int y, int *value);
int bc_bigcharwrite(int fd, int * big, int count);
int bc_bigcharread(int fd, int * big, int need_count, int * count);

#endif //PC_BIGCHARS_H
