// @Esse código foi desenvolvido para a aula 8 do curso PCS3732- Laboratório de Processadores - 2020
// @Feito pelos alunos:
// @Felipe Kenzo Shiraishi - 10262700
// @Hector Kobayashi Yassuda - 10333289
// @Vitor Hugo Perles - 9285492

// @Para compilar
// @arm-elf-gcc -Wall -g -o mostra.out mostra.c int2str.s division.s

// @To run and debug:
// @gdb imprime.out
// @(gdb) target sim
// @(gdb) load
// @(gdb) break main
// @(gdb) run
// @(gdb) continue

#include <stdio.h>

int mostra;

extern int int2str(int a, char* b);

int main(){
    char *string;
    __asm ("MOV r3, %[mostra_address]\n\t"
            "LDR r2, =0x9C98AC\n\t"
            "STR r2, [r3]"
    : 
    : [mostra_address] "r" (&mostra)
  );
    int2str(mostra, string);
    puts(string);
    return 0;
}
