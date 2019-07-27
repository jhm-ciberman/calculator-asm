proc AppInit
    fastcall WindowCreate, WIN_WIDTH, WIN_HEIGHT, _gr_str_title

	test rax, rax
	jz .error
	mov [_gr_whandle], rax  ; save the whandle

	fastcall WindowDcInit, WIN_WIDTH, WIN_HEIGHT
	invoke ShowWindow,[_gr_whandle],SW_NORMAL
	invoke UpdateWindow,[_gr_whandle]

	fastcall DrawSetTarget, WIN_WIDTH, WIN_HEIGHT, _gr_winbuffer
	fastcall DrawClear, $ff282d26

	; Thread Main loop
	.mainloop:
	fastcall ThreadProcessMessages
	fastcall DrawSetTarget, APP_WIDTH, APP_HEIGHT, _gr_appbuffer
	fastcall AppUpdate
	fastcall DrawSetTarget, WIN_WIDTH, WIN_HEIGHT, _gr_winbuffer
	fastcall DrawBufferScaled, _gr_appbuffer, APP_WIDTH, APP_HEIGHT, 0, 0, APP_PIXEL_SCALEX, APP_PIXEL_SCALEY
	fastcall WindowSurfaceFlush
    jmp .mainloop

  	.error:
	invoke	MessageBox,NULL,_gr_str_error,NULL,MB_ICONERROR+MB_OK
	invoke DestroyWindow,[_gr_whandle]
	invoke ExitProcess,[_gr_msg.wParam]
    ret
endp