# ArrayList example

```asm
local list:QWORD

; Create a new list with initial value of 5 
; (will be resized if necesary)
; returns a pointer to the list
fastcall ArrayListCreate, 5   
mov [list], rax

; Add some values
fastcall ArrayListPush, [list], 52
fastcall ArrayListPush, [list], 642
fastcall ArrayListPush, [list], 110
fastcall ArrayListPush, [list], 0
fastcall ArrayListPush, [list], -8555
fastcall ArrayListPush, [list], -10
fastcall ArrayListPush, [list], 20

fastcall ArrayListGetLast, [list]    ; last value      rax = 20
fastcall ArrayListSize, [list]       ; list size       eax = 7 
fastcall ArrayListGet, [list], 2     ; array[2]        rax = 110
fastcall ArrayListPop, [list]        ; pop last item   rax = 20
fastcall ArrayListSize, [list]       ; list size       eax = 6 
```