;;;
; The WindowProc callback. It is called by the windows api to handle window events
;
; params:
;     hwnd - The window handler
;     wmsg - The message
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
	; cmp     eax,WM_LBUTTONUP
	; je      .wmmouseev
	; cmp     eax,WM_MBUTTONUP
	; je      .wmmouseev
	; cmp     eax,WM_RBUTTONUP
	; je      .wmmouseev
	; cmp     eax,WM_LBUTTONDOWN
	; je      .wmmouseev
	; cmp     eax,WM_MBUTTONDOWN
	; je      .wmmouseev
	; cmp     eax,WM_RBUTTONDOWN
	; je      .wmmouseev
	; cmp     eax,WM_KEYUP
	; je      .wmkeyup
	; cmp     eax,WM_KEYDOWN
	; je      .wmkeydown
	.defwndproc:
	; if noone of the event types match, pass the event handling to the OS
	invoke	DefWindowProc,rcx,rdx,r8,r9
	jmp	.finish

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
	jmp .finish

	.wmdestroy:
	invoke	PostQuitMessage,0
	xor	eax,eax

	.finish:
	ret

endp