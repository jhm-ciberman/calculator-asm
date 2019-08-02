;;;
; Add the given ascii character to the output buffer
;
; params:
;   char - The character to add to the output buffer
;;;
proc OutputBufferAddChar, char:BYTE
    ; buffer[char_count] = char;
    mov dx, [_gr_output_char_count]
    mov rax, _gr_output_buffer
    add ax, dx
    mov BYTE[rax], cl

    ; char_count += 1
    inc [_gr_output_char_count]
    inc rax

    ; buffer[char_count] = NULL;
    ; This ensures the string always terminates with NULL
    mov BYTE[rax], 0

    ret
endp