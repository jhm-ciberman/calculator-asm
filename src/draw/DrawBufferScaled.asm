;;;
; Draws the specified buffer on the current target buffer scaling it
; 
; params: 
;   buffer       - The memory address of the first pixel data of the sprite
;   bufferwidth  - The width of the line
;   bufferheight - The height of the line
;   x            - The destination x position
;   y            - The destination y position
;   scalex       - The width of each pixel
;   scaley       - The height of each pixel
;;;
proc DrawBufferScaled, buffer:QWORD, bufferwidth:DWORD, bufferheight:DWORD, x:DWORD, y:DWORD, scalex:DWORD, scaley:DWORD
    local i:DWORD, j:DWORD, xstart:DWORD
    mov [buffer], rcx
    mov [bufferwidth], edx
    mov [bufferheight], r8d
    mov [x], r9d
    mov [xstart], r9d
    
    ; for (i = 0; i < bufferheight; i++)
    mov [i], 0
    .for_i:
    mov eax, [i]
    cmp eax, [bufferheight]
    jnl .endfor_i

    mov r9d, [xstart]
    mov [x], r9d               ; x := xstart

    ; for (j = 0; j < bufferwidth; j++)
    mov [j], 0
    .for_j:
    mov eax, [j]
    cmp eax, [bufferwidth] 
    jnl .endfor_j

    mov rax, [buffer]
    fastcall DrawRectangle, [x], [y], [scalex], [scaley], QWORD [rax]

    ; buffer += 4;
    mov rax, [buffer]
    add rax, 4
    mov [buffer], rax

    mov eax, [scalex]
    add [x], eax

    inc [j] 
    jmp .for_j
    .endfor_j:

    mov eax, [scaley]
    add [y], eax

    inc [i] 
    jmp .for_i
    .endfor_i:

    ret
endp