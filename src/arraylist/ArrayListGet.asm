;;;
; Returns the item at the specified position. Never pass an item that is 
; greater or equal than the list size or the program could crash.
;
; params:
;   list  - A pointer to the list
;   index - The zero based index of the item to retrieve from the list
;
; returns: (QWORD) The value at the specified index. 
;;;
proc ArrayListGet, list:QWORD, index:DWORD
    mov rax, QWORD[rcx+8]
    mov rax, QWORD[rax+rdx*8]
    ret
endp