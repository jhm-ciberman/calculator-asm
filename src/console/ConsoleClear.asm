;;;
; Clears all the console log
;;;
proc ConsoleClear
    local size:DWORD
    fastcall ArrayListSize, [_gr_log_input]
    mov [size], eax
    jmp .done
    .while:
    cmp [size], 0

    dec [size]

    fastcall ArrayListGet, [_gr_log_input], [size]
    invoke free, rax

    fastcall ArrayListGet, [_gr_log_output], [size]
    invoke free, rax

    
    jmp .while

    .done:

    fastcall ArrayListClear, [_gr_log_input]
    fastcall ArrayListClear, [_gr_log_output]
    ret
endp