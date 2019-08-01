proc DoNeg
        
    fastcall ArrayListPop, [_lg_stack]
    neg rax
    
    fastcall ArrayListPush, [_lg_stack], rax

    ret
endp