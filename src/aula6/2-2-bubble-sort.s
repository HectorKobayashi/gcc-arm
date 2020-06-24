@Esse código foi desenvolvido para a aula 6 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula6/2-2-bubble-sort 2-2-bubble-sort.s

@To run and debug:
@gdb 2-2-bubble-sort
@na pasta bin/aula6
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .global main
 
main:
    ADR r0, input @ r0 = input[0]
    LDR r1, input_size @ r1 = length(input)
    LDR r6, input_stack
    BL bubble_sort
    B end

bubble_sort:
    STMFD sp!, {r1, r2, r3, r4, r5, lr} @ Store in stack registers
    BL initialize_stack
    MOV r5, r6  @ stores the beginning of the input
    LDR r4, =0x0 @ Contador = 0
bubble_sort_loop_2:
    CMP r4, r1
    BEQ bubble_sort_loop_1 @ Ends bubble sort if contador == size
    LDMFD r5, {r2, r3}  @   get the values on r2 and r3
    CMP r2, r3
    BLE next_iter   @ Swap if r2 > r3
    BL swap @ Swap pair of elements on function
next_iter:
    ADD r5, r5, #4
    ADD r4, r4, #1  @ Contador++
    B bubble_sort_loop_2   @ Repeat
end_bubble_sort:
    BL dump_stack
    LDMFD sp!, {r1, r2, r3, r4, r5, lr} @ Recover registers on stack
    MOV pc, lr  @ End function
bubble_sort_loop_1:
    SUB r1, r1, #1
    LDR r4, =0x0 @ Contador = 0
    MOV r5, r6
    CMP r1, #1
    BEQ end_bubble_sort
    B bubble_sort_loop_2

initialize_stack:
    STMFD sp!, {r2, r3, r6}
    LDR r2, =0x0 @ contador
loop_initialize_stack:
    CMP r2, r1  @ Se contador == tamanho
    BNE push_on_stack
    LDMFD sp!, {r2, r3, r6}
    MOV pc, lr
push_on_stack:
    LDR r3, [r0, r2, lsl #2]
    STR r3, [r6]
    ADD r6, r6, #4
    ADD r2, r2, #1
    B loop_initialize_stack

dump_stack:
    STMFD sp!, {r2, r3, r5}
    MOV r5, r0
    LDR r2, =0x0 @ contador
loop_dump_stack:
    CMP r2, r1  @ Se contador == tamanho
    BNE dump_on_stack
    LDMFD sp!, {r2, r3, r5}
    MOV pc, lr
dump_on_stack:
    LDR r3, [r6]
    STR r3, [r5, r2, lsl #2]
    SUB r6, r6, #4
    ADD r2, r2, #1
    B loop_dump_stack


@ swap(r0, r2, r3)
@   r5: address of the current r2 position
@   r2: address of a value
@   r3: address of the value to swap
@   puts the value stored in r3 address in r2 address and
@   puts the value stored in r2 address in r3 address.
swap:
    STMFD sp!, {r4}
    MOV r4, r2
    MOV r2, r3
    MOV r3, r4
    STMFD r5, {r2, r3}
    LDMFD sp!, {r4}
    MOV pc, lr

end:
    MOV r7, r0            @ breakpoint before swi
    SWI 0x123456

input: .word 0x8, 0x2, 0x3, 0x1, 0x5, 0x6, 0x5, 0x8
input_size: .word 8

input_stack: .word 0x4000