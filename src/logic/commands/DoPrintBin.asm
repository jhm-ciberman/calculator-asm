proc DoPrintBin

    fastcall ArrayListPop, [_lg_stack]
    fastcall PrintBinary, rax
    
    ret
endp
