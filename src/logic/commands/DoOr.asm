proc DoOr uses r14
        
    fastcall ArrayListPop, [_lg_stack]
    mov r14, rax

    fastcall ArrayListPop, [_lg_stack]
    or r14, rax
    
    fastcall ArrayListPush, [_lg_stack], r14

    ret
endp