
format PE64 GUI 5.0
entry start

include 'win64a.inc'

section '.text' code readable executable


  start:
	sub	rsp,8		; Make stack dqword aligned

    mov	[wc.cbSize],sizeof.WNDCLASSEX               ; The struct size
    mov	[wc.style],0                                ; Window Classs style
    mov	[wc.lpfnWndProc],WindowProc                 ; procedure to be called by windows to handle events
    mov	[wc.cbClsExtra],0                           ; The number of extra bytes to allocate following the window-class structure
    mov	[wc.cbWndExtra],0                           ; The number of extra bytes to allocate following the window instance
    mov	[wc.hInstance],NULL                         ; The hInstance windows instance handler (rcx is the 1st parameter)
    mov	[wc.hIcon],NULL                             ; The default icon
    mov	[wc.hCursor],NULL                           ; The default cursor
    mov	[wc.hbrBackground],COLOR_BTNFACE+1          ; Window class background
    mov	dword [wc.lpszMenuName],NULL                ; Window class menu name
    mov	dword [wc.lpszClassName],_gr_str_class      ; Window class name
	mov	[wc.hIconSm],NULL                           ; The default icon small

    invoke	GetModuleHandle,0
	mov	[wc.hInstance],rax                   ; The hInstance windows instance handler (rcx is the 1st parameter)


    ; Load the default icon (hIcon and hIconSm)
	invoke	LoadIcon,0,IDI_APPLICATION
	mov	[wc.hIcon],rax
	mov	[wc.hIconSm],rax

    ; Load the default arrow cursor (hCursor)
	invoke	LoadCursor,0,IDC_ARROW
	mov	[wc.hCursor],rax

	; Register the window class
	invoke	RegisterClassEx,wc
	test	rax,rax
	jz	error

	invoke	CreateWindowEx,0,_gr_str_class,_gr_str_title,WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU,128,128,512,256,NULL,NULL,[wc.hInstance],NULL
	test	rax,rax
	jz	error

  msg_loop:
	invoke	GetMessage,msg,NULL,0,0
	cmp	eax,1
	jb	end_loop
	jne	msg_loop
	invoke	TranslateMessage,msg
	invoke	DispatchMessage,msg
	jmp	msg_loop

  error:
	invoke	MessageBox,NULL,_gr_str_error,NULL,MB_ICONERROR+MB_OK

  end_loop:
	invoke	ExitProcess,[msg.wParam]

proc WindowProc uses rbx rsi rdi, hwnd,wmsg,wparam,lparam

; Note that first four parameters are passed in registers,
; while names given in the declaration of procedure refer to the stack
; space reserved for them - you may store them there to be later accessible
; if the contents of registers gets destroyed. This may look like:
;       mov     [hwnd],rcx
;       mov     [wmsg],edx
;       mov     [wparam],r8
;       mov     [lparam],r9

	cmp	edx,WM_DESTROY
	je	.wmdestroy
  .defwndproc:
	invoke	DefWindowProc,rcx,rdx,r8,r9
	jmp	.finish
  .wmdestroy:
	invoke	PostQuitMessage,0
	xor	eax,eax
  .finish:
	ret

endp

section '.data' data readable writeable

  _gr_str_title TCHAR 'Calculadora en PostFijo',0
  _gr_str_class TCHAR 'CALCWIN64',0
  _gr_str_error TCHAR 'Startup failed.',0

  wc WNDCLASSEX sizeof.WNDCLASSEX,0,WindowProc,0,0,NULL,NULL,NULL,COLOR_BTNFACE+1,NULL,_gr_str_class,NULL

  msg MSG

section '.idata' import data readable writeable

  library kernel32,'KERNEL32.DLL',\
	  user32,'USER32.DLL'

  include 'api\kernel32.inc'
  include 'api\user32.inc'
