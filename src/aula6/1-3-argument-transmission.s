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
@   Transmite os argumentos b, c e d para a pilha
@   e chama func2()
@   Coloca o retorno na posição indicada no endereço r4.
func1:
    STMFD sp!, {r1-r5, lr}
    ADR r5, arguments
    LDMIA r5, {r1-r3}
    STMFD sp!, {r1,r2,r3}
    BL func2
    STMFD r4, {r0}
    LDMFD sp!, {r1-r5, lr}
    MOV pc, lr

@ func2(sp, r4)
@   Carrega os argumentos b,c e d da pilha em registradores para
@   operation
func2:
    LDMFD sp!, {r1-r3}
    STMFD sp!, {lr}    
    BL operation
    LDMFD sp!, {lr}
    MOV pc, lr

@ operation(argument_addresses) = aa[0] x aa[1] + aa[2]
@   retorno em r0
operation:
    MUL r0, r1, r2
    ADD r0, r0, r3
    MOV pc, lr

end:
    MOV r7, r0            @ breakpoint before swi
    SWI 0x123456

arguments: .word 0x3, 0x4, 0x5

return_address: .word 0x4000