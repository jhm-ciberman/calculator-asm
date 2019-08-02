proc AppLogOffsetIncrement, offset:DWORD
    add [_gr_log_offset], ecx
    ret
endp