;;;
; Count the number of ocurrences of the given character in the string 
;
; params:
;   string - The string
;   char   - The character to count the ocurrences
;
; returns: (QWORD) The number of ocurrences
;;;
proc StringCountChar, string:QWORD, char:BYTE
    xor rax, rax ; number of ocurrences

    .while:
    mov r8b, BYTE[rcx]
    cmp r8b, 0
    je .done

    inc rcx

    cmp r8b, dl
    jne .while

    inc rax

    jmp .while

    .done:
    ret
endp