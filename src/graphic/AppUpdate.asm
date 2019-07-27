proc AppUpdate
	fastcall DrawClear, $ff6d78a6

	; fastcall DrawPixel, [_gr_mouse_x], [_gr_mouse_y], $ffcfed09
	mov rax, [_gr_mouse_x]
	shr rax, 2

	mov rbx, [_gr_mouse_y]
	shr rbx, 2

	fastcall DrawRectangle, rax, rbx, 100, 20, $ffedcf09
    ret
endp