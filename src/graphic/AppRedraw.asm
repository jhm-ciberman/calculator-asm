proc AppRedraw

    invoke SetDIBitsToDevice, \
		[_gr_dc], \               ; Device context 
		0,0, \                    ; Destination Position (x, y)
		APP_WIDTH,  \             ; Width
		APP_HEIGHT, \             ; Width
		0,0, \                    ; The (x,y) coordinate of the lower-left corner of the image.
		0, \                      ; First scan line index
		APP_HEIGHT, \             ; Number of scan lines
		_gr_framebuffer, \        ; The colour data buffer
		_gr_bmi, \                ; A pointer to the BITMAPINFO structure
		0                         ; Colour type

    ret
endp