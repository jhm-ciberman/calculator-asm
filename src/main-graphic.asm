
format PE64 GUI 5.0
entry start

include 'win64a.inc'

section '.text' code readable executable

APP_WIDTH  equ 640
APP_HEIGHT equ 480

include 'graphic/AppUpdate.asm'
include 'graphic/ThreadProcessMessages.asm'

include 'graphic/window/WindowSurfaceFlush.asm'
include 'graphic/window/WindowCreate.asm'
include 'graphic/window/WindowDcInit.asm'
include 'graphic/window/WindowProc.asm'

include 'graphic/draw/DrawClear.asm'
include 'graphic/draw/DrawPixel.asm'

start:
	sub	rsp,8		; Make stack dqword aligned
	fastcall WindowCreate

	test rax, rax
	jz .error
	mov [_gr_whandle], rax  ; save the whandle

	fastcall WindowDcInit
	invoke ShowWindow,[_gr_whandle],SW_NORMAL
	invoke UpdateWindow,[_gr_whandle]

	; Thread Main loop
	fastcall DrawClear, $ff6d78a6

	.mainloop:
	fastcall ThreadProcessMessages
	fastcall AppUpdate
	
	fastcall DrawPixel, [_gr_mouse_x], [_gr_mouse_y], $ffcfed09

	fastcall WindowSurfaceFlush
    jmp .mainloop

  	.error:
	invoke	MessageBox,NULL,_gr_str_error,NULL,MB_ICONERROR+MB_OK
	invoke DestroyWindow,[_gr_whandle]
	invoke ExitProcess,[_gr_msg.wParam]

section '.data' data readable writeable

	; strings
	_gr_str_title      TCHAR 'Calculadora en PostFijo',0
	_gr_str_error      TCHAR 'Startup failed.',0

	; Window
	_gr_str_class      TCHAR 'CALCWIN64',0              ; the windows class name
	_gr_wc             WNDCLASSEX                       ; the window class
	_gr_whandle        dq 0                             ; the window handle
	_gr_dc             dq 0                             ; the window device context
	_gr_bmi            BITMAPINFOHEADER                 ; the window bitmap info header
	_gr_msg            MSG                              ; the message to process in the message queue

	_gr_mouse_x        dq 0                             ; the x mouse coordinate (relative to the upper left corner of the window)
	_gr_mouse_y        dq 0                             ; the y mouse coordinate (relative to the upper left corner of the window)

	align 16
	
	_gr_framebuffer    rd APP_WIDTH*APP_HEIGHT          ; The main application Framebuffer

section '.idata' import data readable writeable

	library kernel32,'KERNEL32.DLL',\
		user32,'USER32.DLL', \
		gdi,'GDI32.DLL'

	include 'api\kernel32.inc'
	include 'api\user32.inc'
	import gdi,\
		SetDIBitsToDevice,'SetDIBitsToDevice'
