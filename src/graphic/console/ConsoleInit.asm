;;;
; Inits the console log system
;;;
proc ConsoleInit

    fastcall InputBufferClear
    fastcall OutputBufferClear

    ; Create two parallel lists for storing the input log and the output log
    fastcall ArrayListCreate, 16
    mov [_gr_log_input], rax

    fastcall ArrayListCreate, 16
    mov [_gr_log_output], rax

    ret
endp