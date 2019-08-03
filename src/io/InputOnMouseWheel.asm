proc InputOnMouseWheel, delta:WORD
    xor eax, eax
    mov ax, cx
    cwd
    mov cx, 120
    idiv cx
    cwde

    shl eax, 4

    fastcall AppLogOffsetIncrement, eax

    ret
endp