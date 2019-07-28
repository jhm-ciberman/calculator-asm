;             ### Converts _str from String to Decimal ###
;------------------------------------------------------------------------
; Used to cast Strings to Decimal
;
;------------------------------------------------------------------------

proc StringToDecimal uses rax rbx rcx rdx, _str:QWORD ; _str saved in rcx

mov rcx, [_str] ; The String   
xor rax,rax     ; Accumulator
xor rbx, rbx    ; Byte Pointer

.mainloop:
    xor rdx, rdx               
    mov dl, byte [rcx + rbx]   ; Gets a character from the string
    cmp rcx, '0'               ; Greater than 0 ?
    jl .done
    cmp rcx, '9'               ; Lower than 9?
    jg .done
    sub rcx, '0'               ; Current Byte - ASCII 48 = Decimal Number
    imul rax, 10               ; Multiplies accumulator by ten
    add rax, rdx
    inc rbx                    ; Ready for next character
    jmp .mainloop
    
.done:
    fastcall PrintString, rax
    ret
endp

; 0 -- 48
; 1 -- 49
; 2 -- 50
; 3 -- 51
; 4 -- 52
; 5 -- 53
; 6 -- 54
; 7 -- 55
; 8 -- 56
; 9 -- 57

; 1 + 0 * 10  = 1
; 2 + 1 * 10  = 12
; 3 + 12 * 10 = 123