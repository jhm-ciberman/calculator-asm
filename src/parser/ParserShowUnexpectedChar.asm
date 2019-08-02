proc ParserShowUnexpectedChar, char:BYTE
    mov [char], cl
    fastcall ConsolePrint, _gr_message_unexpected
    fastcall ConsolePrintChar, [char]
    fastcall ConsolePrint, _gr_message_at_input_string
    ret
endp