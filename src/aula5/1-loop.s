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
    .global main
 
main:
    ldr r0, addrA    @carrega endereço de a
    ldr r1, addrB    @carrega endereço de b
    ldr r3, =0x0     @ i
    ldr r7, =0x07
    ldr r8, =0x08    @ carrega o numero 8
inicializa_A:                @ coloca em 0x4000 e nos endereços seguintes os valores de um array A [1,1,1,1,1,1,1,1]
    ldr r2, =0x1                
    str r2, [r0, r3, lsl#2]
    add r3, r3, #0x01        @ i = i + 1
    cmp r8, r3               @ compara 8 com i 
    bne inicializa_A         @ se o resultado for 0 para
    ldr r3, =0x0             @ i = 0
    ldr r2, =0x0
inicializa_B:                @ coloca em 0x5000 e nos endereços seguintes os valores de um array B [0,1,2,3,4,5,6,7]
    str r2, [r1, r3, lsl#2]
    add r3, r3, #0x01        @ i = i + 1
    add r2, r2, #0x01        @ incremenmta r2
    cmp r8, r3               @ compara 8 com i 
    bne inicializa_B         @ se o resultado for 0 para
    ldr r3, =0x0             @ i = 0
loop:
    sub r11, r7, r3             @ r11 = 7 - i
    ldr r2, [r1, r11, lsl#2]    @ carrega o valor guardado no endereco de B[7 - i] em r5
    str r2, [r0, r3, lsl#2]     @ guarda o valor calculado no endereco de a[i*]
    add r3, r3, #0x01           @ i = i + 1
    cmp r8, r3                  @ compara 8 com i 
    bne loop                    @ se o resultado for 0 para
end:
    MOV r7, r0            @ breakpoint before swi
    SWI 0x123456

array_a: .word 1,1,1,1,1,1,1,1
array_b: .word 0,1,2,3,4,5,6,7
addrA: .word 0x4000
addrB: .word 0x5000
