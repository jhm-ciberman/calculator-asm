;;;
; Removes the last item of the list and returns its value.
; The allocated space for the list will not be shrinked.
; If the list is empty the value 0 will be returned
;
; params:
;   list  - A pointer to the list
;
; returns: (QWORD) The last added value in the list
;;;
proc ArrayListPop, list:QWORD
    xor rdx, rdx
    mov edx, DWORD[rcx+4]
    cmp edx, 0
    je .empty

    ; size -= 1
    dec edx                 
    mov DWORD[rcx + 4], edx
    ; return array[size]
    mov rax, QWORD[rcx+8]
    mov rax, QWORD[rax+rdx*8]
    ret

    .empty:
    xor eax, eax
    ret
endp