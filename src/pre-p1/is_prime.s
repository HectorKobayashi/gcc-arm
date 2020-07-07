@Esse código foi desenvolvido para a aula 3 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/pre-p1/is_prime is_prime.s division.s

@To run and debug:
@gdb is_prime
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl is_prime
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@   Call point da subrotina de is_prime                                 @ 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ r4, r2 = is_prime(r1)                                                     @
@   Argumentos:                                                         @
@       r1: input                                                       @
@                                                                       @
@   Retornos:                                                           @
@       r4: resultado
@       r2: menor número pelo qual é divisível                                                   @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ r4 == 0 não é primo
@ r4 == 1 é primo
is_prime:
    STMFD sp!, {r3,r5,lr}
    LDR r2, =0x1
    LDR r4, =0x1
is_prime_loop:
    ADD r2, r2, #1
    BL division
    CMP r5, #0
    LDREQ r4, =0x0
    BEQ end_is_prime_loop
    CMP r2, r1, lsr #1
    BLT is_prime_loop
end_is_prime_loop:
    LDMFD sp, {r3,r5,lr}
    MOV pc, lr
