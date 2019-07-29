proc Main
    fastcall WindowCreate, 800, 600, _gr_str_title
	
	test rax, rax
	jz .error
	mov [_gr_whandle], rax  ; save the whandle

	invoke GetClientRect, [_gr_whandle], _gr_client_rect
	
	mov eax, [_gr_client_rect.right]
	mov [_gr_win_width], eax
	mov eax, [_gr_client_rect.bottom]
	mov [_gr_win_height], eax

	xor edx, edx
	; app_width = win_width / pixel_scale_x
	mov eax, [_gr_win_width]
	idiv [_gr_pixel_scale_x]
	mov [_gr_app_width], eax

	; app_height = win_height / pixel_scale_y
	mov eax, [_gr_win_height]
	idiv [_gr_pixel_scale_y]
	mov [_gr_app_height], eax

	fastcall WindowDcInit, [_gr_win_width], [_gr_win_height]
	invoke ShowWindow,[_gr_whandle],SW_NORMAL
	invoke UpdateWindow,[_gr_whandle]

	fastcall BufferCreate, [_gr_win_width], [_gr_win_height]
	mov [_gr_winbuffer], rax

	fastcall BufferCreate, [_gr_app_width], [_gr_app_height]
	mov [_gr_appbuffer], rax

    ; call the app init function
	fastcall AppInit
	
	; Thread Main loop
	.mainloop:

    ; Process all the incoming messages
    ; if the thread receives an exit message, this method returns 0
	fastcall ThreadProcessMessages
    test rax, rax
    je .exitapp

    ; set the draw target to the app buffer
	fastcall DrawSetTarget, [_gr_app_width], [_gr_app_height], [_gr_appbuffer]

    ; call the app update function
	fastcall AppUpdate

    ; copy the app buffer to the win buffer and sends its content to the window
	fastcall DrawSetTarget, [_gr_win_width], [_gr_win_height], [_gr_winbuffer]
	fastcall DrawBufferScaled, [_gr_appbuffer], [_gr_app_width], [_gr_app_height], 0, 0, [_gr_pixel_scale_x], [_gr_pixel_scale_y]
	fastcall WindowSurfaceFlush
    
    jmp .mainloop

  	.error:
	invoke	MessageBox,NULL,_gr_str_error,NULL,MB_ICONERROR+MB_OK
	invoke DestroyWindow,[_gr_whandle]
	invoke ExitProcess,[_gr_msg.wParam]
    ret

    .exitapp:
    invoke ReleaseDC,[_gr_whandle],[_gr_dc]
	invoke DestroyWindow,[_gr_whandle]
	invoke ExitProcess,[_gr_msg.wParam]
    ret
endp