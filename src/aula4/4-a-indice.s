@Esse código foi desenvolvido para a aula 3 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula4/4-a-indice 4-a-indice.s

@To run and debug:
@arm-elf-gdb 4-a-indice
@na pasta bin/aula4
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:
    LDR r0, zero @i <= 0
    LDR r4, zero
    LDR r5, um
    LDR r2, s @r2 <= s
    ADR r1, array
loop:
    CMP r0, r2
    BGE end @compare i >= s
    STR r4, [r1,r5]
    ADD r0, r0, r5
    B loop
end:
    SWI 0x0

array: .byte 0,1,2,3,4,5
um: .word 0x1
zero: .word 0x0
s: .word 6