@Esse código foi desenvolvido para a aula 3 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o division division.s

@To run and debug:
@arm-elf-gdb division
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:
    LDR r1, dividendo      @dividendo original 
    LDR r2, divisor        @divisor original
    LDR r3, zero           @quociente
    LDR r4, divisor        @divisor usado nas subtracoes, tambem sera referido como subtrator
    LDR r5, dividendo      @resto
    LDR r7, one            @valor um
    MOV r5, r1
    CMP r1, r2                @compara dividendo com divisor 
    BMI quocienteZero         @faz o desvio se o dividendo for menor que o divisor, o quociente eh zero e o resto eh o dividendo 
    BL findSizeOfDividendo
    BL findSizeOfDivisor
    BL divisao    
quocienteZero:
    SWI 0x1             

findSizeOfDividendo:      @rotina para achar o numero de casas em binario do dividendo
    SUB sp, sp, #-4
    STR lr, [sp]
    LDR r9, dividendo 
    LDR r10, zero         @registrador r10 vai guardar o numero de casas
loopFMS:
    CMP r9, r7            @compara o dividendo com o valor um
    MOV r9, r9, lsr #1    @shifta o dividendo um bit para direita
    ADD r10, r10, r7      @adiciona uma casa binaria
    BNE loopFMS           @repete o loop caso o dividendo ainda nao seja igual a um
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

findSizeOfDivisor:        @rotina para achar o numero de casas em binario do dividendo
    SUB sp, sp, #-4
    STR lr, [sp]
    LDR r9, divisor
    LDR r11, zero         @registrador r11 vai guardar o numero de casas
loopFMD:
    CMP r9, r7            @compara o dividendo com o valor um
    MOV r9, r9, lsr #1    @shifta o dividendo um bit para direita
    ADD r11, r11, r7      @adiciona uma casa binaria
    BNE loopFMD           @repete o loop caso o dividendo ainda nao seja igual a um
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

divisao:                  @executa o algorismo da divisao
    SUB sp, sp, #-4
    STR lr, [sp]
    LDR r9, zero         
    BL ShiftDivisor     
loop:
    MOV r3, r3, lsl #1    @move o quociente um bit para a esquerda
    CMP r5, r4            @compara o divisor shiftado com o resto
    BMI pula              @pula o loop caso o divisor shiftado seja maior que o resto
    SUB r5, r5, r4        @subtrai o dividendo/resto pelo divisor shiftado
    ADD r3, r3, r7        @adiciona um ao quociente
pula:
    MOV r4, r4, lsr #1    @shifta o divisor um bit para a direita
    CMP r2, r4            @compara o divisor original com o divisor shiftado
    BLE loop              @caso o divisor original seja menor que o shiftado ainda continua o loop
    CMP r2, r5            @compara o divisor original com o resto
    BMI loop              @caso o divisor original seja maior que o resto, continua o loop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr 

ShiftDivisor:             @rotina para alinhar as casas do dividendo e do divisor para a primeira subtracao
    SUB sp, sp, #-4
    STR lr, [sp]
    SUB r10, r10, r11     @coloca no registrador r10 a diferenca de casas em binario entre o divisor e dividendo 
    LDR r11, zero         @registrador r11 guardara o numero de casas que jah foi shiftado
    CMP r10, r11          @faz uma comparacao para descobrir se a diferenca de casas eh maior que zero
    BEQ endLoop           @caso nao haja diferenca, nao eh necessario shiftar o diviso, entao pula o loop
    MOV r4, r4, lsl r10   @move o divisor varios bits para a esquerda
endLoop:    
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr



dividendo: .word 9285492
divisor: .word 1000
quociente: .word 0x0
zero: .word 0x0
one: .word 0x1
wordSize: .word 0x1E
