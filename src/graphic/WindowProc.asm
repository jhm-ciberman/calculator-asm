;;;
; The WindowProc callback. It is called by the windows api to handle window events
;
; params:
;     hwnd - The window handler
;     wmsg - The message
;     wparam - ???
;     lparam - ???
;;;
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