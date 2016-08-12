mult_sv:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $48, %rsp
    movsd   %xmm0, -24(%rbp)
    movq    %rdi, -32(%rbp)
    movl    %esi, -36(%rbp)
    movl    -36(%rbp), %eax
    cltq
    salq    $3, %rax
    movq    %rax, %rdi
    call    malloc                              // Allocate result memory
    movq    %rax, -16(%rbp)
    movl    $0, -4(%rbp)
    jmp    .L2
.L3:                                            // Outer loop
    movl    -4(%rbp), %eax
    cltq
    leaq    0(,%rax,8), %rdx
    movq    -16(%rbp), %rax
    addq    %rdx, %rax
    movl    -4(%rbp), %edx
    movslq  %edx, %rdx
    leaq    0(,%rdx,8), %rcx
    movq    -32(%rbp), %rdx
    addq    %rcx, %rdx
    movsd   (%rdx), %xmm0
    mulsd   -24(%rbp), %xmm0
    movsd   %xmm0, (%rax)
    addl    $1, -4(%rbp)
.L2:
    movl    -4(%rbp), %eax
    cmpl    -36(%rbp), %eax
    jl      .L3                                 // Outer loop conditional
    movq    -16(%rbp), %rax
    leave
    ret
