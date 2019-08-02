; Strings
_lg_command_add              db "+",0
_lg_command_substract        db "-",0
_lg_command_multiply         db "*",0
_lg_command_divide           db "/",0
_lg_command_remainder        db "%",0
_lg_command_or               db "or",0
_lg_command_and              db "and",0
_lg_command_xor              db "xor",0
_lg_command_not              db "not",0
_lg_command_neg              db "neg",0
_lg_command_print            db ".",0
_lg_command_print_hex        db ".h",0
_lg_command_print_bin        db ".b",0
_lg_command_print_stack      db "s.",0

_lg_commands_list     dq 0 ; List with all available commands strings
_lg_commands_handlers dq 0 ; List with the handlers asociated to each command

; String buffer used to store the numbers while parsing
_lg_buffer_str     rb 256
_lg_buffer_length  dq 0