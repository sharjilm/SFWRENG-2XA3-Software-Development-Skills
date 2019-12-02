%include "simple_io.inc"
   
global  asm_main

SECTION .data

msg1: db "incorrect number of command line arguments",0
msg2: db "inccorect length of the argument",0
msg3: db "inccorect first letter of the argument (should be an upper case letter)",0
msg4: db "inccorect second letter of the argument (should be 3 or 5 or 7 or 9)",0
msg5a: db "Displaying diagram of size ",0
msg5b: db " made of letters ",0

SECTION .bss

SECTION .text

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; subroutine display_line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expects three parameters on stack: letter, #of letters, #of spaces
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
display_line:
   enter 0,0             ; setup routine
   saveregs              ; save all registers

   mov r13, [rbp+16]     ; r13b is the letter
   mov r14, [rbp+24]     ; number of letters
   mov r15, [rbp+32]     ; number of spaces

   ;; r15 spaces, loop controled by rsi
   mov	rsi, qword 0
L1: 
	cmp 	rsi, r15
	jae 	L2
   mov 	al,' '
   call 	print_char
   inc 	rsi
   jmp L1
L2: 
   ;; r14 letters, loop contoled by rsi
	mov 	rsi, qword 0
L3: 
	cmp 	rsi, r14
   jae 	L4
   mov 	al, r13b 
   call 	print_char
   inc 	rsi
   jmp 	L3
L4: 
   call 	print_nl

display_line_end:
   restoregs
   leave
   ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; subroutine display_line ends
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; subroutine display_shape
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expects 3 parameters on stack: fake, size, letter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
display_shape:
   enter 0,0             ; setup routine
   saveregs              ; save all registers

   ;r12 is the size
   ;r13b is the letter
   ;r14 number of letters
   ;r15 number of spaces

	;; [rbp+16] is the fake param, ignored
   mov 	r12, [rbp+24]     ;r12 is the size
   mov 	r13, [rbp+32]     ;r13b is the letter

   ;; compute initial number of spaces
   xor 	edx, edx          ;blank edx register
   mov 	eax, r12d
   mov ebx, dword 2        ; We need edx for the DIV operation
   div ebx                 ; divide eax by ebx, and store the result in edx:eax
   ; hence eax holds the number
	mov	r15, rax		      ; initial number of spaces
   mov   r14, r12
	sub	r14, r15          ; initial number of letters

	;; loop till #of spaces=0
	;;      increasing #of letters=r14 by 1 
	;;      decreasing # of spaces=r15 by 1
D1:
	cmp	r15, qword 0
	je		D2
	push	r15	; the number of blanks
   push 	r14   ; the number of letters
   push 	r13   ; the letter
  	call 	display_line
   add 	rsp, qword 24  ; clean stack
 
   inc	r14            ; increment number of letters
   dec	r15            ; decrement number of spaces
	jmp D1
D2:
	push	r15	; the number of blanks
   push 	r14   ; the number of letters
   push 	r13   ; the letter
  	call 	display_line
   add 	rsp, qword 24  ; clean stack
   
display_shape_end:
   restoregs
   leave
   ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; subroutine display_shape end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; subroutine asm_main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_main:
	enter	0,0             ; setup routine
	saveregs

   ;; check argc=rdi, must be 2
   cmp rdi, qword 2
   je 	Check_length  ;; check length of argv[1]
   mov 	rax, msg1     ;; display argc error message
   call 	print_string
   call 	print_nl
   jmp 	asm_main_end

Check_length:  
   mov 	rcx, [rsi+8]  ;; address of argv[1]
   ;; first letter should not be NULL
   cmp 	byte [rcx],byte 0
   je 	Bad_length
   ;; the second letter should not be NULL
   cmp 	byte [rcx+1], byte 0
   je 	Bad_length
   ;; the third letter should be NULL
   cmp 	byte [rcx+2], byte 0
   jne 	Bad_length
   jmp 	Length_ok

Bad_length:
   mov 	rax, msg2
   call 	print_string
   call 	print_nl
   jmp 	asm_main_end

Length_ok:
   cmp 	byte [rcx],'A'
   jb 	Bad_first_letter
   cmp 	byte [rcx],'Z'
   ja 	Bad_first_letter
	mov	r13, qword 0
   mov 	r13b, byte [rcx]
   jmp 	Second_letter

Bad_first_letter:
   mov 	rax, msg3
   call 	print_string
   call 	print_nl
   jmp 	asm_main_end

Second_letter:
   inc	rcx
   cmp 	byte [rcx],'0'
   jb 	Bad_second_letter
   cmp 	byte [rcx],'9'
   ja 	Bad_second_letter
   ;; so the second letter is a digit
   cmp 	byte[rcx], '3'
   je 	Set_size
   cmp 	byte [rcx], '5'
   je 	Set_size
   cmp 	byte [rcx], '7'
   je 	Set_size
   cmp 	byte [rcx], '9'
   je 	Set_size

Bad_second_letter:
   mov 	rax, msg4
   call 	print_string
   call 	print_nl
   jmp 	asm_main_end  

Set_size:
	mov	rax, qword 0
   mov 	al, byte [rcx]
   sub 	al, '0'
   mov 	r12, rax

Arg_ok:
   push	r13           ; letter
   push 	r12           ; size
   sub	rsp, qword 8  ; fake
   call 	display_shape
   add 	rsp, qword 24

 asm_main_end:
   restoregs
   leave                     
   ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; subroutine asm_main end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
