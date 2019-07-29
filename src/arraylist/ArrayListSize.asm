;;;
; Returns the number of elements in the list
;
; params:
;   list  - A pointer to the list
;
; returns: (DWORD) The number of elements in the list
;;;
proc ArrayListSize, list:QWORD
    xor rax, rax
    mov eax, DWORD[rcx+4]
    ret
endp