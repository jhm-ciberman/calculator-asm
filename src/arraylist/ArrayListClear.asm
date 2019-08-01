;;;
; Clears the content of the list. The allocated memory is not released.
;
; params:
;   list  - A pointer to the list
;;;
proc ArrayListClear, list:QWORD
    mov DWORD[rcx+4], 0
    ret
endp