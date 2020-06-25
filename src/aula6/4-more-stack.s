@Esse código foi desenvolvido para a aula 6 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula6/4-more-stack 4-more-stack.s

@To run and debug:
@gdb 4-more-stack
@na pasta bin/aula6
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .global main
@main to test the codes 
main:
    LDR r0, four
    LDR r1, input1
    BL push
    LDR r0, two
    LDRH r1, input2
    BL push
    LDR r0, one
    LDRB r1, input3
    BL push
    B end



@push to stack func
@push will be implemented in a full descending stack
@r0 indicates data type 1 for byte, 2 for halfword, 4 for word
@r1 data to be pushed
push:
SUB sp, sp, r0 @updates stack pointer to next empty of data type
CMP r0, #4
BEQ storeword
CMP r0, #2
BEQ storehalfword
CMP r0, #1
BEQ storebyte
storeword:
STR r1, [sp] @store the data 
BX lr
storehalfword:
STRH r1, [sp] @store the data 
BX lr
storebyte:
STRB r1, [sp] @store the data 
BX lr

end:
    MOV r7, r0            @ breakpoint before swi
    SWI 0x123456

one: .word 1
two: .word 2
four: .word 4
input1: .word 10
input2: .hword 0x10
input3: .byte 4
.align  1
