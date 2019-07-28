;;;
; This method is called once per frame. It should update the content of the screen
;;;
proc AppUpdate
	local x: DWORD, y: DWORD, len: DWORD

	; clear background colour
	fastcall DrawClear, [_gr_col_background]

	xor eax, eax
	mov al, [_gr_margin_top]
	mov [y], eax
	mov al, [_gr_margin_left]
	mov [x], eax

	; draw the ">> " string at the start of the input line
	fastcall DrawPixelText, [x], [y], _gr_str_console_start, [_gr_col_primary]

	add [x], 16

	; Draw the user input
	fastcall DrawPixelText, [x], [y], _gr_input_buffer, [_gr_col_text]

	; if current second is odd, don't draw the cursor
	invoke GetSystemTime, _gr_system_time
	mov ax, [_gr_system_time.wSecond]
	test ax, 1
	jne .odd_second

	; x := x + strlen(input_buffer) * 8
	invoke strlen, _gr_input_buffer
	shl eax, 3
	add [x], eax

	; Draw the carret
	fastcall DrawPixelText, [x], [y], _gr_str_console_cursor, [_gr_col_primary]

	.odd_second:


    ret
endp