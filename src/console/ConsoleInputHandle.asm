proc ConsoleInputHandle, input: QWORD
    fastcall AppLogOffsetReset
    fastcall ParserParseString, rcx
    fastcall ConsoleFlushBuffers
    ret
endp