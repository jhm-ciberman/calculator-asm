proc DoMultiply uses r14
        
    fastcall ArrayListPop, [_lg_stack]
    mov r14, rax

    fastcall ArrayListPop, [_lg_stack]
    imul r14
    
    fastcall ArrayListPush, [_lg_stack], rax

    ret
endp