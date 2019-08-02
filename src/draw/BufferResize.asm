;;;
; Resizes a buffer
; params:
;   buffer - The buffer to resize
;   width  - The width of the buffer
;   height - The height of the buffer
; 
; returns: (QWORD) A pointer to the new buffer
;;;
proc BufferResize, buffer:QWORD, width:DWORD, height:DWORD
    mov [buffer], rcx

    ; eax := width * height * 4
    xor rax, rax
    mov eax, edx
    mul r8d
    shl eax, 4

    invoke realloc, [buffer], eax
    cmp eax, 0
    je .error
    ret

    .error:
    invoke	MessageBox,NULL,_gr_str_error,NULL,MB_ICONERROR+MB_OK
    ret
endp