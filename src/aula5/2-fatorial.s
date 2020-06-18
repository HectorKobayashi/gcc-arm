@Esse código foi desenvolvido para a aula 5 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula5/2-fatorial 2-fatorial.s

@To run and debug:
@arm-elf-gdb 2-fatorial
@na pasta bin/aula5
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .global main
 
main:
    ldr r0, =0x0
factorial:        
    MOV r6,#0xA 
    MOV r4,r6
loop: 
    SUBS r4, r4, #1    @ decrement next multiplier
    MULNE r6, r4, r6   @ perform multiply
    BNE loop           @ go again if not complete
end:
    MOV r7, r0  @ breakpoint before swi
    SWI 0x123456
    