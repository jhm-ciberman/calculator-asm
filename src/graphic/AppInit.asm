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

	fastcall InputBufferClear
	
	fastcall DrawSetTarget, APP_WIDTH, APP_HEIGHT, _gr_appbuffer
	fastcall ArrayListCreate, 1
	local list:QWORD
	mov [list], rax
	fastcall ArrayListPush, [list], 100
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 110
	fastcall ArrayListPush, [list], 20
	fastcall ArrayListPop, [list]

	;fastcall ArrayListSize, [list]
	;dec eax
	;fastcall ArrayListGet, [list], eax
	
	fastcall DrawPixel, eax, 50, $ffff0000

	fastcall ArrayListSize, [list]
	fastcall DrawPixel, eax, 52, $ff00ff00
	
	fastcall DrawPixel, 5, 51, $ffffffff
	fastcall DrawPixel, 10, 51, $ffffffff
	fastcall DrawPixel, 15, 51, $ffffffff
	fastcall DrawPixel, 20, 51, $ffffffff
	fastcall DrawPixel, 25, 51, $ffffffff
	fastcall DrawPixel, 100, 51, $ffffffff

	; Thread Main loop
	.mainloop:
	fastcall ThreadProcessMessages
	fastcall DrawSetTarget, APP_WIDTH, APP_HEIGHT, _gr_appbuffer
	;fastcall AppUpdate
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