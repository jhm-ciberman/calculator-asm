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

format PE64
entry main

section '.text' code readable executable


include 'win64a.inc'
include "logic/NewString.asm"

main:
;	call ExitProcess
;	call [ExitProcess]
    invoke printf, _str
	invoke exit, 0

	ret

section '.data' data readable writeable

_foo db 10
_str db "Hola", 10

section '.idata' data import readable

library msvcrt, "MSVCRT.DLL"

import msvcrt,\
       printf ,'printf',\
       scanf  ,'scanf',\
       exit   ,'exit'

