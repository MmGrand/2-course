#ifndef PC_TERM_H
#define PC_TERM_H

typedef enum {
    BLACK = 0,  //always first
    RED,
    GREEN,
    YELLOW,
    BLUE,
    PURPLE,
    CYAN,
    WHITE       //always last
} colors;

int mt_reset(void);
int mt_clrscr(void);
int mt_gotoXY(int x, int y);
int mt_setfgcolor(colors color);
int mt_setbgcolor(colors color);
int mt_getscreensize(int *rows, int *cols);

#endif //PC_TERM_H
