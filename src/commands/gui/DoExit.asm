proc DoExit
    invoke	PostQuitMessage,0
    fastcall ConsolePrint, _gr_message_byebye
    ret
endp