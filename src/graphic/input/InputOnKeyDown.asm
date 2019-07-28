;;;
; Handles the keyboard input for the input field.
;
; params:
;   keycode - The windows virtual key code for the key that was pressed
;;;
proc InputOnKeyDown, keycode:QWORD
    ; Complete list of keycodes: https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
    mov [keycode], rcx

    ; if (keycode > 0x30 && keycode <= 0x39)
    cmp rcx, 0x30 ; 0 key
    jnge .non_number
    cmp rcx, 0x39 ; 9 key
    jnle .non_number

    ; add the number to the current input
    fastcall InputBufferAddChar, cl
    ret
    .non_number:
    
    ; if (keycode > 0x41 && keycode <= 0x5A)
    cmp rcx, 0x41 ; 'A' key
    jnge .non_letter
    cmp rcx, 0x5A ; 'Z' key
    jnle .non_letter

    ; if (GetKeyState(VK_SHIFT) & 0x8000)
    invoke GetKeyState, VK_SHIFT
    test ax, 0x8000
    jne .shift_not_pressed

    mov rcx, [keycode]
    add rcx, 32 ;convert uppercase to lowercase
    jmp .addchar

    .shift_not_pressed:
    mov rcx, [keycode]
    jmp .addchar
    .non_letter:

    cmp rcx, VK_NUMPAD0 ; 0 key
    jnge .non_numpad
    cmp rcx, VK_NUMPAD9 ; 9 key
    jnle .non_numpad
    
    sub cl, 48
    jmp .addchar

    .non_numpad:
    ; switch
    cmp rcx, VK_BACK
    je .vkbackspace
    cmp rcx, VK_SPACE
    je .vkspace
    cmp rcx, VK_MULTIPLY
    je .vkmultiply
    cmp rcx, VK_ADD
    je .vkadd
    cmp rcx, VK_SEPARATOR
    je .vkseparator
    cmp rcx, VK_SUBTRACT
    je .vksubstract
    cmp rcx, VK_DECIMAL
    je .vkdecimal
    cmp rcx, VK_DIVIDE
    je .vkdivide
    cmp rcx, VK_RETURN ; VK_RETURN = enter key
    je .vkreturn
    cmp rcx, 0xBB ; VK_OEM_PLUS
    je .vkadd
    cmp rcx, 0xBC ; VK_OEM_COMMA
    je .vkseparator
    cmp rcx, 0xBD ; VK_OEM_MINUS
    je .vksubstract
    cmp rcx, 0xBE ; VK_OEM_PERIOD
    je .vkdecimal

    jmp .finish

    .vkbackspace:
    fastcall InputBufferRemoveChar
    ret
    .vkspace:
    mov cl, 32
    jmp .addchar
    .vkmultiply:
    mov cl, 42
    jmp .addchar
    .vkadd:
    mov cl, 43
    jmp .addchar
    .vkseparator:
    mov cl, 44
    jmp .addchar
    .vksubstract:
    mov cl, 45
    jmp .addchar
    .vkdecimal:
    mov cl, 46
    jmp .addchar
    .vkdivide:
    mov cl, 47
    jmp .addchar
    
    .vkreturn: ; enter key
    fastcall InputSend
    jmp .finish

    .addchar:
    fastcall InputBufferAddChar, cl
    
    .finish:
    ; do nothing
    ret
endp