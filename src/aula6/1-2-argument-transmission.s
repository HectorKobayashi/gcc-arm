@Esse código foi desenvolvido para a aula 6 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula6/1-2-argument-transmission 1-2-argument-transmission.s

@To run and debug:
@gdb 1-2-argument-transmission
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
    ADR r1, a
    ADR r2, b
    ADR r3, c
    BL func1
    B end
    
@ func1(r1, r2, r3)
@   r1, r2 e r3 devem ter o endereço para o valor desejado
@   valor de retorno em r0
func1:
    LDR r1, r1
    LDR r2, r2
    LDR r3, r3
    MUL r0, r1, r2
    ADD r0, r0, r3
    MOV pc, lr

end:
    MOV r7, r0            @ breakpoint before swi
    SWI 0x123456

a: .word 0x3
b: .word 0x4
c: .word 0x5

return_address: .word 0x4000