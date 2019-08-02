proc DoPrint

    fastcall ArrayListPop, [_lg_stack]
    fastcall PrintDecimal, rax

    ret
endp