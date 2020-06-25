@Esse código foi desenvolvido para a aula 6 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula6/3-magic-square 3-magic-square.s

@To run and debug:
@gdb 3-magic-square
@na pasta bin/aula6
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

        .text
    .global main

main:
    adr r0, addr0            @carrega o valor no endereço inicial
    ldr r1, var0             @carrega a veariavel n
    mul r2, r1, r1           @ r2 = n * n   
    add r3, r2, #0x1         @ n * n +1
    mul r2, r3, r1           @ n(n*n +1)
    mov r2, r2, lsr #1       @ r2 = n(n*n +1)/2   numero magico
    bl numbers               
    mov r3, #0x0             @ contador de endereco
    mov r4, #0x0             @ soma temp           
    mov r6, #0x0             @ contador externo
    mov r7, #0x0            
    mov r9, #0x0            
    add r11, r1, #0x1        @ r11 = n+1
    sub r12, r1, #0x1        @ r12 = n-1
    bl magic_square_line
    bl magic_square_column
    bl magic_square_d
    bl magic_square_s   
    b magik
not_magik:
    b end
magik:
    mov r9, #0x1
    b end
end:
    add r8, r8, #0x0
    swi 0x1


numbers:                     @ checa se o quadrado tem todos os numeros de 1 a n*n
    mov r3, #0x0
    mul r10, r1, r1          @ comeca checando de n*n ate 1
    mov r4, r10
loop_nu:
    ldrb r5, [r0, r3]        @ r5 = r0[i] carrega um byte
    add r3, r3, #0x1         @ incrementa o valor do indice
    cmp r10,r5 
    beq next_nu              @ se for igual checa proximo numero
    cmp r4, r3              
    bne loop_nu 
    b not_magik              @ se chegar ao final sem achar o numero nao eh magico
next_nu:
    sub r10, r10, #0x1       @checaremos o proximo numero
    mov r3, #0x0
    cmp r10, #0x0
    bne loop_nu
    MOV pc, lr

magic_square_line:           @checa se todas as somas das linhas resulta no valor magico
    STR lr, [sp, #-4]!
    mov r10, #0x1
loop_sl:
    bl magik_loop
    mov r4, #0x0           @reseta variaveis
    mov r7, #0x0
    add r6, r6, #0x01      
    cmp r1, r6             @confere se todas as linhas foram checadas
    bne loop_sl
    LDR lr, [sp], #4
    MOV pc, lr

magic_square_column:    @checa se todas as somas das colunas resulta no valor magico
    STR lr, [sp, #-4]!
    mov r10, r1
    mov r3, #0x0             
    mov r4, #0x0
    mov r6, #0x0
    mov r7, #0x0
loop_sc:
    bl magik_loop                      
    mov r4, #0x0
    mov r7, #0x0
    add r6, r6, #0x01
    mov r3, r6          @ r3 = r6 comeca a proxima coluna
    cmp r1, r6
    bne loop_sc
    LDR lr, [sp], #4
    MOV pc, lr

magic_square_d:          @checa se a soma da diagonal principal eh magica    
    STR lr, [sp, #-4]! 
    mov r10, r11          @move de n+1
    mov r3, #0x0             
    mov r4, #0x0
    mov r7, #0x0
    bl magik_loop
    LDR lr, [sp], #4
    MOV pc, lr

magic_square_s:          @checa se a soma da diagonal secundaria eh magica    
    STR lr, [sp, #-4]! 
    mov r10, r12         @move de n-1
    mov r3, r12          @comeca do n-1  
    mov r4, #0x0
    mov r7, #0x0
    bl magik_loop 
    LDR lr, [sp], #4
    MOV pc, lr

magik_loop:                  @ loop para checar se a soma de linha, coluna, diagonal é mágica
    ldrb r5, [r0, r3]        @r5 = r0[i] carrega um byte
    add r4, r4, r5           @r4 = r4 + r5
    add r3, r3, r10          @ incrementa o valor dependendo do que se quer conferir (linha, coluna, diagonal)
    add r7, r7, #0x1         
    cmp r1, r7               @ confere se foram somados n elementos
    bne magik_loop 
    cmp r2, r4               @ confere se a soma eh magika
    bne not_magik    
    MOV pc, lr

addr0: .byte 16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4, 15, 14, 1
addr1: .byte 60, 53, 44, 37, 4, 13, 20, 29, 3, 14, 19, 30, 59, 54, 43, 38, 58, 55, 42, 39, 2, 15, 18, 31, 1, 16, 17, 32, 57, 56, 41, 40, 61, 52, 45, 36, 5, 12, 21, 28, 6, 11, 22, 27, 62, 51, 46, 35, 63, 50, 47, 34, 7, 10, 23, 26, 8, 9, 24, 25, 64, 49, 48, 33
addr2: .byte 5,5,5,5,5,5,5,5,5,0
addr3: .byte 4, 9, 2, 3, 5, 7, 8, 1, 6
var:  .word 0x0
var0: .word 0x4
var1: .word 0x8
var2: .word 0x3
var3: .word 0x3

