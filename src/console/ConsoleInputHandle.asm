proc ConsoleInputHandle, input: QWORD
    mov [input], rcx

    invoke strcmp, [input], _gr_str_cmd_exit
    test eax, eax
    je .cmd_exit

    invoke strcmp, [input], _gr_str_cmd_help
    test eax, eax
    je .cmd_help

    invoke strcmp, [input], _gr_str_cmd_clear
    test eax, eax
    je .cmd_clear
    
    fastcall ParserParseString, [input]
    jmp .done

    .cmd_exit:
    invoke	PostQuitMessage,0
    fastcall ConsolePrint, _gr_message_byebye
    jmp .done

    .cmd_help:
    invoke ShellExecute, 0, 0, _gr_str_help_url, 0, 0, SW_SHOW
    fastcall ConsolePrint, _gr_message_showing_help
    jmp .done

    .cmd_clear:
    fastcall InputBufferClear
    fastcall OutputBufferClear
    fastcall ConsoleClear

    .done:
    fastcall ConsoleFlushBuffers
    ret
endp