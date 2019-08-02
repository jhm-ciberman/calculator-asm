proc DoHelp 
    invoke ShellExecute, 0, 0, _gr_str_help_url, 0, 0, SW_SHOW
    fastcall ConsolePrint, _gr_message_showing_help
    ret
endp 