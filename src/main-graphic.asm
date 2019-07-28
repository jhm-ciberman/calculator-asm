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

include 'graphic/include.asm'
include 'arraylist/include.asm'

start:
	sub	rsp,8		; Make stack dqword aligned
	fastcall Main

section '.data' data readable writeable

include 'graphic/data.asm'

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
