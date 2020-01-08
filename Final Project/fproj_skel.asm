%include "simple_io.inc"

global asm_main
extern rperm

section .data

section .bss
	array: resq 8

section .text

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_main:	
	enter	0,0
	saveregs

	mov	rdi, array     ;1st param for rperm
	mov	rsi, qword 8   ;2nd param for rperm
	call rperm

	;; now the array 'array' is randomly initialzed

	restoregs
	leave
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
