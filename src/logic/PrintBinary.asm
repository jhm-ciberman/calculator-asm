;              ### Prints _lg_str as a binary number ###
;------------------------------------------------------------------------
; User uses the '.b' command to print the stack's top as a binary number.
;
;------------------------------------------------------------------------

proc PrintBinary uses rax rdx rcx, _lg_str:QWORD ; _lg_str saved in rcx

mov rax, -64 

mainloop:
    test rcx, $8000000 ; Compares MSB with 1 
    jz zero
    shl rcx, 1
    mov rdx, _lg_s1     ; Prints '1'
    jmp eval

zero:
    shl rcx, 1
    mov rdx, _lg_s0     ; Prints '0'

eval:
    push rcx rax
    push rdx
    invoke printf
    add esp, 4
    pop rax rcx
    add rax, 1
    jnz mainloop

done:
    ret
endp