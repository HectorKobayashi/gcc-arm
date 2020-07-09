// @Esse código foi desenvolvido para a aula 8 do curso PCS3732- Laboratório de Processadores - 2020
// @Feito pelos alunos:
// @Felipe Kenzo Shiraishi - 10262700
// @Hector Kobayashi Yassuda - 10333289
// @Vitor Hugo Perles - 9285492

// @Para compilar
// @arm-elf-gcc -Wall -g -o imprime.out imprime.c int2str.s division.s

// @To run and debug:
// @gdb imprime.out
// @(gdb) target sim
// @(gdb) load
// @(gdb) break main
// @(gdb) run
// @(gdb) continue

#include <stdio.h>

extern int int2str(int a, char* b);

void imprime(N) {
  if (N<0) {
    return;
  }
  puts("numero = ");
  char *b;
  int2str(N, b);
  puts(b);
  imprime(N-1);
}


int main(void ) {
     imprime(5);
     return 0;
}
