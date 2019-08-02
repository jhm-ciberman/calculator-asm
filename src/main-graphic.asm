format PE64 GUI 5.0
entry start

include 'win64a.inc'

section '.text' code readable executable

include 'app/include.asm'
include 'arraylist/include.asm'
include 'commands/include.asm'
include 'console/include.asm'
include 'conversion/include.asm'
include 'draw/include.asm'
include 'io/include.asm'
include 'parser/include.asm'
include 'string/include.asm'
include 'window/include.asm'
include 'Main.asm'

start:
	sub	rsp,8		; Make stack dqword aligned
	fastcall Main

section '.data' data readable writeable

include 'data.asm'

section '.idata' import data readable writeable

	library kernel32,'KERNEL32.DLL',\
		user32,'USER32.DLL', \
		gdi,'GDI32.DLL', \
		shell32,'SHELL32.DLL', \
		msvcrt, "MSVCRT.DLL"

	include 'api\kernel32.inc'
	include 'api\user32.inc'
	import gdi,\
		SetDIBitsToDevice,'SetDIBitsToDevice'
	import shell32,\
		ShellExecute, 'ShellExecuteA'
    import msvcrt,\
        strlen, 'strlen', \
		malloc, 'malloc', \
		realloc, 'realloc', \
		strcpy, 'strcpy', \
		free, 'free', \
		strcmp, 'strcmp', \
		sprintf, 'sprintf'
