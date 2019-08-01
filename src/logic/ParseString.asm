;                       ### Parses a String ###
;------------------------------------------------------------------------
; Used to parse Strings.
; Pseudocode: https://repl.it/repls/OutrageousHeftyPhases
;------------------------------------------------------------------------

proc ParseString uses rbx, _str:QWORD ; _str saved in rcx
    local _i:QWORD, _bufferi:QWORD

    mov [_str], rcx            ; The String
    mov [_i], 0                ;  Character index
    mov [_bufferi], 0          ; Buffer index

    ; r8b := str[0]
    mov rcx, [_str]
    mov r8b, byte [rcx]

    .main_loop:
    ; while (cc != 0)
    cmp r8b, 0
    jz .end_main_loop

    ; if (cc != 32)
    cmp r8b, 32
    je .is_space

    ; buff[buffi++] = cc;
    mov rdx, [_bufferi]
    mov byte[_lg_str_buffer + rdx], r8b
    inc [_bufferi]
    jmp .buffer_is_empty

    .is_space:
    ; else if (buffi != 0)
    mov rdx, [_bufferi]
    cmp rdx, 0
    je .buffer_is_empty

    ;  buff[buffi] = 0;
    mov byte[_lg_str_buffer + rdx], 0
    ; buffi = 0
    mov [_bufferi], 0

    fastcall StringToDecimal, _lg_str_buffer
    fastcall ArrayListPush, [_lg_stack], rax

    .buffer_is_empty:
    ; cc = str[++i];
    mov rdx, [_i]
    inc rdx
    mov rcx, [_str]
    mov r8b, byte [rcx + rdx]
    mov [_i], rdx

    jmp .main_loop

    .end_main_loop:

    ; if (buffi != 0)
    mov rdx, [_bufferi]
    cmp rdx, 0
    jz .done

    ; buff[buffi] = 0;
    mov byte[_lg_str_buffer + rdx], 0

    fastcall StringToDecimal, _lg_str_buffer
    fastcall ArrayListPush, [_lg_stack], rax

    .done:
    ret
endp