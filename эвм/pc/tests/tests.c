#include "tests.h"

int TestMemory() {
    sc_memoryInit();
    sc_regInit();
    int flag;
    printf("call sc_memorySet(0, 1234) return: %d\n", sc_memorySet(0, 1234));
    printf("call sc_memorySet(-4, 1) return: %d\n", sc_memorySet(-4, 1));
    printf("call sc_memorySet(1000, 1) return: %d\n", sc_memorySet(1000, 1));
    sc_regGet(FLAG_OUT_RANGE, &flag);
    printf("Flag OUT_RANGE: %d\n", flag);
    sc_regGet(FLAG_INVALID_COMMAND, &flag);
    printf("Flag INVALID_COMMAND: %d\n", flag);
    return 0;
}

int TestBigChars() {
    int big[] = {0x79858579, 0x79858585};
    mt_clrscr();
    bc_box(5, 1, 10, 10);
    bc_printbigchar(big, 6, 2, RED, BLUE);
    printf("\n");
    mt_gotoXY(0, 0);
    getchar();
    mt_reset();
    return 0;
}

int TestTerm() {
    mt_setbgcolor(YELLOW);
    mt_setfgcolor(CYAN);
    mt_clrscr();
    getchar();

    int maxx, maxy;
    mt_getscreensize(&maxx, &maxy);
    mt_gotoXY(maxx / 2, maxy / 2 - strlen("Hello, world!") / 2);
    printf("Hello, world!");

    getchar();
    mt_reset();
    return 0;
}



