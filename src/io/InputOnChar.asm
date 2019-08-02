proc InputOnChar, char:WORD

    cmp cl, 0 ; NULL (0x00) = Backspace character
    je .done
    cmp cl, 8 ; BS (0x08) = Backspace character
    je .backspace
    cmp cl, 10 ; LF (0x0A) = Line feed character
    je .linefeed
    cmp cl, 13 ; CR (0x0D) = Carriage return
    je .linefeed

    fastcall InputBufferAddChar, cl
    ret

    .backspace:
    fastcall InputBufferRemoveChar
    ret

    .linefeed: ; enter key
    fastcall ConsoleInputHandle, _gr_input_buffer
    ret

    .done:
    ret
endp