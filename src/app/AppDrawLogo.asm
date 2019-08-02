proc AppDrawLogo
	local x:DWORD, y:DWORD, scale:DWORD
	mov [scale], 4


	; x = (APP_WIDTH - logo_w * scale) / 2
	mov eax, [_gr_logo_w]
	imul [scale]
	mov edx, eax
	mov eax, [_gr_app_width]
	sub eax, edx
	shr eax, 1
	mov [x], eax

	; y = APP_HEIGHT / 4
	mov eax, [_gr_app_height]
	shr eax, 2
	mov [y], eax

	fastcall DrawBufferScaled, _gr_logo_data, [_gr_logo_w], [_gr_logo_h], [x], [y], [scale], [scale]

	; x = (APP_WIDTH - strlen(str_title) * 8) / 2
	invoke strlen, _gr_str_title
	shl eax, 3
	mov edx, eax
	mov eax, [_gr_app_width]
	sub eax, edx
	shr eax, 1
	mov [x], eax

	; y = y + logo_h * scale + 20
	xor edx, edx
	mov eax, [_gr_logo_h]
	imul [scale]
	add eax, 20
	add [y], eax

	fastcall DrawPixelTextOutline, [x], [y], _gr_str_title, [_gr_col_title], [_gr_col_secondary]

	add [y], 23

	; x = (APP_WIDTH - strlen(_gr_str_subtitle) * 8) / 2
	invoke strlen, _gr_str_subtitle
	shl eax, 3
	mov edx, eax
	mov eax, [_gr_app_width]
	sub eax, edx
	shr eax, 1
	mov [x], eax

	fastcall DrawPixelText, [x], [y], _gr_str_subtitle, [_gr_col_muted]

    ret
endp