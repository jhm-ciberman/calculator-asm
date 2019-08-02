;;;
; Prints _int as a binary number.
; User uses the '.b' command to print the stack's top as a binary number.
;;;
proc PrintBinary uses rax rdx rcx, _int:QWORD ; _int saved in rcx

mov rax, -64        ; counter
mov rbx, 1          ; bitmask
shl rbx, 63
xor rdx, rdx

.mainloop:
    test rcx, rbx ; Compares MSB with 1 
    jz .zero

    shl rcx, 1
    mov rdx, 49     ; Prints '1' = ascii 49
    jmp .eval

.zero:
    shl rcx, 1
    mov rdx, 48     ; Prints '0'  = ascii 48

.eval:
    push rcx rax rbx
    fastcall ConsolePrintChar, dl
    pop rbx rax rcx
    add rax, 1
    jnz .mainloop

.done:
    ret
endp