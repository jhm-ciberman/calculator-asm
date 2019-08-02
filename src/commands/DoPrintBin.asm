proc DoPrintBin


    fastcall ArrayListPop, [_lg_stack]
    fastcall PrintBinary, rax

    fastcall ConsolePrintChar, 98 ; 'b' character
    fastcall ConsolePrintChar, 32 ; space character
    
    ret
endp
