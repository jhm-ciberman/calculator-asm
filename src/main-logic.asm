;-----------------------------------------------
; Arquitectura de Computadores I
; 
; Calculadora en Postfijo
;-----------------------------------------------


; + los dos valores al tope de la pila, los retira y luego apila el resultado.
; - resta los valores al tope de la pila
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
include 'parser/include.asm'
include 'commands/include.asm'
include 'conversion/include.asm'
include 'fakeconsole/include.asm'

main:
    sub	rsp, 8		; Make stack dqword aligned

    fastcall ArrayListCreate, 20
    mov [_lg_stack], rax
    
    fastcall ParserInit
    
    fastcall ParserParseString, _lg_str_user
    fastcall DoPrintStack

	invoke exit, 0
    xor rax, rax
	ret

section '.data' data readable writeable

include 'fakeconsole/data.asm'
include 'parser/data.asm'
include 'conversion/data.asm'

_lg_str_user db "100 101 102 103",0                    ; Receives any string from main-graphic
_lg_stack dq 0                                ; Pointer to Stack
_lg_debug db "hola!",0
_format_d db "%d",10,0

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
		strcmp, 'strcmp', \
		sprintf, 'sprintf'
