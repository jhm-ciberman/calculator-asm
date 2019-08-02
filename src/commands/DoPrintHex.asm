proc DoPrintHex
    fastcall ArrayListSize, [_lg_stack]
    cmp eax, 0
    je .empty_stack

    fastcall ConsolePrintChar, 36 ; '$' character
    fastcall ArrayListPop, [_lg_stack]
    fastcall PrintHexa, rax
    fastcall ConsolePrintChar, 32 ; space character
    ret

    .empty_stack:
    fastcall ConsolePrint, _gr_message_empty_stack
    ret
endp