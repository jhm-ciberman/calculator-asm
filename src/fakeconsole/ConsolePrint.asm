;;;
; Prints the string on the console. The string will be appended to the current output string.
; It not be shown on screen until the command finishes its execution.
; 
; params:
;   string - The string to print
;;;
proc ConsolePrint, string:QWORD
    invoke printf, rcx
    ret
endp