;;;
; Frees the memory asociated to this array list.
; 
; params:
;   list  - A pointer to the list
;;;
proc ArrayListFree, list: QWORD
    local list: QWORD
    mov [list], rcx
    mov rax, [rcx + 8]        ; list
    invoke free, rax
    invoke free, [list]
    ret
endp