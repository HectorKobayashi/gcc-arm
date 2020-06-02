@Esse código foi desenvolvido para a aula 4 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula4/1-post-indexed 1-post-indexed.s

@To run and debug:
@arm-elf-gdb 1-post-indexed
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
    LDR r0, [r2], r3    @ post index loading from the array (loading first entry and updating array to 5)
    LDR r0, [r2]    @ load new value on array[5]
    ADD r0, r0, r1 @ array[5] + y
end:
    MOV r7, r0  @ breakpoint before swi
    SWI 0x123456

array:
    .word 0x1
    .word 0x2
    .word 0x3
    .word 0x4
    .word 0x5
    .word 0x6
    .word 0x7
    .word 0x8
    .word 0x9
    .word 0x10
    .word 0x11
    .word 0x12
    .word 0x13
    .word 0x14
    .word 0x15
    .word 0x16
    .word 0x17
    .word 0x18
    .word 0x19
    .word 0x20
    .word 0x21
    .word 0x22
    .word 0x23
    .word 0x24
    .word 0x25

y: .word 0x7
index: .word 0x5