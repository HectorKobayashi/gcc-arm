@Esse código foi desenvolvido para a aula 5 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula5/3-maximum-value 3-maximum-value.s
@O enunciado pede para armazenar em 0x5006. Não é múltiplo de 4. Por isso vamos mudar
@   para 5004

@To run and debug:
@gdb 3-maximum-value
@na pasta bin/aula5
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:
    LDR r5, size    @ r5 = tamanho da série
    LDR r4, maximum_value_address     @ r4 = endereço para guardar o maior valor
    LDR r3, values_address  @ r3 = endereço para guardar os valores
    ADR r2, values  @ r2 = endereço onde os valores estão armazenados
    
initialize_values:
    LDR r1, =0x0     @ r1 = contador = 0
loop_initialize_values:
    CMP r1, r5
    BEQ find_max_values
    LDR r0, [r2, r1, lsl#2]
    STR r0, [r3]
    ADD r3, r3, #4
    ADD r1, r1, #1
    B loop_initialize_values

find_max_values:
    LDR r1, =0x0     @ r1 = contador = 0
    LDR r3, values_address
    LDR r6, =0x0     @ r6 = old value
loop_find_max_values:
    LDR r0, [r3]
    CMP r0, r6
    MOVGE r6, r0
    ADD r1, r1, #1
    ADD r3, r3, #4
    CMP r1, r5
    BNE loop_find_max_values

end:
    STR r6, [r4]
    MOV r7, r0  @ breakpoint before swi
    SWI 0x123456

size: .word 0xB @ 11
maximum_value_address: .word 0x5000
values_address: .word 0x5004
values:
    .word 0x1
    .word 0x2
    .word 0x3
    .word 0x4
    .word 0x5
    .word 0x6
    .word 0x7
    .word 0x8
    .word 0x9
    .word 0xA
    .word 0xB
