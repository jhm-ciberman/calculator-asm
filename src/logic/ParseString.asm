;                       ### Parses a String ###
;------------------------------------------------------------------------
; Used to parse Strings.
; Pseudocode: https://repl.it/repls/OutrageousHeftyPhases
;------------------------------------------------------------------------

proc ParseString uses rbx, _str:QWORD ; _str saved in rcx
    local _i:QWORD

    mov [_str], rcx            ; The String
    mov [_i], 0                ;  Character index

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

    fastcall BufferAdd, r8b

    jmp .buffer_is_empty

    .is_space:
    fastcall BufferFinish

    .buffer_is_empty:
    ; cc = str[++i];
    mov rdx, [_i]
    inc rdx
    mov rcx, [_str]
    mov r8b, byte [rcx + rdx]
    mov [_i], rdx

    jmp .main_loop

    .end_main_loop:

    fastcall BufferFinish

    .done:
    ret
endp