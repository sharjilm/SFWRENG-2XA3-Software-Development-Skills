%include "simple_io.inc"

global asm_main

section .data
  mes1: db "message 1",10,0
  mes2: db "message 2",0

section .text
  asm_main:	
	enter	0,0
	saveregs

	mov	rax, mes1        ; rax contains address of the string to be printed
	call	print_string

	mov	rax, mes2
	call	print_string

	mov	rax, mes2
	call	print_string
	call	print_nl

	mov	rax, qword 13    ; rax contains the 64 bit value to be printed as integer
	call	print_int
	call	print_nl

	mov	rax, 'H'         ; rax contains the 8 bit value to be printed as char
	call	print_char
	call	print_nl

        ;; alternative way to set the char
	xor	rax, rax         ; set rax to 0
	mov	al, 'O'          ; set al to 'O'
	call	print_char
	call	print_nl

	restoregs
	leave
	ret
