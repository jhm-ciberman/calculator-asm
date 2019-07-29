proc ConsoleAddCommand, str_input:QWORD, str_output:QWORD
    mov [str_input], rcx
    mov [str_output], rdx
    
    fastcall StringClone, [str_input]
    fastcall ArrayListPush, [_gr_log_input], rax

    fastcall StringClone, [str_output]
    fastcall ArrayListPush, [_gr_log_output], rax
    ret
endp