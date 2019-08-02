;;;
; Creates the main window.
;
; params:
;   width  - The initial width of the window
;   height - The initial height of the window
;   title  - A pointer to a null terminated string with the title of the window
;
; returns: (QWORD) The window handle or 0 if fails
;;;
proc WindowCreate, width:QWORD, height:QWORD, title:QWORD
    mov [width], rcx
    mov [height], rdx
    mov [title], r8

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
        0, \                                                ; Optional window styles
        _gr_str_class, \                                    ; Window class name
        [title], \                                          ; Window title
        WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU+WS_MAXIMIZEBOX, \     ; Window style
        CW_USEDEFAULT, \                                    ; Position x
        CW_USEDEFAULT, \                                    ; Position y
        [width], \                                          ; Size width
        [height], \                                         ; Size height
        NULL, \                                             ; Parent window    
        NULL, \                                             ; Menu
        [_gr_wc.hInstance], \                               ; Instance handle
        NULL                                                ; Additional application data

	test	rax,rax
	jz	.error

    ; return the window context if all ok
    ret

    .error:
    ; return 0 if fails
    xor rax, rax 
    ret
endp