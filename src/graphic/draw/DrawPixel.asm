;;;
; Draws a pixel on the screen
; 
; params: 
;   x   (rcx) - The x position 
;   y   (rdx) - The y position
;   col (r8)  - The colour to fill the pixel
;;;
proc DrawPixel uses rbx, x, y, colour
    ; if (x >= dest_w) return;
    mov rax, APP_WIDTH
    cmp rcx, rax
    jge .return

    ; if (y >= dest_y) return;
    mov rbx, APP_HEIGHT
    cmp rdx, rbx
    jge .return
    
    ; alphatest
    ; if (col.alpha == 0) return;
    mov ebx, r8d
    and ebx, $FF000000 ; get only the alpha value
    jz .return 

    mul rdx
    add rax, rcx

    mov [_gr_framebuffer+rax*4],r8d    ; puts col in SOURCE_BUFFER[eax] 
    .return:
    ret
endp
