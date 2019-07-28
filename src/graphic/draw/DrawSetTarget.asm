;;;
; Sets the drawing target surface used by all the other drawing functions
; 
; params:
;   width  - The width of the surface
;   height - The height of the surface
;   buffer - A pointer to the colour buffer array
;;;
proc DrawSetTarget, width, height, buffer
    mov  [_gr_draw_target_width], rcx
    mov  [_gr_draw_target_height], rdx
    mov  [_gr_draw_target_buff], r8
    ret
endp