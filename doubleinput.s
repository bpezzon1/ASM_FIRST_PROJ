    .section .data
input:
    # null terminated double
    .asciz "%lf"
output:
    # print msg
    .asciz "The double is: %f\n"

    .section .bss
    # number of bytes to reserve for num
    .lcomm num, 8

    .section .text
    # define for linker
    .globl main
    .extern scanf
    .extern printf

main:
    # set new ptr
    pushq %rbp
    movq %rsp, %rbp

    # load input into %rcx, load adress of input into %rdx, call scanf
    leaq input(%rip), %rcx
    leaq num(%rip), %rdx
    call scanf

    # move input into register for floating point math and double input
    movsd num(%rip), %xmm0
    addsd %xmm0, %xmm0

    # move output into %rcx, move value into %xmm1 for printing, call printf
    leaq output(%rip), %rcx
    movaps %xmm0, %xmm1
    movq %xmm1, %rdx
    call printf

    # clean up, set rtn value to 0, free base ptr, rtn
    movl $0, %eax
    popq %rbp
    ret
