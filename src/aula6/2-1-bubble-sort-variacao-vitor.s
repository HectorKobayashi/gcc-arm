@Esse código foi desenvolvido para a aula 6 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula6/2-1-bubble-sort-variacao-vitor 2-1-bubble-sort-variacao-vitor.s

@To run and debug:
@gdb 2-1-bubble-sort-variacao-vitor
@na pasta bin/aula6
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .global main
 
main:
    ADR r0, input @ r0 = *input 0
    LDR r1, input_size @ r1 = length(input)
    BL bubble_sort
    B endProgram


bubble_sort: @r0 = input address r1=input_size
    STMFD sp!, {r2, r3, r4, r5, r8, lr} @ Store stack
    LDR r8, one
    ADD r3, r0, r1, lsl#2 @ r3 = *input[n]
loop1:
    MOV r2, r0 @ r2 = *input[0]
    CMP r2, r3
    BGE end_loop1
loop2:
    CMP r2, r3 @is at the end?
    BGE end_loop2
    LDMIA r2, {r4,r5} @load r4 and r5 with value and next value
    CMP R5, R4
    BLLE swap
    ADD r2, r2, r8, lsl#2 @increment base
    B loop2
end_loop2:
    SUB r3, r3, r8, lsl#2 @updates r3 to *input[N - 1]
    B loop1
end_loop1:
    LDMFD sp!,  {r2, r3, r4, r5, r8, lr}@ load stack
    BX lr

@ swap(r2, r4, r5)
@   r2: address of a value 1, next to value 2
@   r4: value 1 to swap
@   r5: valu2 2 to swap
@r8 = 1
swap:
    STR r5, [r2]
    STR r4, [r2,r8, lsl #2]
    BX lr

endProgram:
    MOV r7, r0            @ breakpoint before swi
    SWI 0x123456


input: .word 0x8, 0x2, 0x3, 0x1, 0x5, 0x6, 0x5, 0x8
input_size: .word 8
zero: .word 0
one: .word 1


