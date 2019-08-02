proc DoZoomMinus
    
    mov eax, [_gr_pixel_scale_x]
    cmp eax, [_gr_pixel_scale_min]
    jle .error

    dec [_gr_pixel_scale_x]  
    dec [_gr_pixel_scale_y]
    fastcall AppRecalculateWindowSize
    ret

    .error:
    fastcall ConsolePrint, _gr_message_minimum_zoom
    ret
endp