proc AppRecalculateWindowSize
	; Get client area size
	invoke GetClientRect, [_gr_whandle], _gr_client_rect
	mov eax, [_gr_client_rect.right]
	mov [_gr_win_width], eax
	mov eax, [_gr_client_rect.bottom]
	mov [_gr_win_height], eax

	xor edx, edx
	; app_width = win_width / pixel_scale_x
	mov eax, [_gr_win_width]
	cdq
	idiv [_gr_pixel_scale_x]
	mov [_gr_app_width], eax

	; app_height = win_height / pixel_scale_y
	mov eax, [_gr_win_height]
	cdq
	idiv [_gr_pixel_scale_y]
	mov [_gr_app_height], eax

	; Initialize bmi
	mov [_gr_bmi.biSize],sizeof.BITMAPINFOHEADER
	mov [_gr_bmi.biPlanes],1
	mov [_gr_bmi.biBitCount],32
	mov [_gr_bmi.biCompression],BI_RGB

	mov ecx, [_gr_win_width]
	mov [_gr_bmi.biWidth],ecx
	mov edx, [_gr_win_height]
	neg edx
	mov [_gr_bmi.biHeight],edx

	
	mov rax, [_gr_winbuffer]
	test rax, rax
	je .create_buffers
	
	fastcall BufferResize, [_gr_winbuffer], [_gr_win_width], [_gr_win_height]
	mov [_gr_winbuffer], rax

	fastcall BufferResize, [_gr_appbuffer], [_gr_app_width], [_gr_app_height]
	mov [_gr_appbuffer], rax
	
	jmp .finish

	.create_buffers:
	fastcall BufferCreate, [_gr_win_width], [_gr_win_height]
	mov [_gr_winbuffer], rax

	fastcall BufferCreate, [_gr_app_width], [_gr_app_height]
	mov [_gr_appbuffer], rax

	.finish:
	fastcall DrawSetTarget, [_gr_app_width], [_gr_app_height], [_gr_appbuffer]
	ret
endp