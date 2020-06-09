@Esse código foi desenvolvido para a aula 5 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula5/5-sequential-parity-checker 5-sequential-parity-checker.s

@To run and debug:
@arm-elf-gdb 5-sequential-parity-checker
@na pasta bin/aula5
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:
    LDR r0, input
    BL parity_checker
    B end

@ r1 = parity_checker(r0);
@   r1 = 0x0000 se r1 tem número par de 1's
@   r1 = 0x0001 se r1 tem número ímpar de 1's
parity_checker:
    STMDB sp, {r2-r6}

    MOV r2, #1 @ constante 1
    MOV r3, #0 @ contador
    MOV r6, #0 @ inicializando para 0
loop:
    CMP r3, #32 @ iterar por toda palavra
    BGE end_parity_checker
    MOV r4, r2, lsl r3 @ r4 <- 1 deslocado para a esquerda r3 vezes
    AND r5, r4, r0  @ r5 = r4 AND r0. Terá só o bit que se quer ler na iteração.(r3-ésimo bit)
    ADD r6, r6, r5, lsr r3  @ r6 = r6 + r3-ésimo bit
    ADD r3, r3, r2
    B loop

end_parity_checker:
    AND r1, r6, r2  @ O bit menos significativo indica se é ímpar ou par

    LDMDB sp, {r2-r6}
    MOV pc, lr

end:
    MOV r7, r0  @ breakpoint before swi
    SWI 0x123456

@input: .word 0xABCD; @ 0xABCD = 1010 1011 1100 1101 : paridade par
input: .word 0xABCF; @ 0xABCF = 1010 1011 1100 1111 : paridade ímpar
