proc ParserCommandAddChar, character
    mov rdx, [_lg_buffer_length]
    mov byte[_lg_buffer_str + rdx], cl
    inc [_lg_buffer_length]
    ret
endp