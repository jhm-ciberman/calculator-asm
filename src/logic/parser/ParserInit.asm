proc ParserInit

    ; Create two parallel lists
    fastcall ArrayListCreate, 15
    mov [_lg_commands_list], rax
    fastcall ArrayListCreate, 15
    mov [_lg_commands_handlers], rax
    
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_add
    fastcall ArrayListPush, [_lg_commands_handlers], DoAdd
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_substract
    fastcall ArrayListPush, [_lg_commands_handlers], DoSubstract
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_multiply
    fastcall ArrayListPush, [_lg_commands_handlers], DoMultiply
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_divide
    fastcall ArrayListPush, [_lg_commands_handlers], DoDivide
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_remainder
    fastcall ArrayListPush, [_lg_commands_handlers], DoRemainder
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_or
    fastcall ArrayListPush, [_lg_commands_handlers], DoOr
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_and
    fastcall ArrayListPush, [_lg_commands_handlers], DoAnd
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_xor
    fastcall ArrayListPush, [_lg_commands_handlers], DoXor
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_not
    fastcall ArrayListPush, [_lg_commands_handlers], DoNot
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_neg
    fastcall ArrayListPush, [_lg_commands_handlers], DoNeg
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_print
    fastcall ArrayListPush, [_lg_commands_handlers], DoPrint
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_print_hex
    fastcall ArrayListPush, [_lg_commands_handlers], DoPrintHex
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_print_bin
    fastcall ArrayListPush, [_lg_commands_handlers], DoPrintBin
    fastcall ArrayListPush, [_lg_commands_list], _lg_command_print_stack
    fastcall ArrayListPush, [_lg_commands_handlers], DoPrintStack
    
    ret
endp