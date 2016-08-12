camlMatrix_math__mult_sv_1045:
    subq    $8, %rsp
.L164:
    movq    %rax, %rsi
.L165:  
    subq    $40, %r15
    movq    caml_young_limit@GOTPCREL(%rip), %rax               // Check heap for allocation
    cmpq    (%rax), %r15
    jb      .L166
    leaq    8(%r15), %rax
    movq    $4343, -8(%rax)
    movq    camlMatrix_math__fun_1204@GOTPCREL(%rip), %rdx      // Auxillary recursive function (see below)
    movq    %rdx, (%rax)
    movq    $3, 8(%rax)
    movq    24(%rdi), %rdi
    movq    %rdi, 16(%rax)
    movq    %rsi, 24(%rax)
    call    camlList__rev_map_1054@PLT                          // List's rev_map function (see below)
.L168:
    movq    $1, %rbx
    addq    $8, %rsp
    jmp     camlList__rev_append_1222@PLT                       // List's rev_append function (see below)
.L166:  
    call    caml_call_gc@PLT                                    // Garbage collection
.L167:  
    jmp     .L165



camlMatrix_math__fun_1204:
.L110:
    movq    %rax, %rsi
    movq    16(%rbx), %rax
    movq    24(%rax), %rdi
    movq    24(%rbx), %rax
    movq    %rsi, %rbx
    jmp     caml_apply2@PLT                                     // Currying application (optimization)



camlList__rev_map_1054:
    subq    $8, %rsp
.L483:
    movq    %rax, %rsi
.L484:
    subq    $40, %r15
    movq    caml_young_limit@GOTPCREL(%rip), %rax               // Check heap for allocation
    cmpq    (%rax), %r15
    jb      .L485
    leaq    8(%r15), %rdi
    movq    $4343, -8(%rdi)
    movq    caml_curry2@GOTPCREL(%rip), %rax                    // Currying application (optimization)
    movq    %rax, (%rdi)
    movq    $5, 8(%rdi)
    movq    camlList__rmap_f_1251@GOTPCREL(%rip), %rax          // Auxillary function call
    movq    %rax, 16(%rdi)
    movq    %rsi, 24(%rdi)
    movq    $1, %rax
    addq    $8, %rsp
    jmp     camlList__rmap_f_1251@PLT                           // Auxillary function call
.L485:
    call    caml_call_gc@PLT                                    // Garbage collection
.L486:
    jmp     .L484



camlList__rmap_f_1251:
    subq    $24, %rsp
.L104:
    cmpq    $1, %rbx
    je      .L103                                               // First time we have even broken a loop!
    movq    %rdi, 16(%rsp)
    movq    %rbx, 8(%rsp)
    movq    %rax, (%rsp)
    movq    24(%rdi), %rdi
    movq    (%rbx), %rax
    movq    (%rdi), %rsi
    movq    %rdi, %rbx
    call    *%rsi
.L105:
    movq    %rax, %rbx
.L106:
    subq    $24, %r15
    movq    caml_young_limit@GOTPCREL(%rip), %rax               // Check heap for allocation 
    cmpq    (%rax), %r15
    jb      .L107
    leaq    8(%r15), %rax
    movq    $2048, -8(%rax)
    movq    %rbx, (%rax)
    movq    (%rsp), %rbx
    movq    %rbx, 8(%rax)
    movq    8(%rsp), %rbx
    movq    8(%rbx), %rbx
    movq    16(%rsp), %rdi
    jmp     .L104
.L103:
    addq    $24, %rsp
    ret
.L107:
    call    caml_call_gc@PLT                                    // Garbage collection
.L108:
    jmp     .L106



camlList__rev_append_1222:
    subq    $8, %rsp
.L460:
    movq    %rax, %rdi
    cmpq    $1, %rdi
    je      .L459
.L461:
    subq    $24, %r15
    movq    caml_young_limit@GOTPCREL(%rip), %rax               // Check heap for allocation
    cmpq    (%rax), %r15
    jb      .L462
    leaq    8(%r15), %rsi
    movq    $2048, -8(%rsi)
    movq    (%rdi), %rax
    movq    %rax, (%rsi)
    movq    %rbx, 8(%rsi)
    movq    8(%rdi), %rax
    movq    %rsi, %rbx
    jmp     .L460
.L459:
    movq    %rbx, %rax
    addq    $8, %rsp
    ret
.L462:
    call    caml_call_gc@PLT                                    // Garbage collection
.L463:
    jmp     .L461
