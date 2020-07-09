@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula6/2-2-bubble-sort 2-2-bubble-sort.s

@To run and debug:
@gdb 2-2-bubble-sort
@na pasta bin/aula6
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .global main
 
main:
    LDR r0, =0x123
    LDR r1, =0x321
    STMFD sp!, {r0,r1}
    LDMFD sp!, {r0,r1}
    MOV r2, r3