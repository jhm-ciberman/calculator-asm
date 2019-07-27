
format PE64 GUI 5.0
entry start

include 'win64a.inc'

section '.text' code readable executable

; Frame real buffer
WIN_WIDTH  equ 640
WIN_HEIGHT equ 480
; Application virtual buffer
APP_PIXEL_SCALEX equ 4
APP_PIXEL_SCALEY equ 4
APP_WIDTH  equ WIN_WIDTH/APP_PIXEL_SCALEX
APP_HEIGHT equ WIN_HEIGHT/APP_PIXEL_SCALEY



include 'graphic/AppUpdate.asm'
include 'graphic/ThreadProcessMessages.asm'

include 'graphic/window/WindowSurfaceFlush.asm'
include 'graphic/window/WindowCreate.asm'
include 'graphic/window/WindowDcInit.asm'
include 'graphic/window/WindowProc.asm'

include 'graphic/draw/DrawBufferScaled.asm'
include 'graphic/draw/DrawClear.asm'
include 'graphic/draw/DrawSetTarget.asm'
include 'graphic/draw/DrawPixel.asm'
include 'graphic/draw/DrawLineHorizontal.asm'
include 'graphic/draw/DrawRectangle.asm'

start:
	sub	rsp,8		; Make stack dqword aligned
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
	fastcall AppUpdate
	fastcall DrawSetTarget, APP_WIDTH, APP_HEIGHT, _gr_appbuffer
	fastcall DrawClear, $ff6d78a6

	; fastcall DrawPixel, [_gr_mouse_x], [_gr_mouse_y], $ffcfed09
	mov rax, [_gr_mouse_x]
	shr rax, 2

	mov rbx, [_gr_mouse_y]
	shr rbx, 2

	fastcall DrawRectangle, rax, rbx, 100, 20, $ffedcf09

	fastcall DrawSetTarget, WIN_WIDTH, WIN_HEIGHT, _gr_winbuffer
	fastcall DrawBufferScaled, _gr_appbuffer, APP_WIDTH, APP_HEIGHT, 0, 0, APP_PIXEL_SCALEX, APP_PIXEL_SCALEY
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
	
	_gr_winbuffer    rd WIN_WIDTH*WIN_HEIGHT          ; The main application Framebuffer
	_gr_appbuffer    rd APP_WIDTH*APP_HEIGHT
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
