proc Main
    fastcall WindowCreate, WIN_WIDTH, WIN_HEIGHT, _gr_str_title
	
	test rax, rax
	jz .error
	mov [_gr_whandle], rax  ; save the whandle

	fastcall WindowDcInit, WIN_WIDTH, WIN_HEIGHT
	invoke ShowWindow,[_gr_whandle],SW_NORMAL
	invoke UpdateWindow,[_gr_whandle]

	fastcall BufferCreate, WIN_WIDTH, WIN_HEIGHT
	mov [_gr_winbuffer], rax

	fastcall BufferCreate, APP_WIDTH, APP_HEIGHT
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
	fastcall DrawSetTarget, APP_WIDTH, APP_HEIGHT, [_gr_appbuffer]

    ; call the app update function
	fastcall AppUpdate

    ; copy the app buffer to the win buffer and sends its content to the window
	fastcall DrawSetTarget, WIN_WIDTH, WIN_HEIGHT, [_gr_winbuffer]
	fastcall DrawBufferScaled, [_gr_appbuffer], APP_WIDTH, APP_HEIGHT, 0, 0, APP_PIXEL_SCALEX, APP_PIXEL_SCALEY
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