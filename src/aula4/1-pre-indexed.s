@Esse código foi desenvolvido para a aula 4 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula4/1-pre-indexed 1-pre-indexed.s

@To run and debug:
@arm-elf-gdb 1-pre-indexed
@na pasta bin/aula4
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:
    ADR r2, array   @ base array address loading
    LDR r1, y    @ loading value for y
    LDR r3, index   @ load index 5
    MOV r3, r3, lsl #2  @ multiplicates by 4 to correspond to byte addressing
    LDR r0, [r2, r3]    @ pre index loading from the array[5]
    ADD r0, r0, r1 @ array[5] + y
end:
    MOV r7, r0  @ breakpoint before swi
    SWI 0x123456

array: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
y: .word 0x7
index: .word 0x5