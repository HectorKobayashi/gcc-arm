// @Esse código foi desenvolvido para a aula 7 do curso PCS3732- Laboratório de Processadores - 2020
// @Feito pelos alunos:
// @Felipe Kenzo Shiraishi - 10262700
// @Hector Kobayashi Yassuda - 10333289
// @Vitor Hugo Perles - 9285492

// @Para compilar
// @arm-elf-gcc -Wall -g -o main.out main.c int2str.s division.s

// @To run and debug:
// @gdb imprime.out
// @(gdb) target sim
// @(gdb) load
// @(gdb) break main
// @(gdb) run
// @(gdb) continue

#include <stdio.h>
					
extern int myadd(int a, int b);
					
int main()
{
	int a = 4;
	int b = 5;
	printf("Adding %d and %d results in %d\n", a, b, myadd(a, b));
	return (0);
}