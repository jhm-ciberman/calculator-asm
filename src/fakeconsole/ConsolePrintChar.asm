;;;
; Prints the character on the console. The character will be appended to the current output string.
; It not be shown on screen until the command finishes its execution.
; 
; params:
;   char - The character to print
;;;
proc ConsolePrintChar, char:BYTE
    invoke printf, _format_character, cl
    ret
endp