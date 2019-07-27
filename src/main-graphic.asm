
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
include 'graphic/draw/DrawSetTarget.asm'
include 'graphic/draw/DrawPixel.asm'
include 'graphic/draw/DrawLineHorizontal.asm'

start:
	sub	rsp,8		; Make stack dqword aligned
	fastcall WindowCreate

	test rax, rax
	jz .error
	mov [_gr_whandle], rax  ; save the whandle

	fastcall WindowDcInit
	invoke ShowWindow,[_gr_whandle],SW_NORMAL
	invoke UpdateWindow,[_gr_whandle]

	fastcall DrawSetTarget, APP_WIDTH, APP_HEIGHT, _gr_framebuffer

	; Thread Main loop
	fastcall DrawClear, $ff6d78a6

	.mainloop:
	fastcall ThreadProcessMessages
	fastcall AppUpdate
	
	; fastcall DrawPixel, [_gr_mouse_x], [_gr_mouse_y], $ffcfed09
	fastcall DrawLineHorizontal, [_gr_mouse_x], [_gr_mouse_y], 100, $ffedcf09

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
	_gr_str_class      TCHAR 'CALCWIN64',0              ; class name
	_gr_wc             WNDCLASSEX                       ; class
	_gr_whandle        dq 0                             ; handle
	_gr_dc             dq 0                             ; device context
	_gr_bmi            BITMAPINFOHEADER                 ; bitmap info header
	_gr_msg            MSG                              ; the message to process in the message queue
	_gr_mouse_x        dq 0                             ; the x mouse coordinate (relative to the upper left corner of the window)
	_gr_mouse_y        dq 0                             ; the y mouse coordinate (relative to the upper left corner of the window)

	align 16
	
	_gr_framebuffer    rd APP_WIDTH*APP_HEIGHT          ; The main application Framebuffer

	; The drawing target surface 
	_gr_draw_target_buff    dq 0                        ; colour buffer (pointer)
	_gr_draw_target_width   dq 0                        ; width
	_gr_draw_target_height  dq 0                        ; height

section '.idata' import data readable writeable

	library kernel32,'KERNEL32.DLL',\
		user32,'USER32.DLL', \
		gdi,'GDI32.DLL'

	include 'api\kernel32.inc'
	include 'api\user32.inc'
	import gdi,\
		SetDIBitsToDevice,'SetDIBitsToDevice'
