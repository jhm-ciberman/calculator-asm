;                          ### Prints _str ###
;------------------------------------------------------------------------
; Prints a string. Works as printf.
;
;------------------------------------------------------------------------

proc PrintString uses rcx, _str:QWORD ; _str saved in rcx
    
    invoke printf, rcx
    ret
endp