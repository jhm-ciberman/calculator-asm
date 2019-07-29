;;;
; This method is called once per frame. It should update the content of the screen
;;;
proc AppUpdate
	local x: DWORD, y: DWORD, len: DWORD

	; clear background colour
	fastcall DrawClear, [_gr_col_background]

	; y = APP_HEIGHT - 16 - margin_y
	xor ecx, ecx
	mov eax, APP_HEIGHT
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

	sub [y], 16
	
	local i:DWORD
	; i := ArrayListSize(log_input) - 1
	fastcall ArrayListSize, [_gr_log_input]
	dec eax
	mov [i], eax

	.console_loop:
	; if (i >= 0)
	mov eax, [i]
	cmp eax, 0
	jl .end_console_loop
	
	; if (y >= 0)
	mov eax, [y]
	cmp eax, 0
	jl .end_console_loop

	; x = margin_x
	xor eax, eax
	mov al, [_gr_margin_left]
	mov [x], eax

	fastcall ArrayListGet, [_gr_log_output], [i]
	fastcall DrawPixelText, [x], [y], rax, [_gr_col_muted]

	sub [y], 16

	fastcall DrawPixelText, [x], [y], _gr_str_console_start, [_gr_col_text]

	add [x], 16

	fastcall ArrayListGet, [_gr_log_input], [i]
	fastcall DrawPixelText, [x], [y], rax, [_gr_col_text]

	sub [y], 16
	dec [i]
	jmp .console_loop

	.end_console_loop:

    ret
endp