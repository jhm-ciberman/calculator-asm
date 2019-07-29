;;;
; Adds an item to the end of the list. If the item
; does not fit in the allocated space, the current allocated space will be doubled
; and the item will be placed in the next place in the list.
; If you want to store a value that uses more than 64 bits, you must pass a pointer 
; to that value
;
; params:
;   list  - A pointer to the list
;   value - The value to insert in the list
;;;
proc ArrayListPush, list:QWORD, value:QWORD
    mov [list], rcx
    mov [value], rdx
    
    mov eax, DWORD[rcx + 0]  ; allocsize
    mov edx, DWORD[rcx + 4]  ; size
    cmp edx, eax 
    jl .insert_item

    ; allocsize := allocsize * 2
    shl eax, 1 
    mov DWORD[rcx + 0], eax
    
    ; and allocate more memory
    ; array := realloc(array, allocsize * 8)
    shl eax, 3
    mov rdx, QWORD[rcx + 8]
    invoke realloc, rdx, eax
    mov rcx, [list]
    mov QWORD[rcx + 8], rax

    .insert_item:
    ; array[size] := value
    xor rdx, rdx
    mov edx, DWORD[rcx + 4]
    mov r9, [value]
    mov r8,  QWORD[rcx + 8]  ; array pointer
    mov QWORD[r8+rdx*8], r9

    ; size += 1
    inc edx                 
    mov DWORD[rcx + 4], edx


    ret
endp