;;;
; Creates the main window.
; it saves the window handle in _gr_whandle, and the window device context in _gr_dc
;
; returns: 1 if ok, 0 if fails
;;;
proc CreateWindow

    mov	[_gr_wc.cbSize],sizeof.WNDCLASSEX               ; The struct size
    mov	[_gr_wc.style],0                                ; Window Classs style
    mov	[_gr_wc.lpfnWndProc],WindowProc                 ; procedure to be called by windows to handle events
    mov	[_gr_wc.cbClsExtra],0                           ; The number of extra bytes to allocate following the window-class structure
    mov	[_gr_wc.cbWndExtra],0                           ; The number of extra bytes to allocate following the window instance
    mov	[_gr_wc.hInstance],NULL                         ; The hInstance windows instance handler
    mov	[_gr_wc.hIcon],NULL                             ; The default icon
    mov	[_gr_wc.hCursor],NULL                           ; The default cursor
    mov	[_gr_wc.hbrBackground],COLOR_BTNFACE+1          ; Window class background
    mov	dword [_gr_wc.lpszMenuName],NULL                ; Window class menu name
    mov	dword [_gr_wc.lpszClassName],_gr_str_class      ; Window class name
	mov	[_gr_wc.hIconSm],NULL                           ; The default icon small

    invoke	GetModuleHandle,0
	mov	[_gr_wc.hInstance],rax

    ; Load the default icon (hIcon and hIconSm)
	invoke	LoadIcon,0,IDI_APPLICATION
	mov	[_gr_wc.hIcon],rax
	mov	[_gr_wc.hIconSm],rax

    ; Load the default arrow cursor (hCursor)
	invoke	LoadCursor,0,IDC_ARROW
	mov	[_gr_wc.hCursor],rax

	; Register the window class
	invoke	RegisterClassEx,_gr_wc
	test	rax,rax
	jz	.error

    ; Create the main window
	invoke	CreateWindowEx, \
        0, \                                     ; Optional window styles
        _gr_str_class, \                         ; Window class name
        _gr_str_title, \                         ; Window title
        WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU, \     ; Window style
        CW_USEDEFAULT,CW_USEDEFAULT, \           ; Position (x, y)
        CW_USEDEFAULT,CW_USEDEFAULT, \           ; Size (w, h)
        NULL, \                                  ; Parent window    
        NULL, \                                  ; Menu
        [_gr_wc.hInstance], \                        ; Instance handle
        NULL                                     ; Additional application data

	test	rax,rax
	jz	.error

	mov [_gr_whandle], rax                       ; save the whandle

    ; Gets the device context fot that window
	invoke GetDC,[_gr_whandle]
	mov [_gr_dc],rax

	mov [_gr_bmi.biSize],sizeof.BITMAPINFOHEADER
	mov [_gr_bmi.biWidth],XRES
	mov [_gr_bmi.biHeight],-YRES
	mov [_gr_bmi.biPlanes],1
	mov [_gr_bmi.biBitCount],32
	mov [_gr_bmi.biCompression],BI_RGB
	;invoke ShowWindow,[hwnd],SW_NORMAL
	;invoke UpdateWindow,[hwnd]

    ; return 1 if all ok
    xor rax, rax
    inc rax
    ret

    .error:
    ; return 0 if fails
    xor rax, rax 
    ret
endp