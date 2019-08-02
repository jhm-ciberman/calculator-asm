proc DoPrint

    fastcall ArrayListPop, [_lg_stack]
    fastcall PrintDecimal, rax
    fastcall ConsolePrintChar, 32

    ret
endp