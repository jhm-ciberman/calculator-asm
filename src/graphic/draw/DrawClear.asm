proc DrawClear uses rax  rdi rcx, colour
	mov eax,ecx                     ; value to fill (background colour)
	mov edi, _gr_framebuffer        ; the destination array (application surface)
	mov ecx,APP_WIDTH*APP_HEIGHT    ; The number of pixels to fill (x * y)
	rep stosd                       ; repeat for each pixel
	ret
endp