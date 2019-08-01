proc DoPrintStack
    .while:
    fastcall ArrayListSize, [_lg_stack]
    cmp eax, 0
    jle .endwhile

    fastcall ArrayListPop, [_lg_stack]
    invoke printf, _format_d, rax
    jmp .while
    .endwhile:

    ret
endp