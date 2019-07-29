; strings
_gr_str_title             TCHAR 'Postfix calculator',0
_gr_str_error             TCHAR 'Startup failed.',0
_gr_str_console_start     TCHAR 175,32,0
_gr_str_console_cursor    TCHAR 219,0

; colours
_gr_col_primary       dd $ffff2222
_gr_col_secondary     dd $ff2074b0
_gr_col_text          dd $ffc0c0c0
_gr_col_muted         dd $ff808080
_gr_col_background    dd $ff222222

; layout
_gr_margin_bottom     db 11
_gr_margin_left       db 5

; Mouse coordinate (relative to the upper left corner of the window)
_gr_mouse_x        dq 0
_gr_mouse_y        dq 0

_gr_winbuffer      dq ?  ; A pointer to the main window real framebuffer (real window size)
_gr_appbuffer      dq ?  ; A pointer to the application virtual framebuffer (smaller)

; System time
_gr_system_time    SYSTEMTIME                       ; The current system time


include 'console/data.asm'
include 'window/data.asm'
include 'input/data.asm'
include 'draw/data.asm'

_gr_logo_w     dq 16
_gr_logo_h     dq 16
_gr_logo_data  file 'mario.bin':4