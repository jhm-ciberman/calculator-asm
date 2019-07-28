;;;
; Returns the last item from the list without removing it.
; It's the same as ArrayListGet(list, ArrayListSize(list) - 1)
;
; params:
;   list  - A pointer to the list
;
; returns: (QWORD) The value of the last item in the list. 
;;;
proc ArrayListGetLast, list:QWORD
    xor rdx, rdx
    mov edx, DWORD[rcx+4]
    dec edx
    mov rax, QWORD[rcx+8]
    mov rax, QWORD[rax+rdx*8]
    ret
endp