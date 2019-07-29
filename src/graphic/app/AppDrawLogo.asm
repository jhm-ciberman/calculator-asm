proc AppDrawLogo

	fastcall DrawBufferScaled, _gr_logo_data, [_gr_logo_w], [_gr_logo_h], 75, 25, 3, 3

	; draw text outline
	fastcall DrawPixelText, 30-1, 80-1, _gr_str_title, [_gr_col_text]
	fastcall DrawPixelText, 30-1, 80+0, _gr_str_title, [_gr_col_text]
	fastcall DrawPixelText, 30-1, 80+1, _gr_str_title, [_gr_col_text]
	fastcall DrawPixelText, 30+0, 80+1, _gr_str_title, [_gr_col_text]
	fastcall DrawPixelText, 30+0, 80-1, _gr_str_title, [_gr_col_text]
	fastcall DrawPixelText, 30+1, 80-1, _gr_str_title, [_gr_col_text]
	fastcall DrawPixelText, 30+1, 80+0, _gr_str_title, [_gr_col_text]
	fastcall DrawPixelText, 30+1, 80+1, _gr_str_title, [_gr_col_text]

	; draw text interior
	fastcall DrawPixelText, 30, 80, _gr_str_title, [_gr_col_secondary]

    ret
endp