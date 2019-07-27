proc WindowDcInit
	; Gets the device context fot that window
	invoke GetDC,[_gr_whandle]
	mov [_gr_dc],rax

	; Init values for bitmap info struct 
	; this bitmap info struct is used to redraw the screen
	mov [_gr_bmi.biSize],sizeof.BITMAPINFOHEADER
	mov [_gr_bmi.biWidth],APP_WIDTH
	mov [_gr_bmi.biHeight],-APP_HEIGHT
	mov [_gr_bmi.biPlanes],1
	mov [_gr_bmi.biBitCount],32
	mov [_gr_bmi.biCompression],BI_RGB
	
    ret
endp