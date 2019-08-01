;;;
; Allocates memory for a string an returns a pointer to the new duplicated string
; You must free() the allocated memory when you don't use the string anymore
;
; param:
;   string - A pointer to the string to duplicate
;
; returns: (QWORD) A pointer to the new string
;;;
proc StringClone, string:QWORD
    local newstring:QWORD
    mov [string], rcx
    
    ; newstring := malloc(strlen(string) + 1)
    invoke strlen, rcx
    inc rax
    invoke malloc, rax
    mov [newstring], rax

    ; strcpy(newstring, string)
    invoke strcpy, rax, [string]

    ; return string;
    mov rax, [newstring]
    ret
endp