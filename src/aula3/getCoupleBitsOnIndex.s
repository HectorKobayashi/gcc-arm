@Esse código foi desenvolvido para a aula 3 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -g -o gray_code gray_code.s getCoupleBitsOnIndex.s shiftTripleToIndex.s

@To run and debug:
@arm-elf-gdb gray_code
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl getCoupleBitsOnIndex

getCoupleBitsOnIndex:
    SUB sp, sp, #12
    STR r4, [sp]
    STR r5, [sp, #4]
    STR r2, [sp, #8]
    MOV r2, r2, lsl #1
    LDR r4, wordSize
    LDR r5, zero
    CMP r4, r2
    BEQ shift2left
    SUB r4, r4, r2
shift2left:
    MOV r0, r1, lsl r4
    LDR r4, wordSize
    LDR r5, two
    SUB r4, r4, r5
    MOV r0, r0, lsr r4
    LDR r4, [sp]
    LDR r5, [sp, #4]
    LDR r2, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr

wordSize: .word 0x20
two: .word 0x2
zero: .word 0x0