
format PE64 GUI 5.0
entry start

include 'win64a.inc'

section '.text' code readable executable


include 'graphic/CalcWindowCreate.asm'
include 'graphic/WindowProc.asm'

start:
	sub	rsp,8		; Make stack dqword aligned
	call CalcWindowCreate

	test rax, rax
	jz .error
	mov [_gr_whandle], rax  ; save the whandle

	; Gets the device context fot that window
	; invoke GetDC,[_gr_whandle]
	; mov [_gr_dc],rax

	; mov [_gr_bmi.biSize],sizeof.BITMAPINFOHEADER
	; mov [_gr_bmi.biWidth],XRES
	; mov [_gr_bmi.biHeight],-YRES
	; mov [_gr_bmi.biPlanes],1
	; mov [_gr_bmi.biBitCount],32
	; mov [_gr_bmi.biCompression],BI_RGB
	;invoke ShowWindow,[_gr_whandle],SW_NORMAL
	;invoke UpdateWindow,[_gr_whandle]

  	.msg_loop:
	invoke	GetMessage,_gr_msg,NULL,0,0

	; if eax <= 0 then exit loop (0 means WP_EXIT and -1 means an error)
	cmp	eax,1
	jb	.end_loop

	; if eax == 1 then continue
	jne	.msg_loop

	invoke	TranslateMessage,_gr_msg
	invoke	DispatchMessage,_gr_msg
	jmp	.msg_loop

  	.error:
	invoke	MessageBox,NULL,_gr_str_error,NULL,MB_ICONERROR+MB_OK

  	.end_loop:
	invoke ReleaseDC,[_gr_whandle],[_gr_dc]
	invoke DestroyWindow,[_gr_whandle]
	invoke ExitProcess,[_gr_msg.wParam]

section '.data' data readable writeable

	; strings
	_gr_str_title TCHAR 'Calculadora en PostFijo',0
	_gr_str_error TCHAR 'Startup failed.',0

	; Window
	_gr_str_class TCHAR 'CALCWIN64',0  ; the windows class name
	_gr_wc        WNDCLASSEX           ; the window class
	_gr_whandle   dq 0                 ; the window handle
	_gr_dc        dq 0                 ; the window device context
	_gr_bmi       BITMAPINFOHEADER     ; the window bitmap info header
	_gr_msg       MSG                  ; the message to process in the message queue

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL',\
	  user32,'USER32.DLL'

  include 'api\kernel32.inc'
  include 'api\user32.inc'
