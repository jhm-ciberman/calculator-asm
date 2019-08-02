proc DrawPixelTextOutline, x:DWORD, y:DWORD, string:QWORD, innercolour:DWORD, outlinecolour:DWORD
    mov [x], ecx
    mov [y], edx
    mov [string], r8
    mov [innercolour], r9d

    ; draw text outline
    dec [x]
    dec [y]
	fastcall DrawPixelText, [x], [y], [string], [outlinecolour]
    inc [y]
	fastcall DrawPixelText, [x], [y], [string], [outlinecolour]
    inc [y]
	fastcall DrawPixelText, [x], [y], [string], [outlinecolour]

    inc [x]
	fastcall DrawPixelText, [x], [y], [string], [outlinecolour]
    dec [y]
    dec [y]
	fastcall DrawPixelText, [x], [y], [string], [outlinecolour]

    inc [x]
	fastcall DrawPixelText, [x], [y], [string], [outlinecolour]
    inc [y]
	fastcall DrawPixelText, [x], [y], [string], [outlinecolour]
    inc [y]
	fastcall DrawPixelText, [x], [y], [string], [outlinecolour]

	; draw text interior
    dec [x]
    dec [y]
	fastcall DrawPixelText, [x], [y], [string], [innercolour]

    ret
endp