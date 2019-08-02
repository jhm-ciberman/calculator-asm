proc DoRemainder uses r14
    ; RAX / R14 --> Stack[N-1]/Stack[N]

    fastcall ArrayListPop, [_lg_stack]
    mov r14, rax

    fastcall ArrayListPop, [_lg_stack]
    idiv r14

    fastcall ArrayListPush, [_lg_stack], rdx

    ret
endp