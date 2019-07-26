;;;
; The WindowProc callback. It is called by the windows api to handle window events
;
; params:
;     hwnd - The window handler
;     wmsg - The message
;     wparam - The w param of the message (depends of the message type)
;     lparam - The l param of the message (depends of the message type)
;;;
proc WindowProc uses rbx rsi rdi, hwnd,wmsg,wparam,lparam

	; compare the wmsg (edx) against each posible event type
	cmp	edx,WM_DESTROY
	je	.wmdestroy

	.defwndproc:
	; if noone of the event types match, pass the event handling to the OS
	invoke	DefWindowProc,rcx,rdx,r8,r9
	jmp	.finish

	.wmdestroy:
	invoke	PostQuitMessage,0
	xor	eax,eax

	.finish:
	ret

endp