;;;
; This method is called once per frame. It should update the content of the screen
;;;
proc AppUpdate
	local x: DWORD, y: DWORD, len: DWORD

	; clear background colour
	fastcall DrawClear, [_gr_col_background]

	; y = APP_HEIGHT - 16 - margin_y
	xor ecx, ecx
	mov eax, [_gr_app_height]
	mov cl, [_gr_margin_bottom]
	sub eax, ecx
	mov cl, 16
	sub eax, ecx
	mov [y], eax

	; x = margin_x
	xor eax, eax
	mov al, [_gr_margin_left]
	mov [x], eax

	fastcall AppDrawInputLine, [x], [y]

	fastcall ArrayListSize, [_gr_log_input]
	cmp eax, 0
	jg .dont_draw_logo

	fastcall AppDrawLogo

	.dont_draw_logo:


	; x = margin_x
	xor eax, eax
	mov al, [_gr_margin_left]
	mov [x], eax

	fastcall AppDrawConsoleLog, [x], [y]

    ret
endp