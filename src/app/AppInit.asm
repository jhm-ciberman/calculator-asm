;;;
; This method is called when the app inits. It is the main method
;;;
proc AppInit
    fastcall ConsoleInit
    fastcall ParserInit

    ; Add specific GUI commands
    fastcall ArrayListPush, [_lg_commands_list], _gr_str_cmd_exit
    fastcall ArrayListPush, [_lg_commands_handlers], DoExit
    fastcall ArrayListPush, [_lg_commands_list], _gr_str_cmd_help
    fastcall ArrayListPush, [_lg_commands_handlers], DoHelp
    fastcall ArrayListPush, [_lg_commands_list], _gr_str_cmd_man
    fastcall ArrayListPush, [_lg_commands_handlers], DoMan
    fastcall ArrayListPush, [_lg_commands_list], _gr_str_cmd_clear
    fastcall ArrayListPush, [_lg_commands_handlers], DoClear
    fastcall ArrayListPush, [_lg_commands_list], _gr_str_cmd_zoomplus
    fastcall ArrayListPush, [_lg_commands_handlers], DoZoomPlus
    fastcall ArrayListPush, [_lg_commands_list], _gr_str_cmd_zoomminus
    fastcall ArrayListPush, [_lg_commands_handlers], DoZoomMinus

	ret
endp