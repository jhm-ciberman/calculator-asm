proc AppUpdate
    ; mov eax, [SYSXYM]
    ; mov ebx,eax
    ; shr eax,16
    ; and ebx,$ffff
    ; imul eax,XRES
    ; add eax,ebx
    ; mov [SYSFRAME+eax*4],$ffffff
    ret
endp