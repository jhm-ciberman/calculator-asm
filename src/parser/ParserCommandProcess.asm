;;;
; Process a new string instruction. 
; The available recognized string commands are: 
; "+", "-", "*", "/", "%", "or", "and", "xor", "not", "neg" (case insensitive)
; any other string will be parsed as an integer and pushed onto the stack.
;;;
proc ParserCommandProcess, string
    local i:DWORD, size:DWORD
    mov [string], rcx
    mov [i], 0

    fastcall ArrayListSize,[_lg_commands_list]
    mov [size], eax   

    .while: 
    mov eax, [i]
    cmp eax, [size]
    jge .not_found 

    fastcall ArrayListGet,[_lg_commands_list], [i]
    invoke strcmp, rax, [string]

    cmp rax, 0
    jne .not_equals

    fastcall ArrayListGet,[_lg_commands_handlers], [i]

    ; execute handler
    call rax
    jmp .done

    .not_equals:
    inc [i]
    jmp .while

    jmp .done

    .not_found:
    fastcall StringDecimalToInteger, [string]
    fastcall ArrayListPush, [_lg_stack], rax

    .done:
    ret
endp