@Esse código foi desenvolvido para a aula 4 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula4/2-pre-indexed 2-pre-indexed.s

@To run and debug:
@arm-elf-gdb 2-pre-indexed
@na pasta bin/aula4
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue    
    
    .text
    .global main
 
main:
    adr r1, array_a  @ endereco inicial de A
    adr r2, array_b  @ endereco inicial de B
    ldr r3, =0x0   @ i 
    ldr r4, varc   @ c 
    ldr r10, =0x0A  @ carrega o numero 10 
loop:
    mov r12, r3, lsl #2   @ multiplica i por 4 e guarda em r12 
    ldr r5, [r2, r12]     @ carrega o valor guardado no endereco de B[0 + i] em r5
    add r5, r5, r4        @ soma B[i*] mais a variavel c e guarda em r5
    str r5, [r1, r12]     @ guarda o valor calculado no endereco de a[i*]
    add r3, r3, #0x01     @ i = i + 1
    cmp r3, r10           @ compara 10 com i 
    ble loop              @ se o resultado for positivo para
end:    
    ldr r9, [r1]          @ confere o que existe no endereco inicial de A
    swi 0x1234
 
array_a: .word 1,1,1,1,1,1,1,1,1,1,1
array_b: .word 1,2,3,4,5,6,7,8,9,10,11
varc: .word 0x5