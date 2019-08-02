;;;
; Converts _str from String to Decimal
; Used to cast Strings to Decimal
;;;
proc StringDecimalToInteger uses rbx, _str:QWORD ; _str saved in rcx
    mov [_str], rcx            ; The String   
    xor rax,rax                ; The output value
    xor r8,r8                  ; Current character
    xor rbx, rbx               ; Character Index

    .mainloop:
    ; r8b := str[rbx]
    mov r8b, byte [rcx + rbx]   ; Gets a character from the string

    ; if (dl >= '0' && dl <= '9')
    cmp r8b, '0'
    jl .done
    cmp r8b, '9'
    jg .done

    sub r8b, '0'                ; Current Byte - ASCII 48 = Decimal Number

    ; rax := (rax * 10) + r8b
    imul rax, 10
    add rax, r8

    ; rbx += 1
    inc rbx
    jmp .mainloop
    
    .done:
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