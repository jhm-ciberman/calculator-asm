proc Main
    fastcall WindowCreate, 1024, 768, _gr_str_window_title
	
	test rax, rax
	jz .error
	mov [_gr_whandle], rax  ; save the whandle

	; Gets the device context fot that window
	invoke GetDC,[_gr_whandle]
	mov [_gr_dc],rax

	fastcall AppRecalculateWindowSize

	invoke ShowWindow,[_gr_whandle],SW_NORMAL
	;invoke UpdateWindow,[_gr_whandle]

    ; call the app init function
	fastcall AppInit
	
	; Thread Main loop
	.mainloop:

    ; Process all the incoming messages
    ; if the thread receives an exit message, this method returns 0
	fastcall AppThreadProcessMessages
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
	invoke MessageBox,NULL,_gr_str_error,NULL,MB_ICONERROR+MB_OK
	invoke DestroyWindow,[_gr_whandle]
	invoke ExitProcess,[_gr_msg.wParam]
    ret

    .exitapp:
    invoke ReleaseDC,[_gr_whandle],[_gr_dc]
	invoke DestroyWindow,[_gr_whandle]
	invoke ExitProcess,[_gr_msg.wParam]
    ret
endp