camlMatrix_math__mult_sv_1038:
    subq    $56, %rsp
.L106:
    movq    %rax, 24(%rsp)
    movq    %rbx, 8(%rsp)
    movq    %rdi, %rax
    movq    %rax, 16(%rsp)
    movq    -8(%rbx), %rdi
    shrq    $9, %rdi
    orq     $1, %rdi
    movq    %rdi, 0(%rsp)
    movq    24(%rax), %rax
    movq    (%rax), %rsi
    movq    caml_make_vect@GOTPCREL(%rip), %rax                 // Create new vector
    call    caml_c_call@PL
.L107:
    movq    caml_young_ptr@GOTPCREL(%rip), %r11                 // Check heap for allocation
    movq    (%r11), %r15
    movq    %rax, %rbx
    movq    $1, %r12
    movq    0(%rsp), %rax
    addq    $-2, %rax
    cmpq    %rax, %r12
    jg      .L100
    movq    %rax, 32(%rsp)
    movq    %r12, 40(%rsp)
    movq    %rbx, 0(%rsp)
.L101:
    movq    8(%rsp), %rdi
    movzbq  -8(%rdi), %rax
    cmpq    $254, %rax
    je      .L105
    movq    -4(%rdi, %r12, 4), %rbx
    jmp     .L104
.L105:
.L108:  
    subq    $16, %r15
    movq    caml_young_limit@GOTPCREL(%rip), %rax               // Check heap for allocation
    cmpq    (%rax), %r15
    jb      .L109
    leaq    8(%r15), %rbx
    movq    $1277, -8(%rbx)
    movsd   -4(%rdi, %r12, 4), %xmm0
    movsd   %xmm0, (%rbx)
.L104:
    movq    16(%rsp), %rax
    movq    24(%rax), %rax
    movq    24(%rax), %rdi
    movq    24(%rsp), %rax
    call    caml_apply2@PLT                                     // Currying application (optimization)
.L111:
    movq    0(%rsp), %rbx
    movzbq  -8(%rbx), %rdi
    cmpq    $254, %rdi
    je      .L103
    movq    40(%rsp), %r12
    leaq    -4(%rbx, %r12, 4), %rdi
    movq    %rax, %rsi
    call    caml_modify@PLT                                     // Update ref
    jmp     .L102
.L103:
    movsd   (%rax), %xmm0
    movq    40(%rsp), %r12
    movsd   %xmm0, -4(%rbx, %r12, 4)
.L102:
    movq    %r12, %rax
    addq    $2, %r12
    movq    %r12, 40(%rsp)
    movq    32(%rsp), %rdi
    cmpq    %rdi, %rax
    jne     .L101
.L100:
    movq    %rbx, %rax
    addq    $56, %rsp
    ret
.L109:  
    call    caml_call_gc@PLT                                    // Garbage collection
.L110:  
    jmp     .L108
