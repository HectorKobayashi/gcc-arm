@Esse código foi desenvolvido para a aula 4 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula4/5-fibonacci 5-fibonacci.s

@To run and debug:
@arm-elf-gdb 5-fibonacci
@na pasta bin/aula4
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue
@at the end of the execution, print the content on these positions:
@(gdb) x/w 0x4000
@(gdb) x/w 0x4004
@(gdb) x/w 0x4008
@(gdb) x/b 0x400B

    .text
    .globl main
main:
    LDR r1, result          @   r1 = result address
    LDR r4, last_address    @   r4 = last_address
    LDR r2, =0x0            @   r2 = f(0)
    LDR r3, =0x1            @   r3 = f(1)
    STRB r2, [r1], #1       @   Store r2 in address r1 and increment r1 in 1 byte
    STRB r3, [r1], #1       @   Store r3 in address r1 and increment r1 in 1 byte

fib_loop:
    ADD r0, r2, r3          @   r0 <- f(n-2) + f(n-1) = f(n)
    STRB r0, [r1], #1       @   Store r0 in address r1 and increment r1 in 1 byte
    CMP r1, r4              @   Check if the actual address is the last_address
    MOV r2, r3              @   f(n-2) <- f(n-1)
    MOV r3, r0              @   f(n-1) <- f(n)
    BLE fib_loop            @   Is lower or equal, loops

end:
    MOV r7, r0  @ breakpoint before swi
    SWI 0x123456

result: .word 0x4000
last_address: .word 0x400B