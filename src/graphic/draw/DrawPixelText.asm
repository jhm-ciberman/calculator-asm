proc DrawPixelText, x:DWORD, y:DWORD, string:QWORD, colour:DWORD
    local i:DWORD, xstart: DWORD
    mov [x], ecx
    mov [xstart], ecx
    mov [y], edx
    mov [string], r8
    mov [colour], r9d
    mov [i], 0

    .while:
    ; calculate eax = string[i]
    mov rcx, [string]
    add ecx, [i]
    mov al, [rcx]

    ; while eax != 0 (while is not a NULL character)
    test al, al
    jz .finish

    cmp al, 10 ; if it's a LF character
    je .linefeed

    fastcall DrawPixelChar, [x], [y], al, [colour]

    .skipdraw:
    inc [i]
    add [x], 8
    jmp .while

    .linefeed:
    inc [i]
    mov eax, [xstart]
    mov [x], eax
    add [y], 16
    jmp .while

    .finish:
    ret
endp