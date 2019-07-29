;                       ### Parses a String ###
;------------------------------------------------------------------------
; Used to parse Strings.
;
;------------------------------------------------------------------------

proc ParseString uses rbx, _str:QWORD ; _str saved in rcx
    local _cc:QWORD, _ci:QWORD, _bi:QWORD

mov [_str], rcx            ; The String   
xor r8,r8                  ; Current character
mov [_cc], r8
xor rbx, rbx               ; Character Index
mov [_ci], rbx
xor r9, r9                 ; Buffer Index
mov [_bi], r9
mov r10, _lg_str           ; Buffer


jmp .skipblank

.mainloop:
    mov [_cc], r8
    mov [_ci], rbx
    mov [_bi], r9
    mov rax, 135
    invoke  printf, _format_d, rax
    mov r8, [_cc]
    mov rbx, [_ci]
    mov r9, [_bi]
    mov [_str], rcx
    ; r8b := str[rbx]
    mov rcx, [_str]
    mov r8b, byte [rcx + rbx]   ; Gets a character from the string
    cmp r8b, 32
    je .fullstring
    cmp r8b, 0
    jz .done
    mov byte [_lg_str + r9], r8b
    inc r9
    inc rbx
    jmp .mainloop

.fullstring:
    mov byte [_lg_str + r9], 0
    inc r9
    inc rbx
    mov [_cc], r8
    mov [_ci], rbx
    mov [_bi], r9
    ;fastcall StringToDecimal, _lg_str

    

    ;fastcall ArrayListPush, [_lg_str],rax
    mov r8, [_cc]
    mov rbx, [_ci]
    mov r9, [_bi]
    mov [_str], rcx

.skipblank:
    mov rcx, [_str]
    mov r8b, byte [rcx + rbx]
    cmp r8b, 32
    je .skipblank
    cmp r8b, 0
    je .done
    jmp .mainloop

.addone:
    inc rbx
    jmp .skipblank

.done:
    
    ret
endp