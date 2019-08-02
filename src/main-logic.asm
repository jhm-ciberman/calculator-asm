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
    
    fastcall ParserInit
    
    fastcall ParserParseString, _lg_str_user

	invoke exit, 0
    xor rax, rax
	ret

section '.data' data readable writeable

include 'fakeconsole/data.asm'
include 'parser/data.asm'
include 'conversion/data.asm'

_lg_str_user db "100 101 + + + 102 103 . . . s.",0                    ; Receives any string from main-graphic
_gr_message_unknown           db 'Unknown command ', 34, 0
_gr_message_type_help         db 34, '. ',10,'Type help to see all commands',0
_gr_message_unexpected        db 'Error: Unexpected character ', 34, 0
_gr_message_at_input_string   db 34, ' at input string.', 0
_gr_message_empty_stack       db '[Empty stack]', 0

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
