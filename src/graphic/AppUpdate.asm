proc AppUpdate
	local i:BYTE, j:BYTE, x: DWORD, y: DWORD
	fastcall DrawClear, $ff6d78a6

	; fastcall DrawPixel, [_gr_mouse_x], [_gr_mouse_y], $ffcfed09
	mov rax, [_gr_mouse_x]
	shr rax, 2

	mov rbx, [_gr_mouse_y]
	shr rbx, 2
	;fastcall InputBufferClear
	;fastcall InputBufferAddChar, 49
	;fastcall InputBufferAddChar, 50
	;fastcall InputBufferAddChar, 51
	;fastcall InputBufferAddChar, 51
	;fastcall InputBufferAddChar, 51
	;fastcall InputBufferAddChar, 51
	fastcall DrawPixelText, 0, 0, _gr_str_test, $ffffffff
	fastcall DrawPixelText, 0, 100, _gr_input_buffer, $ffffffff

	fastcall DrawPixelChar, 50+0, 50-16, 10, $ffff2f29
	fastcall DrawPixelChar, 50+8+2, 50-16, 3, $ffff2f29
	fastcall DrawPixelChar, 50+16+4, 50-16, 4, $ffff2f29
	fastcall DrawPixelChar, 50+24+6, 50-16, 5, $ffff2f29
	fastcall DrawPixelChar, 50+32+8, 50-16, 6, $ffff2f29

	fastcall DrawPixelChar, 50+0, 50, 49, $ffff2f29
	fastcall DrawPixelChar, 50+8+2, 50, 50, $ffff2f29
	fastcall DrawPixelChar, 50+16+4, 50, 51, $ffff2f29
	fastcall DrawPixelChar, 50+24+6, 50, 52, $ffff2f29
	fastcall DrawPixelChar, 50+32+8, 50, 53, $ffff2f29

	fastcall DrawPixelChar, 50+0, 50+16, 65, $ffff2f29
	fastcall DrawPixelChar, 50+8+2, 50+16, 66, $ffff2f29
	fastcall DrawPixelChar, 50+16+4, 50+16, 67, $ffff2f29
	fastcall DrawPixelChar, 50+24+6, 50+16, 68, $ffff2f29
	fastcall DrawPixelChar, 50+32+8, 50+16, 69, $ffff2f29

	.endwhile:

	;fastcall DrawRectangle, rax, rbx, 100, 20, $ffedcf09
    ret
endp