@Esse código foi desenvolvido para a aula 3 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o signed_multiplication signed_multiplication.s

@To run and debug:
@arm-elf-gdb signed_multiplication
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue


@In this code r0 is used as a 0 value register
@the r8 and r9 is used as aux in functions
@result will be in r5,r6
@the result is as [r6,r5] = 64 bits value
    .text
    .globl main
main: 
    LDR r1, I1 @r1 input 1
    LDR r2, I2 @r2 input 2
    LDR r0, Z
    MOV r8, r1
    BL abs
    MOV r3, r8 @r3 has the abs of r1 now
    MOV r8, r2
    BL abs
    MOV r4, r8 @r4 has the abs of r2 now
    UMULL r5,r6,r3,r4 @r5,r6 now has the abs value of the multiplication
    MOV r8, r1
    MOV r9, r2
    BL checksignals @check signals, r8 will be -1 if should be negative, 1 if should be positive
    CMP r8, r0
    BLT invertdouble @should invert the double stored in result r5,r6
    b end
abs:
    CMP r8, r0
    BLT invert
    BX lr
invert:
    SUB r8, r0, r8
    BX lr

checksignals:
    CMP r8, r0
    BLT firstnegative @the first is negative
    cmp r9, r0
    BLT negative @the first is positive, the second is negative, result is negative
    B positive @both are positive, result is positive
firstnegative:
    cmp r9, r0
    BLT positive @the first is negative, and second too, result is positive
    b negative @the first is negative, and second positive, result is negative
positive: 
    LDR r8, O @result is positive, returning 1 in r8
    BX lr
negative:
    LDR r8, MO @result is negative, returning -1 in r8
    BX lr
invertdouble:
    LDR r8, ALLONE
    LDR r9, O
    EOR r5, r5, r8
    EOR r6, r6, r8
    ADDS r5, r5, r9
    ADC r6, r6, r0
    B end
end:
    SWI 0x0

@Important values as zero, one, all one bits, minus one and inputs
Z: .word 0x0
O: .word 1
ALLONE: .word 0xFFFFFFFF
MO: .word -1
I1: .word 130
I2: .word 13

