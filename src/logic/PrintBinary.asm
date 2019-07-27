;              ### Prints _str as a binary number ###
;------------------------------------------------------------------------
; User uses the '.b' command to print the stack's top as a binary number.
;
;------------------------------------------------------------------------

proc PrintBinary uses rax rdx rcx, _str:QWORD ; _str saved in rcx

mov rax, -64        ; counter
mov rbx, $80000000  ; bitmask
xor rdx, rdx

.mainloop:
    test rcx, rbx ; Compares MSB with 1 
    jz .zero
    shl rcx, 1
    mov rdx, _lg_s1     ; Prints '1'
    jmp .eval

.zero:
    shl rcx, 1
    mov rdx, _lg_s0     ; Prints '0'

.eval:
    push rcx rax rbx
    fastcall PrintString, rdx
    pop rbx rax rcx
    add rax, 1
    jnz .mainloop

.done:
    ret
endp