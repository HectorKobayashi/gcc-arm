@Esse código foi desenvolvido para a aula 3 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula4/4-b-pointer 4-b-pointer.s

@To run and debug:
@arm-elf-gdb 4-b-pointer
@na pasta bin/aula4
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:
    LDR r4, zero
    LDR r5, um
    LDR r2, s
    ADR r3, array @p = &array[0]
    ADD r6, r3, r2 @pmax = &array[s]
loop:
    CMP r3, r6
    BGE end @compare p < &array[s]
    STR r4, [r3,r5]
    ADD r3, r3, r5
    B loop
end:
    SWI 0x0

array: .byte 0,1,2,3,4,5
zero: .word 0x0
um: .word 1
s: .word 6