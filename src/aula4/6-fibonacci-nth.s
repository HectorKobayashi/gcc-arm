@Esse código foi desenvolvido para a aula 4 do curso PCS3732- Laboratório de Processadores - 2020
@Feito pelos alunos:
@Felipe Kenzo Shiraishi - 10262700
@Hector Kobayashi Yassuda - 10333289
@Vitor Hugo Perles - 9285492

@Para compilar
@arm-elf-gcc -Wall -g -o ../bin/aula4/6-fibonacci-nth 6-fibonacci-nth.s

@To run and debug:
@arm-elf-gdb 6-fibonacci-nth
@na pasta bin/aula4
@(gdb) target sim
@(gdb) load
@(gdb) break main
@(gdb) run
@(gdb) continue

    .text
    .globl main
main:
    LDR r1, n               @   r1 = n
    LDR r2, =0x0            @   r2 = index = 0
    LDR r3, =0x0            @   r3 = f(0)
    LDR r4, =0x1            @   r4 = f(1)
    LDR r5, =0x1            @   r5 = 1 constant
    CMP r1, r2              @   Checks if n is 0
    BEQ zero_condition      @   Branch to n = 0
    ADD r2, r2, r5          @   increments index
    CMP r1, r2              @   Checks if n is 1
    BEQ one_condition       @   Branch to n = 1

fib_loop:
    ADD r2, r2, r5          @   r2 <- r2 + 1 = n <- n + 1
    ADD r0, r3, r4          @   r0 <- f(n-2) + f(n-1)
    CMP r2, r1              @   Checks if index = n
    BEQ end                 @   If is equal, end
    MOV r3, r4              @   f(n-2) <- f(n-1)
    MOV r4, r0              @   f(n-1) <- f(n)
    B fib_loop              @   loops

zero_condition:
    MOV r0, r3              @   r0 <- 0
    B end

one_condition:
    MOV r0, r4              @   r1 <- 1

end:
    MOV r7, r0              @ breakpoint before swi
    SWI 0x123456

n: .word 0x1