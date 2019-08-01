proc DoNot
        
    fastcall ArrayListPop, [_lg_stack]
    not rax
    
    fastcall ArrayListPush, [_lg_stack], rax

    ret
endp