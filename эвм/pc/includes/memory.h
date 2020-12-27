#ifndef PC_MEMORY_H
#define PC_MEMORY_H

#define RAM_SIZE 100

extern struct stRegisters registers;

enum {
    FLAG_OUT_RANGE,
    FLAG_INVALID_COMMAND,
    FLAG_OVERFLOW,
    FLAG_DIV_ZERO,
    FLAG_IGNORE_CLOCK,
    FLAGS_END
};

struct stRegisters {
    int accumulator : 15;
    int padding : 17;
    unsigned short instruction_counter : 7;
    unsigned short flags : 10;
};

int sc_regInit();
int sc_memoryInit();

int sc_isCommand(int value);
int sc_regGet(int _register, int *value);

int sc_regSet(int _register, int value);
int sc_memoryLoad(const char *filename);

int sc_memorySave(const char *filename);
int sc_memorySet(int address, int value);

int sc_memoryGet(int address, int *value);
int sc_commandEncode(int command, int operand, int *value);

int sc_commandDecode(int value, int *command, int *operand);

#endif //PC_MEMORY_H
