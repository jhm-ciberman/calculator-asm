;;;
; Sends the win buffer to the window device context
; It effectively draws the the content of the buffer on the window
;;;
proc WindowSurfaceFlush

    invoke SetDIBitsToDevice, \
		[_gr_dc], \               ; Device context 
		0,0, \                    ; Destination Position (x, y)
		[_gr_win_width],  \       ; Width
		[_gr_win_height], \       ; Width
		0,0, \                    ; The (x,y) coordinate of the lower-left corner of the image.
		0, \                      ; First scan line index
		[_gr_win_height], \       ; Number of scan lines
		[_gr_winbuffer], \        ; The colour data buffer
		_gr_bmi, \                ; A pointer to the BITMAPINFO structure
		0                         ; Colour type

    ret
endp