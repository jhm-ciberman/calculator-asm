proc ConsoleInputHandle, input: QWORD
    fastcall ParserParseString, rcx
    fastcall ConsoleFlushBuffers
    ret
endp