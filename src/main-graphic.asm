
format PE64 GUI 5.0
entry start

include 'win64a.inc'

section '.text' code readable executable


include 'graphic/CreateWindow.asm'
include 'graphic/WindowProc.asm'

start:
	sub	rsp,8		; Make stack dqword aligned
	call CreateWindow

	test rax, rax
	jz .error

  	.msg_loop:
	invoke	GetMessage,_gr_msg,NULL,0,0
	cmp	eax,1
	jb	.end_loop
	jne	.msg_loop
	invoke	TranslateMessage,_gr_msg
	invoke	DispatchMessage,_gr_msg
	jmp	.msg_loop

  	.error:
	invoke	MessageBox,NULL,_gr_str_error,NULL,MB_ICONERROR+MB_OK

  	.end_loop:
	invoke	ExitProcess,[_gr_msg.wParam]

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
