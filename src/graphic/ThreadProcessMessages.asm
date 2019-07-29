;;;
; Thread message Handling. Handles all the incoming window messages of the thread and dispatch them 
; to the window. If the thread received an exit event, it closes the window.
;
; returns: (QWORD) 1 if all is ok. 0 if the app must be closed.
;;;
align 16
proc ThreadProcessMessages

    ; while loop
    .peekmessage:

    ;peek the next item in the thread message queue to check if there is any message to process
    invoke PeekMessage,_gr_msg,0,0,0,PM_NOREMOVE
	or	eax,eax
	jz	.return
	
    ; if there is a message, remove it from the queue
    invoke GetMessage,_gr_msg,0,0,0
	
    ; if the message is an WM_EXIT message, then exit the app 
    or	eax,eax
    jz	.endapp

    ; if not, translate the virtual keys asociated to the message 
    ; to real keys (in case the message is a keyboard input message)
	invoke TranslateMessage,_gr_msg

    ; And dispatch the message to the WindowProc
	invoke DispatchMessage,_gr_msg

    ; and repeat the while loop
    jmp .peekmessage

    .return:
    xor rax, rax
    inc rax
    ret

    .endapp:
    xor rax, rax
    ret
endp