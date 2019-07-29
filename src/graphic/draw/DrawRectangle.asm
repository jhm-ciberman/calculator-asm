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
proc DrawRectangle, x:DWORD, y:DWORD, width:DWORD, height:DWORD, colour:DWORD
    mov [x], ecx
    mov [y], edx
    mov [width], r8d
    mov [height], r9d

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
