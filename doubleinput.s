.section .data
input:
    # null terminated double
    .asciz "%lf"

output:
   # print msg
    .asciz "The double is: %f\n"

.section .bss
.lcomm num, 8 # specify 8 bytes for a double

.section .text # define for linker
.globl main
.extern scanf
.extern printf

main:
    # set new ptr
    pushq %rbp

    # load input into %rdi, load adress of input into %rsi, call scanf
    leaq input(%rip), %rdi
    leaq num(%rip), %rsi
    call scanf

    # move input into register for floating point math and double input
    movsd num(%rip), %xmm0
    addsd %xmm0, %xmm0

    # move output into %rdi, call printf
    leaq output(%rip), %rdi
    call printf

    # clean up, set rtn value to 0, free base ptr, return
    movl $0, %eax
    popq %rbp
    ret
