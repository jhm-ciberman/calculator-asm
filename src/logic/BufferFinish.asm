proc BufferFinish

    ; if (buffi != 0)
    mov rdx, [_lg_buffer_length]
    cmp rdx, 0
    jz .done

    ; buff[buffi] = 0;
    mov byte[_lg_buffer_str + rdx], 0
    ; buffi = 0
    mov [_lg_buffer_length], 0

    fastcall StringToDecimal, _lg_buffer_str
    fastcall ArrayListPush, [_lg_stack], rax

    .done:
    ret
endp
