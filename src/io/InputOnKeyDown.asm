;;;
; Handles the keyboard input for the input field.
;
; params:
;   keycode - The windows virtual key code for the key that was pressed
;;;
proc InputOnKeyDown, keycode:QWORD
    ; Complete list of keycodes: https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
    mov [keycode], rcx

    .non_numpad:
    ; switch
    cmp rcx, VK_PRIOR
    je .vkprior
    cmp rcx, VK_NEXT
    je .vknext
    cmp rcx, VK_END
    je .vkend

    jmp .finish

    .vkprior: ; Page up
    fastcall AppLogOffsetIncrement, 8
    jmp .finish

    .vknext: ; Page down
    fastcall AppLogOffsetIncrement, -8
    jmp .finish

    .vkend: ; END key
    fastcall AppLogOffsetReset
    jmp .finish

    .finish:
    ; do nothing
    ret
endp