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
    invoke strcmp, [input], _gr_str_cmd_zoomplus
    test eax, eax
    je .cmd_zoomplus
    invoke strcmp, [input], _gr_str_cmd_zoomminus
    test eax, eax
    je .cmd_zoomminus
    ;default
    fastcall ParserParseString, [input]
    jmp .done

    .cmd_exit:
    fastcall DoExit
    jmp .done

    .cmd_help:
    fastcall DoHelp
    jmp .done

    .cmd_clear:
    fastcall DoClear
    jmp .done

    .cmd_zoomplus:
    fastcall DoZoomPlus
    jmp .done

    .cmd_zoomminus:
    fastcall DoZoomMinus
    jmp .done

    .done:
    fastcall ConsoleFlushBuffers
    ret
endp