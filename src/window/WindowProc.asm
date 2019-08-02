;;;
; The WindowProc callback. It is called by the windows api to handle window events
;
; params:
;     hwnd   - The window handler
;     wmsg   - The message
;     wparam - The w param of the message (depends of the message type)
;     lparam - The l param of the message (depends of the message type)
;
; returns: LRESULT - It varies depending on the type of the message
;;;
proc WindowProc uses rbx rsi rdi, hwnd,wmsg,wparam,lparam

	; compare the wmsg (edx) against each posible event type
	cmp	    edx,WM_DESTROY
	je	    .wmdestroy
	cmp     edx,WM_MOUSEMOVE
	je      .wmmousemove
	; cmp     edx,WM_LBUTTONUP
	; je      .wmmouseev
	; cmp     edx,WM_MBUTTONUP
	; je      .wmmouseev
	; cmp     edx,WM_RBUTTONUP
	; je      .wmmouseev
	; cmp     edx,WM_LBUTTONDOWN
	; je      .wmmouseev
	; cmp     edx,WM_MBUTTONDOWN
	; je      .wmmouseev
	; cmp     edx,WM_RBUTTONDOWN
	; je      .wmmouseev
	; cmp     edx,WM_KEYUP
	; je      .wmkeyup
	cmp     edx,WM_KEYDOWN
	je      .wmkeydown
	;cmp     edx,WM_EXITSIZEMOVE
	;je      .wmexitsizemove
	cmp     edx,WM_SIZE
	je      .wmexitsizemove

	.defwndproc:
	; if noone of the event types match, pass the event handling to the OS
	invoke	DefWindowProc,rcx,rdx,r8,r9
	ret

  	.wmmousemove:
	; transform the coordinate to x and y coordinate
	xor rax, rax
	xor rbx, rbx
	mov eax, r9d ; dword[lparam]
	mov ebx,eax
	shr eax,16
	and ebx,$ffff
	mov [_gr_mouse_x],rbx
	mov [_gr_mouse_y],rax
	ret

	.wmdestroy:
	invoke	PostQuitMessage,0
	xor	eax,eax
	ret

	.wmkeydown:
	fastcall InputOnKeyDown, r8
	xor eax, eax
	ret

	.wmexitsizemove:
	fastcall AppRecalculateWindowSize
	xor eax, eax
	ret

	.finish:
	ret

endp