;;;
; Clear all characters from the input buffer
;;;
proc InputBufferClear
    mov [_gr_input_buffer], 0       ; puts NULL at the first character in the buffer
    mov [_gr_input_char_count], 0   ; resets the character count
    ret
endp