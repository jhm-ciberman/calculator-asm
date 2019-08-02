proc DoPrint

    fastcall ArrayListPop, [_lg_stack]
    invoke printf, _format_d, rax

    ret
endp