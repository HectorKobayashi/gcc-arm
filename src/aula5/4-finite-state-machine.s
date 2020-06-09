@Esse código foi desenvolvido para a aula 5 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula5/4-finite-state-machine 4-finite-state-machine.s

@To run and debug:
@gdb 4-finite-state-machine
@na pasta bin/aula5
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:
    LDR r8, sequence
    LDR r9, sequence_size
    LDR r1, input
    BL sequence_finder
    B end

@ r2 = sequence_finder(r8 = sequence, r9 = sequence_size, r1 = input)
sequence_finder:
    STMDB sp, {r3-r7}

    MOV r6, #1 @ constante 1
    MOV r3, #0 @ contador
    MVN r4, #0 @ initial_mask = 0xFFFFFFFF
    MOV r4, r4, lsr r9 @ zera os números à direita para a máscara
    MVN r4, r4, lsl r9 @ inverte a máscara para se capturar apenas os bits do tamanho da sequência
    MOV r2, #0 @ inicializando para 0
    SUB r7, r9, #33 @ - limite de iteração
    SUB r7, r3, r7  @ módulo de (- limite de iteração)
loop:
    CMP r3, r7 @ iterar por toda palavra
    BGE end_parity_checker

    AND r5, r4, r1, lsr r3  @ guarda em r5 os r9's bits a partir do r3-ésimo bit da entrada.
    CMP r5, r8  @ compara os bits filtrados de r5 com a sequência.
    ADDEQ r2, r2, r6, lsl r3    @ Se for igual, escreve 1 na r3-ésima posição da saída

    ADD r3, r3, r6
    B loop

end_parity_checker:

    LDMDB sp, {r3-r7}
    MOV pc, lr

end:
    MOV r7, r0  @ breakpoint before swi
    SWI 0x123456

sequence: .word 0xB @ b1011
sequence_size: .word 0x4
input: .word 0xB0B0B0B0 @ deveria identificar 4 sequências de B