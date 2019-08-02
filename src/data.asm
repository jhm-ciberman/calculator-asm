include 'console/data.asm'
include 'draw/data.asm'
include 'io/data.asm'
include 'parser/data.asm'
include 'window/data.asm'
include 'conversion/data.asm'

; strings
_gr_str_title             TCHAR 'Postfix calculator. Type ',34, 'help', 34, ' to see all commands.', 0
_gr_str_error             TCHAR 'Startup failed.',0
_gr_str_console_start     TCHAR 175,32,0
_gr_str_console_cursor    TCHAR 219,0

_gr_str_help_url              TCHAR 'https://github.com/jhm-ciberman/calculator-asm/blob/master/README.md',0
_gr_message_showing_help      TCHAR 'Opening help in default web browser',0
_gr_message_unknown           TCHAR 'Unknown command ', 34, 0
_gr_message_type_help         TCHAR 34, '. ',10,'Type help to see all commands',0
_gr_message_byebye            TCHAR 'Bye bye! ',1,0
_gr_message_unexpected        TCHAR 'Error: Unexpected character ', 34, 0
_gr_message_at_input_string   TCHAR 34, ' at input string.', 0

_gr_str_cmd_clear         TCHAR 'clear',0
_gr_str_cmd_exit          TCHAR 'exit',0
_gr_str_cmd_help          TCHAR 'help',0

; colours
_gr_col_primary       dd $ffff2222
_gr_col_secondary     dd $ff2074b0
_gr_col_title         dd $ffffffff
_gr_col_text          dd $ffc0c0c0
_gr_col_muted         dd $ff808080
_gr_col_background    dd $ff222222

; layout
_gr_win_width         dd 0  ; The width of the client area of the window
_gr_win_height        dd 0  ; The height of the client area of the window
_gr_pixel_scale_x     dd 4
_gr_pixel_scale_y     dd 4
_gr_app_width         dd 0  ; The width of the app virtual buffer
_gr_app_height        dd 0  ; The height of the app virtual buffer
_gr_margin_bottom     db 5
_gr_margin_left       db 5

; Mouse coordinate (relative to the upper left corner of the window)
_gr_mouse_x        dq 0
_gr_mouse_y        dq 0

_gr_winbuffer      dq 0  ; A pointer to the main window real framebuffer (real window size)
_gr_appbuffer      dq 0  ; A pointer to the application virtual framebuffer (smaller)

; System time
_gr_system_time    SYSTEMTIME                       ; The current system time

_gr_logo_w     dd 16
_gr_logo_h     dd 16
_gr_logo_data  file 'mario.bin':4