;;;
; Sends the content of the input and output buffer to the console log,
; clearing both buffers.
;;;
proc ConsoleFlushBuffers
    mov ax, [_gr_output_char_count]
    cmp ax, 0
    jne .input_buffer_has_content ; output buffer empty

    fastcall ConsolePrint, _gr_str_ok

    .input_buffer_has_content:

    mov al, [_gr_input_char_count]
    cmp al, 0
    je .done ; input buffer empty

    fastcall ConsoleAddCommand, _gr_input_buffer, _gr_output_buffer
    
    .done:
    fastcall InputBufferClear
    fastcall OutputBufferClear
    ret
endp