@Esse código foi desenvolvido para a aula 3 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o absolute_value absolute_value.s

@To run and debug:
@arm-elf-gdb absolute_value
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:
    LDR r0, VALOR
    LDR r2, ZERO
    BL abs
    SWI 0x123456
abs:
    CMP r0, r2
    BLT invert
    MOV r1, r0
    B end
invert:
    SUB r1, r2, r0
end:
    MOV pc, lr

ZERO: .word 0x0
VALOR: .word 0x1