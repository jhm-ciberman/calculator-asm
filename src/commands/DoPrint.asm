proc DoPrint
    fastcall ArrayListSize, [_lg_stack]
    cmp eax, 0
    je .empty_stack
    
    fastcall ArrayListPop, [_lg_stack]
    fastcall PrintDecimal, rax
    fastcall ConsolePrintChar, 32
    ret

    .empty_stack:
    fastcall ConsolePrint, _gr_message_empty_stack
    ret
endp