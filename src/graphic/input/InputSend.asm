proc InputSend
    fastcall ConsoleAddCommand, _gr_input_buffer, _gr_str_ok
    fastcall InputBufferClear
    ret
endp