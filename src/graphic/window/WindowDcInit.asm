;;;
; Initializes the device context for the window
; 
; param:
; 	winwidth  - The width of the client area in pixels
;   winheight - The height of the client area in pixels
;;
proc WindowDcInit, winwidth, winheight
	; Init values for bitmap info struct 
	; this bitmap info struct is used to redraw the screen
	mov [_gr_bmi.biSize],sizeof.BITMAPINFOHEADER
	mov [_gr_bmi.biWidth],ecx
	neg edx
	mov [_gr_bmi.biHeight],edx
	mov [_gr_bmi.biPlanes],1
	mov [_gr_bmi.biBitCount],32
	mov [_gr_bmi.biCompression],BI_RGB

	; Gets the device context fot that window
	invoke GetDC,[_gr_whandle]
	mov [_gr_dc],rax
    ret
endp