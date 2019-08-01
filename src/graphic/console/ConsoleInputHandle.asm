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
    
    mov rax, _gr_str_unknown
    jmp .done

    .cmd_exit:
    invoke	PostQuitMessage,0
    mov rax, _gr_str_byebye
    jmp .done

    .cmd_help:
    invoke ShellExecute, 0, 0, _gr_str_help_url, 0, 0, SW_SHOW
    mov rax, _gr_str_showing_help
    jmp .done

    .cmd_clear:
    fastcall ConsoleClear
    fastcall InputBufferClear
    ret

    .done:
    fastcall ConsoleAddCommand, [input], rax
    fastcall InputBufferClear
    ret
endp