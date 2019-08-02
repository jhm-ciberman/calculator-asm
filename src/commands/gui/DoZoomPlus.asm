proc DoZoomPlus
    
    mov eax, [_gr_pixel_scale_x]
    cmp eax, [_gr_pixel_scale_max]
    jge .error

    inc [_gr_pixel_scale_x]  
    inc [_gr_pixel_scale_y]
    fastcall AppRecalculateWindowSize
    ret

    .error:
    fastcall ConsolePrint, _gr_message_maximum_zoom
    ret
endp