proc InputBufferRemoveChar
    ; if (char_count = 0) then return
    mov dl, [_gr_input_char_count]
    cmp dl, 0
    je .finish

    ; char_count -= 1
    dec [_gr_input_char_count]
    dec dl
    
    ; buffer[char_count] = NULL;
    ; This ensures the string always terminates with NULL
    mov rax, _gr_input_buffer
    add al, dl
    mov BYTE[rax], 0

    .finish:
    ret
endp