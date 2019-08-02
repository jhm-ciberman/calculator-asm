; Input
_gr_input_buffer       rb 256                       ; Max input = 255
_gr_input_char_count   db 0                         ; Current character count

; Output
_gr_output_buffer      rb 65535                     ; Max output = 65535
_gr_output_char_count  dw 0                         ; Current character count

