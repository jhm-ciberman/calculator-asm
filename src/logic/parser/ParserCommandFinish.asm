;;;
; Process the contents of the command buffer and executes the asociated command
; If the buffer is empty, this function does nothing
;;;
proc ParserCommandFinish

    ; if (buffi != 0)
    mov rdx, [_lg_buffer_length]
    cmp rdx, 0
    jz .done

    ; buff[buffi] = 0;
    mov byte[_lg_buffer_str + rdx], 0
    ; buffi = 0
    mov [_lg_buffer_length], 0

    fastcall CommandParserProcessCommand, _lg_buffer_str

    .done:
    ret
endp
