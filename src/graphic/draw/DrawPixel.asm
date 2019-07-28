;;;
; Draws a pixel on the screen
; 
; params: 
;   x   - The x position 
;   y   - The y position
;   col - The colour to fill the pixel
;;;
proc DrawPixel uses rbx, x, y, colour
    ; if (x >= dest_w) return;
    mov rax, [_gr_draw_target_width]
    cmp rcx, rax
    jge .return

    ; if (y >= dest_y) return;
    mov rbx, [_gr_draw_target_height]
    cmp rdx, rbx
    jge .return
    
    ; alphatest
    ; if (col.alpha == 0) return;
    mov ebx, r8d
    and ebx, $FF000000 ; get only the alpha value
    jz .return 

    mul rdx
    add rax, rcx

    mov rbx, [_gr_draw_target_buff]
    mov dword[rbx+rax*4],r8d    ; puts col in SOURCE_BUFFER[eax] 
    .return:
    ret
endp
