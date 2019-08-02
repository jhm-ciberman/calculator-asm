;;;
; Clear all characters from the output buffer
;;;
proc OutputBufferClear
    mov [_gr_output_buffer], 0       ; puts NULL at the first character in the buffer
    mov [_gr_output_char_count], 0   ; resets the character count
    ret
endp