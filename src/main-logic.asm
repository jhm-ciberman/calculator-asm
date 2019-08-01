;-----------------------------------------------
; Arquitectura de Computadores I
; 
; Calculadora en Postfijo
;-----------------------------------------------


; + los dos valores al tope de la pila, los retira y luego apila el resultado.-resta los valores al tope de la pila
; * multiplica los valores
; / divide los valores (resultado entero)
; % obtiene el resto de la division
; OR realiza el OR logico.
; AND realiza en AND logico.
; XOR realiza el or exclusivo
; NOT realiza el not al tope de la pila
; NEG niega el tope de la pila
;
; .  imprime en consola el tope de la pila en decimal consumiendolo
; .h imprime en consola el tope pero en hexadecimal
; .b imprime el tope en binarios
; . imprime la pila completa en la consola primero el tope de la pila y ultimo el primer valor
; .exit Cierra el programa

format PE64 console
entry main

section '.text' code readable executable

include 'win64a.inc'
include 'arraylist/include.asm'
include 'logic/NewString.asm'
include 'logic/PrintBinary.asm'
include 'logic/PrintString.asm'
include 'logic/StringToDecimal.asm'
include 'logic/BufferAdd.asm'
include 'logic/BufferFinish.asm'
include 'logic/ParseString.asm'
include 'logic/StackPrint.asm'

main:
    sub	rsp, 8		; Make stack dqword aligned

    fastcall ArrayListCreate, 20
    mov [_lg_stack], rax

    fastcall ParseString, _lg_str_user
    fastcall StackPrint

	invoke exit, 0
    xor rax, rax
	ret

section '.data' data readable writeable

; Test
_numIn db "Numero: ", 0                       ; TEST
_format_output  TCHAR "El numero es ", 0      ; TEST
_format_input db "%[^\n]", 0                  ; TEST
_format_s db "%s", 0                          ; TEST
_format_d db "%d", 10, 0                          ; TEST

; String buffer used to store the numbers while parsing
_lg_buffer_str     rb 256
_lg_buffer_length  dq 0

; Strings
_lg_int dq ?                                  ; Integer


_lg_str_user db "256 100 20",0                               ; Receives any string from main-graphic
_lg_str_ok  db "Ok", 10, 0                    ; 'Ok' string
_lg_line_bk db 10, 0                          ;  line break 
_lg_s0  db "0", 0                             ; '0' string
_lg_s1  db "1", 0                             ; '1' string
_lg_sA  db "PointA", 10, 0
_lg_sB  db "PointB", 10, 0
_lg_sC  db "PointC", 10, 0
;Stack
_lg_stack dq 0                                ; Pointer to Stack

section '.idata' data import readable

    library msvcrt, "MSVCRT.DLL"

    import msvcrt,\
        printf ,'printf',\
        scanf  ,'scanf',\
        exit   ,'exit',\
		malloc, 'malloc', \
		realloc, 'realloc', \
		strcpy, 'strcpy', \
		free, 'free', \
		strcmp, 'strcmp'
