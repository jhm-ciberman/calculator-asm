proc DrawPixelChar uses r14, x: DWORD, y:DWORD, char:BYTE, colour: DWORD
    local pbuff:QWORD, i:BYTE, j:BYTE, xstart: DWORD
    mov [x], ecx
    mov [y], edx
    mov [char], r8b
    mov [colour], r9d
    
    mov [xstart], ecx

    ; The font is 1 bit per pixel
    ; width is 8, height is 16 (4 bytes)
    ; pbuff = font[character << 4]
    

    xor rcx, rcx
    mov cl, r8b
    mov rax, 16
    mul rcx

    add rax, font
    mov [pbuff], rax

    ; while (i < 16)
    mov [i], 0
    .while_i:
    mov al, [i]
    cmp al, 16
    jnl .end_while_i

    mov r14, [pbuff]

    ;x := xstart
    mov ecx, [xstart]
    mov [x], ecx

    mov [j], 7
    .while_j:
    mov al, [j]
    cmp al, 0
    jl .endwhile_j

    mov r15, [r14]
    mov cl, al
    shr r15, cl
    test r15, 1
    jz .skip_1
    fastcall DrawPixel, [x], [y], [colour]
    .skip_1:

    inc [x]
    dec [j]
    jmp .while_j

    .endwhile_j:

    inc [y]
    inc [i]
    inc [pbuff]
    jmp .while_i

    .end_while_i:
    ret
endp