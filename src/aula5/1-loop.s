@Esse código foi desenvolvido para a aula 5 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula5/1-loop 1-loop.s

@To run and debug:
@arm-elf-gdb 1-loop
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