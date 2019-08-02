;;;
; Converts the given ascii string to lowercase. Warning: The original string is modified
;
; params:
;   string - The string to convert
;
; Returns: (QWORD) A pointer to the same string
;;;
proc StringToLower, string:QWORD
    xor rax, rax ; i = 0

    .mainloop:
    mov dl, BYTE [rax + rcx]
    cmp dl, 0
    je .done

    cmp dl, 65
    jl .endif
    cmp dl, 90
    jg .endif

    add dl, 32
    mov BYTE [rax + rcx], dl

    .endif:
    inc rax
    jmp .mainloop

    .done:
    mov rax, rcx
    ret
endp