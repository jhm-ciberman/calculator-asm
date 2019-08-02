proc DoPrintHex

    fastcall ArrayListPop, [_lg_stack]
    fastcall PrintHexa, rax

    ret
endp