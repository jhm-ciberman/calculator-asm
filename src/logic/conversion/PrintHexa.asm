;;;
; Prints _int as a hexadecimal number.
; User uses the '.h' command to print the stack's top as a hexadecimal number.
;;;
proc PrintHexa uses rax rcx rdx r14 , _int:QWORD ; _int saved in rcx
    local _array:QWORD, _rem:QWORD, _num:QWORD

    fastcall ArrayListCreate, 10    ; Creates aux array
    mov [_array], rax

    mov [_num], rcx
    ; i=0
    mov rcx, 0
    ; Const. 16
    mov r14w, 16

    .mainloop:
    cmp [_num],0
    je .print
    mov [_rem], 0                   ; Remainder
    ; rax = _num
    mov rax, [_num]
    ; _num = rax / 16
    ; _rem = rax % 16 
    cqo
    idiv r14w
    mov [_num], rax
    mov [_rem], rdx
    ; if (_rem < 10) then
    cmp [_rem], 10
    jg .greater
    ; (_rem < 10)
    add [_rem], 48
    fastcall ArrayListPush, [_array], [_rem]
    inc rcx
    
    ; (_rem > 10)
    .greater:
    add [_rem], 55
    fastcall ArrayListPush, [_array], [_rem] 
    inc rcx
    jmp .mainloop
    
    .print:
    fastcall ArrayListSize, [_array]
    cmp eax, 0
    jle .done
    fastcall ArrayListPop, [_array]
    fastcall PrintString, rax
    jmp .print

    .done:
    ret

endp

