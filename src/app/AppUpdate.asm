;;;
; This method is called once per frame. It should update the content of the screen
;;;
proc AppUpdate
	local x: DWORD, y: DWORD, len: DWORD, height:DWORD

	; clear background colour
	fastcall DrawClear, [_gr_col_background]

	; height = 16 - margin_y - margin_y
	xor eax, eax
	mov al, [_gr_margin_bottom]
	shl eax, 1
	add al, 16
	mov [height], eax

	; y = app_height - height - margin_y + log_offset
	xor eax, eax
	mov eax, [_gr_app_height]
	sub eax, [height]
	xor edx, edx
	mov dl, [_gr_margin_bottom]
	sub eax, edx
	add eax, [_gr_log_offset]
	mov [y], eax

	; x = margin_x
	xor eax, eax
	mov al, [_gr_margin_left]
	mov [x], eax

	fastcall AppDrawConsoleLog, [x], [y]

	; y = APP_HEIGHT - height
	xor ecx, ecx
	mov eax, [_gr_app_height]
	sub eax, [height]
	mov [y], eax

	fastcall DrawRectangle, 0, [y], [_gr_app_width], [height], [_gr_col_dark_background]

	; x = margin_x
	xor eax, eax
	mov al, [_gr_margin_left]
	mov [x], eax

	; y -= margin_bottom * 2
	xor eax, eax
	mov al, [_gr_margin_bottom]
	add [y], eax

	fastcall AppDrawInputLine, [x], [y]

	fastcall ArrayListSize, [_gr_log_input]
	cmp eax, 0
	jg .dont_draw_logo

	fastcall AppDrawLogo

	.dont_draw_logo:

    ret
endp