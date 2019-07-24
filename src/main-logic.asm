;-----------------------------------------------
; Fundamentos de arquitectura de computadoras
; Uso de la consola para entrada/salida
; PHREDA - FASTA 2013
;-----------------------------------------------

format PE
entry main

section '.text' code readable executable

main:
	push	_hello
	call	[printf]
	add	esp, 4

	push	num1
	push	_format_input
	call	[scanf]
	add	esp, 8

	push	_prompt2
	call	[printf]
	add	esp, 4

	push	num2
	push	_format_input
	call	[scanf]
	add	esp, 8

	mov	eax, [num1]
	add	eax, [num2]
	shr	eax, 1

	push	eax
	push	_format_output
	call	[printf]
	add	esp, 8

	push	num1
	push	_format_input
	call	[scanf]
	add	esp, 8

	push	0
	call	[exit]
	ret

section '.data' data readable writeable

_hello		db "numero 1:",0
_prompt2	db "numero 2:",0
_format_input	db "%d",0
_format_output	db "Resultado= %d",10,0

num1		dd ?
num2		dd ?

section '.idata' data import readable

include "macro\import32.inc"

library msvcrt, "MSVCRT.DLL"

import msvcrt,\
       printf ,'printf',\
       scanf  ,'scanf',\
       exit   ,'exit'

