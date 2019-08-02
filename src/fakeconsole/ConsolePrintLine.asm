;;;
; Prints the string on the console and starts a new line. 
; The string will be appended to the current output string.
; It not be shown on screen until the command finishes its execution.
; 
; params:
;   string - The string to print
;;;
proc ConsolePrintLine, string:QWORD
    invoke printf, rcx
    invoke printf, _format_lf
    ret
endp