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
include 'logic/NewString.asm'
include 'logic/PrintBinary.asm'
include 'logic/PrintString.asm'
include 'logic/StringToDecimal.asm'

main:
    sub	rsp, 8		; Make stack dqword aligned

;AGREGAR LEER NUMEROS SEPARADOS POR ESPACIOS

    fastcall PrintString, _numIn
 
    invoke scanf, _format_input, _lg_str

    fastcall PrintString, _lg_str_ok
    fastcall PrintString, _lg_line_bk

    fastcall StringToDecimal, _lg_str
    invoke printf, _format_d, rax
    ;fastcall PrintBinary, _lg_int
    fastcall PrintString, _lg_line_bk

	invoke exit
	ret

section '.data' data readable writeable

; Test
_numIn db "Numero: ", 0                       ; TEST
_format_output  TCHAR "El numero es ", 0      ; TEST
_format_input db "%s", 0                      ; TEST
_format_d db "%d", 0
; Strings
_lg_int dq ?                                  ; Integer
_lg_str rb 256                               ; Receives any string from main-graphic
_lg_str_ok  db "Ok", 10, 0                    ; 'Ok' string
_lg_line_bk db 10, 0                          ;  line break 
_lg_s0  db "0", 0                             ; '0' string
_lg_s1  db "1", 0                             ; '1' string

section '.idata' data import readable

    library msvcrt, "MSVCRT.DLL"

    import msvcrt,\
        printf ,'printf',\
        scanf  ,'scanf',\
        exit   ,'exit'
