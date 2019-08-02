proc DoPrintHex
    fastcall ConsolePrintChar, 36 ; '$' character

    fastcall ArrayListPop, [_lg_stack]
    fastcall PrintHexa, rax

    fastcall ConsolePrintChar, 32 ; space character

    ret
endp