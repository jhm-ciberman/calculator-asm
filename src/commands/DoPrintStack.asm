proc DoPrintStack
    local size:DWORD

    fastcall ArrayListSize, [_lg_stack]
    mov [size], eax
    cmp eax, 0
    je .empty_stack

    .while:
    cmp [size], 0
    jle .endwhile

    dec [size]

    fastcall ArrayListGet, [_lg_stack], [size]
    fastcall PrintDecimal, rax
    fastcall ConsolePrintChar, 10

    jmp .while
    .endwhile:
    ret

    .empty_stack:
    fastcall ConsolePrint, _gr_message_empty_stack
    ret
endp