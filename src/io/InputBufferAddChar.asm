;;;
; Adds a character to the input buffer
;
; params
;   char - The character to add
;;;
proc InputBufferAddChar, char:BYTE
    ; if (char_count = 254) then return
    mov dl, [_gr_input_char_count]
    cmp dl, 254
    je .finish

    ; buffer[char_count] = char;
    mov dl, [_gr_input_char_count]
    mov rax, _gr_input_buffer
    add al, dl
    mov BYTE[rax], cl

    ; char_count += 1
    inc [_gr_input_char_count]
    inc rax

    ; buffer[char_count] = NULL;
    ; This ensures the string always terminates with NULL
    mov BYTE[rax], 0

    .finish:
    ret
endp