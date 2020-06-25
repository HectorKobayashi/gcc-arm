@Esse código foi desenvolvido para a aula 6 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula6/1-3-argument-transmission 1-3-argument-transmission.s

@To run and debug:
@gdb 1-3-argument-transmission
@na pasta bin/aula6
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .global main
 
main:
    LDR r4, return_address
    BL func1
    B end
    
@ func1(r4)
@   func 1 retorna o resultado em 4000
@   Chama func2 para calcular
func1:
    STMFD sp!, {lr}
    ADR r5, arguments
    LDMIA r5, {r1-r3}
    BL func2
    ADD r0, r0, r3
    STMFD r4, {r0}
    LDMFD sp!, {lr}
    MOV pc, lr

@ func2(sp, r4)
@   Retorna o resultado de b * c
func2:
    MUL r0, r1, r2
    MOV pc, lr

end:
    MOV r7, r0            @ breakpoint before swi
    SWI 0x123456

arguments: .word 0x3, 0x4, 0x5

return_address: .word 0x4000