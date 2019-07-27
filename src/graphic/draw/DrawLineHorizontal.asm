;;;
; Draws an horizontal line
;
; params:
;   x     - The starting x position 
;   y     - The starting y position
;   width - The width of the line
;   col   - The color to fill the line
;;;
proc DrawLineHorizontal, x, y, width, colour
    mov [x], rcx
    mov [y], rdx
    mov [width], r8
    mov [colour], r9

    ; while (width != 0) then
    cmp r8, 0
    jz .endwhile

    .while:
    fastcall DrawPixel, [x], [y], [colour]
    inc [x]
    dec [width]
    jnz .while

    .endwhile:
    ret
endp