
format PE64 GUI 5.0
entry start

include 'win64a.inc'

section '.text' code readable executable

; Frame real buffer
WIN_WIDTH  equ 800
WIN_HEIGHT equ 600

; Application virtual buffer
APP_PIXEL_SCALEX equ 4
APP_PIXEL_SCALEY equ 4
APP_WIDTH  equ WIN_WIDTH/APP_PIXEL_SCALEX
APP_HEIGHT equ WIN_HEIGHT/APP_PIXEL_SCALEY


include 'graphic/AppInit.asm'
include 'graphic/AppUpdate.asm'
include 'graphic/ThreadProcessMessages.asm'

include 'graphic/arraylist/ArrayListCreate.asm'
include 'graphic/arraylist/ArrayListGet.asm'
include 'graphic/arraylist/ArrayListPush.asm'
include 'graphic/arraylist/ArrayListSize.asm'

include 'graphic/console/ConsoleInit.asm'

include 'graphic/window/WindowSurfaceFlush.asm'
include 'graphic/window/WindowCreate.asm'
include 'graphic/window/WindowDcInit.asm'
include 'graphic/window/WindowProc.asm'

include 'graphic/input/InputBufferAddChar.asm'
include 'graphic/input/InputBufferRemoveChar.asm'
include 'graphic/input/InputBufferClear.asm'
include 'graphic/input/InputOnKeyDown.asm'
include 'graphic/input/InputSend.asm'

include 'graphic/draw/DrawBuffer.asm'
include 'graphic/draw/DrawBufferScaled.asm'
include 'graphic/draw/DrawClear.asm'
include 'graphic/draw/DrawSetTarget.asm'
include 'graphic/draw/DrawPixel.asm'
include 'graphic/draw/DrawPixelChar.asm'
include 'graphic/draw/DrawPixelText.asm'
include 'graphic/draw/DrawLineHorizontal.asm'
include 'graphic/draw/DrawRectangle.asm'


start:
	sub	rsp,8		; Make stack dqword aligned
	fastcall AppInit

section '.data' data readable writeable

	; strings
	_gr_str_title             TCHAR 'Postfix calculator',0
	_gr_str_error             TCHAR 'Startup failed.',0
	_gr_str_console_start     TCHAR 175,32,0
	_gr_str_console_cursor    TCHAR 219,0

	; colours
	_gr_col_primary       dd $ffff2222
	_gr_col_text          dd $ffc0c0c0
	_gr_col_muted         dd $ffa0a0a0
	_gr_col_background    dd $ff222222

	; layout
	_gr_margin_top        db 5
	_gr_margin_left       db 5

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
	_gr_winbuffer    rd WIN_WIDTH*WIN_HEIGHT            ; The main window real framebuffer (real window size)
	_gr_appbuffer    rd APP_WIDTH*APP_HEIGHT            ; The application virtual framebuffer (smaller)

	; The active drawing target surface 
	_gr_draw_target_buff    dq 0                        ; colour buffer (pointer)
	_gr_draw_target_width   dq 0                        ; width
	_gr_draw_target_height  dq 0                        ; height

	; Input
	_gr_input_buffer       rb 255                       ; Max input = 255
	_gr_input_char_count   db 0                         ; Current character count
	
	; System time
	_gr_system_time    SYSTEMTIME                       ; The current system time

	include 'graphic/font.asm'

	struct ARRAYLIST
		allocsize   dq 0   ; The real allocated size
		size        dq 0   ; The real size
		list        dq ?   ; The list size
	ends

	_gr_console_log ARRAYLIST 

section '.idata' import data readable writeable

	library kernel32,'KERNEL32.DLL',\
		user32,'USER32.DLL', \
		gdi,'GDI32.DLL', \
		msvcrt, "MSVCRT.DLL"

	include 'api\kernel32.inc'
	include 'api\user32.inc'
	import gdi,\
		SetDIBitsToDevice,'SetDIBitsToDevice'

    import msvcrt,\
        strlen, 'strlen', \
		malloc, 'malloc', \
		realloc, 'realloc', \
		strcpy, 'strcpy', \
		free, 'free'
