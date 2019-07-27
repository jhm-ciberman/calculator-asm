
;;;
; Draws a rectangle filled with the specified colour
;
; Arguments: 
;   x      - The starting x position 
;   y      - The starting y position
;   width  - The width of the rectangle
;   height - The height of the rectangle
;   col    - The color to fill the rectangle
;;; 
proc DrawRectangle, x, y, width, height, colour
    mov [x], rcx
    mov [y], rdx
    mov [width], r8
    mov [height], r9

    ; while (height != 0)
    cmp [height], 0 
    jz .endwhile

    .while:
    fastcall   DrawLineHorizontal, [x], [y], [width], [colour]

    inc [y]
    dec [height]
    jnz .while
    
    .endwhile:
    ret
endp
