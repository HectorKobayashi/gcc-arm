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
    .globl main 
main:
    LDR r1, grayCode2Bit
    BL gray_code
    SWI 0x123456

gray_code:
    SUB sp, sp, #12
    STR r4, [sp]
    STR r5, [sp, #4]
    STR lr, [sp, #8]

    MOV r7, r1
    LDR r6, =0x1
    LDR r8, =0x4
    LDR r10, =0x4
    MOV r2, r8
preencherMaisSignificativos:
    MOV r1, r7
    BL getCoupleBitsOnIndex
    MOV r1, r0
    LDR r11, four
    ADD r2, r2, r11
    BL shiftTripleToIndex
    ADD r9, r9, r0
    LDR r11, five
    SUB r2, r2, r11
    CMP r2, r6
    BGE preencherMaisSignificativos
preencherMenosSignificativos:
    MOV r2, r8
    MOV r1, r7
    BL getCoupleBitsOnIndex
    MOV r1, r0
    MOV r2, r6
    BL shiftTripleToIndex
    ADD r9, r9, r0
    LDR r11, one
    ADD r6, r6, r11
    SUB r8, r8, r11
    CMP r6, r10
    BLE preencherMenosSignificativos
    LDR r0, grayMask
    ADD r0, r0, r9
fim:
    LDR r4, [sp]
    LDR r5, [sp, #4]
    LDR lr, [sp, #8]
    MOV pc, lr


grayCode2Bit: .word 0xB4
respostaEsperada: .word 0x4C897E
grayMask: .word 0x924
one: .word 0x1
four: .word 0x4
five: .word 0x5