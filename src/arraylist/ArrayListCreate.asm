;;;
; Creates a new new ArrayList of qwords and allocates memory. The list will have 
; an initial size. Each time a new item must be inserted, if the item
; does not fit in the allocated space, the current allocated space will be doubled
; and the item will be placed in the next place in the list.
; 
; params:
;   initialsize - The initial size of the ArrayList. CANNOT BE ZERO. 
;                 It is recomended to use powers of 2.
;
; return: (QWORD) A pointer to the ArrayList
;;;
proc ArrayListCreate, initialsize: DWORD
    local list: QWORD
    mov [initialsize], ecx

    invoke malloc, 16
    mov [list], rax

    mov ecx, [initialsize]
    mov DWORD[rax + 0], ecx       ; allocsize
    mov DWORD[rax + 4], 0         ; size
    shl ecx, 3
    invoke malloc, ecx
    mov rcx, [list] 
    mov QWORD[rcx + 8], rax        ; list

    mov rax, rcx
    ret
endp