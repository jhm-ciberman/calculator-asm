;;;
; Draws the console log
;
; params:
;   x - The x coordinate of the lower left position of the log text
;   y - The y coordinate of the lower left position of the log text
;;;
proc AppDrawConsoleLog, x:DWORD, y:DWORD
	local i:DWORD, string:QWORD
    mov [x], ecx
    mov [y], edx
	
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
    mov [string], rax
    fastcall StringCountChar, rax, 10 ; count the number of LF characters (new lines)
    inc eax
    shl eax, 4 ; rax *= 4
    sub [y], eax

	fastcall DrawPixelText, [x], [y], [string], [_gr_col_muted]

    sub [y], 16

	fastcall DrawPixelText, [x], [y], _gr_str_console_start, [_gr_col_text]

	add [x], 16

	fastcall ArrayListGet, [_gr_log_input], [i]
	fastcall DrawPixelText, [x], [y], rax, [_gr_col_text]

	dec [i]
	jmp .console_loop

	.end_console_loop:
    ret
endp