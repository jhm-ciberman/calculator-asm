proc DoPrintStack
    local size:DWORD

    fastcall ArrayListSize, [_lg_stack]
    mov [size], eax

    .while:
    cmp [size], 0
    jle .endwhile

    dec [size]

    fastcall ArrayListGet, [_lg_stack], [size]
    fastcall PrintDecimal, rax

    jmp .while
    .endwhile:

    ret
endp