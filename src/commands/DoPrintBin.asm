proc DoPrintBin
    fastcall ArrayListSize, [_lg_stack]
    cmp eax, 0
    je .empty_stack

    fastcall ArrayListPop, [_lg_stack]
    fastcall PrintBinary, rax

    fastcall ConsolePrintChar, 98 ; 'b' character
    fastcall ConsolePrintChar, 32 ; space character
    ret

    .empty_stack:
    fastcall ConsolePrint, _gr_message_empty_stack
    ret
endp
