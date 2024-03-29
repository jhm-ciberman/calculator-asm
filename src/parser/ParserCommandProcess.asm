;;;
; Process a new string instruction. 
; The available recognized string commands are: 
; "+", "-", "*", "/", "%", "or", "and", "xor", "not", "neg" (case insensitive)
; any other string will be parsed as an integer and pushed onto the stack.
;;;
proc ParserCommandProcess, string
    local i:DWORD, size:DWORD, lowercase_string:QWORD
    mov [string], rcx
    mov [i], 0

    fastcall StringClone, [string]
    mov [lowercase_string], rax
    fastcall StringToLower, [lowercase_string]

    fastcall ArrayListSize,[_lg_commands_list]
    mov [size], eax   

    .while: 
    mov eax, [i]
    cmp eax, [size]
    jge .not_found 

    fastcall ArrayListGet,[_lg_commands_list], [i]
    invoke strcmp, rax, [lowercase_string]

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
    mov rax, [lowercase_string]
    mov al, BYTE[rax]
    cmp al, '0'
    jl .is_not_number
    cmp al, '9'
    jg .is_not_number

    fastcall StringDecimalToInteger, [string]
    fastcall ArrayListPush, [_lg_stack], rax
    jmp .done
    
    .is_not_number:
    fastcall ConsolePrint, _gr_message_unknown
    fastcall ConsolePrint, [string]
    fastcall ConsolePrint, _gr_message_type_help

    .done:
    invoke free, [lowercase_string]
    ret
endp