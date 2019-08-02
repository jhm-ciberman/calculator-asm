;;;
; Adds a command into the console log
;
; params:
;   str_input  - The input string (what the user typed)
;   str_output - The output string (The command response)
;;;
proc ConsoleAddCommand, str_input:QWORD, str_output:QWORD
    mov [str_input], rcx
    mov [str_output], rdx
    
    fastcall StringClone, [str_input]
    fastcall ArrayListPush, [_gr_log_input], rax

    fastcall StringClone, [str_output]
    fastcall ArrayListPush, [_gr_log_output], rax
    ret
endp