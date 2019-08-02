;;;
; Prints _int as a hexadecimal number.
; User uses the '.h' command to print the stack's top as a hexadecimal number.
;;;
proc PrintHexa uses rax rcx rdx r14 , _int:QWORD ; _int saved in rcx
    local _array:QWORD, _rem:QWORD, _num:QWORD, _i:WORD
    mov [_num], rcx

    fastcall ArrayListCreate, 10    ; Creates aux array
    mov [_array], rax

    .mainloop:
    cmp [_num],0
    je .print

    ; _num = _num / 16
    ; _rem = _num % 16 
    mov rax, [_num]
    cqo
    mov r14, 16
    idiv r14
    mov [_num], rax
    mov [_rem], rdx

    ; if (_rem < 10) then
    cmp [_rem], 10
    jge .greater

    add [_rem], 48
    fastcall ArrayListPush, [_array], [_rem]
    jmp .mainloop

    .greater:
    add [_rem], 55
    fastcall ArrayListPush, [_array], [_rem] 
    jmp .mainloop
    
    .print:
    fastcall ArrayListSize, [_array]
    cmp eax, 0
    je .done
    fastcall ArrayListPop, [_array]
    invoke printf, _format_c, al
    jmp .print

    .done:
    ret

endp

