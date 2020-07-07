@Esse código foi desenvolvido para a aula 3 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar junto
@arm-elf-gcc -Wall -g -o ../bin/pre-p1/programa-final main.s [...].s division.s

@To run and debug:
@arm-elf-gdb division
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl division

@ r0: quociente (resultado da divisão)
@ r1: resto
@ r2: dividendo
@ r3: divisor
@ r4: tamanho em bits do dividendo
@ r5: tamanho em bits do divisor
@ r6: registrador auxiliar

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@   Call point da subrotina de divisão                                  @ 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ r3, r5 = division(r1, r2)                                             @
@   Argumentos:                                                         @
@       r1: dividendo                                                   @
@       r2: divisor                                                     @
@   Retornos:                                                           @
@       r3: quociente                                                   @
@       r5: resto                                                       @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
division:                                                                                                                             @
    STMFD sp!, {r0,r1,r2, r4, r6-r11,lr}                                                                                                            @
                                                                                                                                      @
    @Zero check
    CMP r1, #0
    LDREQ r3, =0
    LDREQ r5, =0
    BEQ endDivisao
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                                         @
    @   Definindo o tamanho do dividendo e do divisor                       @                                                         @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                                         @
    BL findSizeOfContentInBits  @   Definindo tamanho do dividendo          @                                                         @
    MOV r10, r0                                                             @                                                         @
    MOV r6, r1                                                              @                                                         @
    MOV r1, r2                                                              @                                                         @
    BL findSizeOfContentInBits  @   Definindo tamanho do divisor            @                                                         @
    MOV r11, r0                                                             @                                                         @
    MOV r1, r6                                                              @                                                         @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                                         @
                                                                                                                                      @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                            @
    @   Definindo as variáveis auxiliares                                                                @                            @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                            @
    LDR r3, =0x0              @ r3: quociente                                                            @                            @
    MOV r4, r2                @ r4: divisor usado nas subtracoes, tambem sera referido como subtrator    @                            @
    MOV r5, r1                @ r5: resto                                                                @                            @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                            @
                                                                                                                                      @
    CMP r1, r2                @ compara dividendo com divisor                                                                         @
    BLT endDivisao            @ faz o desvio se o dividendo for menor que o divisor, o quociente eh zero e o resto eh o dividendo     @
    BL divisao                  @ subrotina efetivamente responsável por realizar a divisão                                           @
endDivisao:                                                                                                                           @
    LDMFD sp!, {r0,r1, r2, r4, r6-r11, lr}                                                                                               @
    MOV pc, lr                                                                                                                        @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@   Definição de subrotina sizeOfContentInBits                          @ 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ r0 = sizeOfContentInBits(r1)                                          @
@   Argumentos:                                                         @
@       r1: valor a ser medido                                          @
@   Retornos:                                                           @
@       r0: tamanho do valor medido em bits                             @
@   Descrição:                                                          @
@       Shifta para a direita até o valor original ser 1, indicando     @
@       ter alcançado o bit mais significativo de r1. Para cada shift   @
@       realizado incrementa-se o registrador de saída                  @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
findSizeOfContentInBits:                                                @
    STMFD sp!, {r1, lr}                                                 @
    LDR r0, =0x0                                                        @
findSizeOfContentInBits_loop:                                           @
    CMP r1, #1                                                          @
    MOV r1, r1, lsr #1                                                  @
    ADD r0, r0, #1                                                      @
    BNE findSizeOfContentInBits_loop                                    @
    LDMFD sp!, {r1, lr}                                                 @
    MOV pc, lr                                                          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@   Definição de subrotina divisao                                      @ 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ r3, r5 = divisao(r2, r3, r4, r5)                                      @
@   Argumentos:                                                         @
@       r2: divisor                                                     @
@       r3: dividendo                                                   @
@       r4: divisor temporário                                          @
@       r5: dividendo temporário / resto                                @
@   Retornos:                                                           @
@       r3: quociente                                                   @
@       r5: resto                                                       @
@   Descrição:                                                          @
@       Alinha o divisor temporário com o bit mais significativo do     @
@       dividendo temporário. Se o divisor é menor ou igual do que o    @
@       dividendo, subtrai-se esse divisor shiftado do dividendo.       @
@       Em seguida, shifta-se 1 bit para a direita esse divisor         @
@       Repete-se o processo enquanto o resto for maior que o divisor   @
@       original                                                        @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
divisao:                  @executa o algoritmo da divisao                                              @
    STMFD sp!, {lr}                                                                                    @
    BL ShiftDivisor                                                                                    @
loop:                                                                                                  @
    MOV r3, r3, lsl #1    @move o quociente um bit para a esquerda                                     @
    CMP r5, r4            @compara o resto com o divisor shiftado                                      @
    BLT pula              @pula para o loop caso o divisor shiftado seja maior que o resto             @
    SUB r5, r5, r4          @subtrai o dividendo/resto pelo divisor shiftado                           @
    ADD r3, r3, #1          @adiciona um ao quociente                                                  @
pula:                                                                                                  @
    MOV r4, r4, lsr #1    @shifta o divisor um bit para a direita                                      @
    CMP r2, r4                                                                                         @
    BLE loop                                                                                           @
    CMP r2, r5            @compara o divisor original com o resto                                      @
    BMI loop              @caso o divisor original seja maior que o resto, continua o loop             @
    LDMFD sp!, {lr}                                                                                    @
    MOV pc, lr                                                                                         @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@   Definição de subrotina ShiftDivisor                                 @ 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ r4 = ShiftDivisor(r10, r11, r4)                                       @
@    Argumentos:                                                        @
@        r10: Número de casas do divisor                                @
@        r11: Número de casas do dividendo                              @
@        r4: Divisor                                                    @
@   Retornos:                                                           @
@       r4: Divisor shiftado                                            @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
ShiftDivisor:             @rotina para alinhar as casas do dividendo e do divisor para a primeira subtracao         @
    STMFD sp!, {lr}                                                                                                 @
    SUB r10, r10, r11     @coloca no registrador r10 a diferenca de casas em binario entre o divisor e dividendo    @
    LDR r11, =0x0         @registrador r11 guardara o numero de casas que jah foi shiftado                          @
    CMP r10, r11          @faz uma comparacao para descobrir se a diferenca de casas eh maior que zero              @
    MOVNE r4, r4, lsl r10   @ caso nao haja diferenca, nao eh necessario shiftar o divisor                          @
    LDMFD sp!, {lr}                                                                                                 @
    MOV pc, lr                                                                                                      @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@