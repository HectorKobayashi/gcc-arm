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
    .globl shiftTripleToIndex
shiftTripleToIndex:
    SUB sp, sp, #12
    STR r4, [sp]
    STR r5, [sp, #4]
    STR r2, [sp, #8]
    LDR r4, three
    SUB r2, r2, #1
    MUL r5, r2, r4
    MOV r0, r1, lsl r5
    LDR r4, [sp]
    LDR r5, [sp, #4]
    LDR r2, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr

three: .word 0x3