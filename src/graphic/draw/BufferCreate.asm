;;;
; Creates a new pixel colour buffer of the specified width and height
; You must free() the memory when you dont use the buffer anymore
;
; params:
;   width  - The width of the buffer
;   height - The height of the buffer
; 
; returns: (QWORD) A pointer to the created buffer
;;;
proc BufferCreate, width:DWORD, height:DWORD
    
    ; eax := width * height * 4
    mov eax, ecx
    mul edx
    shl eax, 4

    invoke malloc, eax
    cmp eax, 0
    je .error
    ret

    .error:
    invoke	MessageBox,NULL,_gr_str_error,NULL,MB_ICONERROR+MB_OK
    ret
endp