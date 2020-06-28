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
    .globl main
main:
    LDR r1, input
    BL is_prime
    B end

@ r4 == 0 não é primo
@ r4 == 1 é primo
is_prime:
    STMFD sp!, {r2,r3,r5,lr}
    LDR r2, =0x1
    LDR r4, =0x1
is_prime_loop:
    ADD r2, r2, #1
    BL division
    CMP r5, #0
    LDREQ r4, =0x0
    CMP r2, r1, lsr #1
    BLT is_prime_loop
    LDMFD sp, {r2,r3,r5,lr}
    MOV pc, lr

end:
    MOV r10, r1
    SWI 0x0

input: .word 0x4