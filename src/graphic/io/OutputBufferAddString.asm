;;;
; Add the given string to the output buffer
;
; params:
;   string - The string to add to the output buffer
;;;
proc OutputBufferAddString, string:QWORD
    mov [string], rcx
    mov rax, _gr_output_buffer
    add ax, [_gr_output_char_count]
    invoke strcpy, rax, [string]

    invoke strlen, rax
    add ax, [_gr_output_char_count]
    mov [_gr_output_char_count], ax
    
    ret
endp