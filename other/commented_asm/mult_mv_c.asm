mult_mv:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $64, %rsp
    movq    %rdi, -40(%rbp)
    movq    %rsi, -48(%rbp)
    movl    %edx, -52(%rbp)
    movl    %ecx, -56(%rbp)
    movl    -56(%rbp), %eax
    cltq
    salq    $3, %rax
    movq    %rax, %rdi
    call    malloc                              // Allocate memory for temporary product
    movq    %rax, -24(%rbp)
    movl    -56(%rbp), %eax
    cltq
    salq    $3, %rax
    movq    %rax, %rdi
    call    malloc                              // Allocate memory for result
    movq    %rax, -32(%rbp)
    movl    $0, -4(%rbp)
    jmp     .L2
.L5:                                            // L5 and the latter part of L3 
    movl    $0, %eax                            // form the outer loop
    movq    %rax, -16(%rbp)
    movl    -4(%rbp), %eax
    cltq
    leaq    0(,%rax,8), %rdx
    movq    -40(%rbp), %rax
    addq    %rdx, %rax
    movq    (%rax), %rax
    movq    %rax, -24(%rbp)
    movl    $0, -8(%rbp)
    jmp     .L3
.L4:                                            // L4 and the first three instructions
    movl    -8(%rbp), %eax                      // of L3 for the inner loop
    cltq
    leaq    0(,%rax,8), %rdx
    movq    -24(%rbp), %rax
    addq    %rdx, %rax
    movsd   (%rax), %xmm1
    movl    -8(%rbp), %eax
    cltq
    leaq    0(,%rax,8), %rdx
    movq    -48(%rbp), %rax
    addq    %rdx, %rax
    movsd   (%rax), %xmm0
    mulsd   %xmm1, %xmm0
    movsd   -16(%rbp), %xmm1
    addsd   %xmm1, %xmm0
    movsd   %xmm0, -16(%rbp)
    addl    $1, -8(%rbp)
.L3:
    movl    -8(%rbp), %eax
    cmpl    -52(%rbp), %eax
    jl      .L4                                 // Inner loop conditional
    movl    -4(%rbp), %eax
    cltq
    leaq    0(,%rax,8), %rdx
    movq    -32(%rbp), %rax
    addq    %rax, %rdx
    movq    -16(%rbp), %rax
    movq    %rax, (%rdx)
    addl    $1, -4(%rbp)
.L2:
    movl    -4(%rbp), %eax
    cmpl    -56(%rbp), %eax
    jl      .L5                                 // Outer loop conditional
    movq    -24(%rbp), %rax 
    movq    %rax, %rdi
    call    free                                // Release temporary memory for temporary product
    movq    -32(%rbp), %rax
    leave
    ret
