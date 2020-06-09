@Esse código foi desenvolvido para a aula 5 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula5/3-maximum-value 3-maximum-value.s

@To run and debug:
@arm-elf-gdb 3-maximum-value
@na pasta bin/aula5
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:

end:
    MOV r7, r0  @ breakpoint before swi
    SWI 0x123456