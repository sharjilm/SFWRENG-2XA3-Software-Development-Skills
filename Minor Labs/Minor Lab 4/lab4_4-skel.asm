%include "simple_io.inc"
   
global  asm_main

SECTION .data

arr1: dq 1,2,3,4,5,6,7,8,9,10
arr2: dq 11,12,13,14,15,16,17,18,19,20
err1: db "incorrect number of command line arguments",10,0
err2: db "incorrect command line argument",10,0

SECTION .bss

SECTION .text

; subroutine display_array
; expects one parameter on stack, either index 1 or 2
; it is assumed that the parameter is OK
; if the parameter is 1, the subroutine traverses the array
; arr1 and displays its entries separated by comma, e.g.
; 1,2,3,4,5,6,7,8,9,10
; if the parameter is 2, the subroutine traverses the array
; arr2 and displays its entries separated by comma, e.g.
; 11,12,13,14,15,16,17,18,19,20

display_array:
   ; enter the subroutine 
   ; save all registers

   ; get the parameter
   ; check if it is 1
   ; if so, set rbx to point to arr1, i.e. rxb=arr1
   ; otherwise set rbx to proint to arr2, i.e. rbx=arr2

  display:
   
   ; in a counting loop 
   ; traverse the first 9 items of the array pointed to by rbx
   ; display the item stored there using print_int
   ; display a comma using print_char


   ; when the loop is done
   ; display the 10th item of the array using print_int
   ; and finish the print line using print_nl
   
   ;restore all registers
   ;leave the subroutine
   ;return the control to the caller

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_main:
   ; enter subroutine
   ; save all registers

   ; get argc via rdi
   ; check it is 2
   ; it not display err1 and terminate asm_main

   ; get argv[1] via rsi
   ; get the first byte of argv[1] and store it in a register
   ; if it is '1' or '2' is it OK
   ; otherwise display err2 and terminate asm_main

   ; get the second byte of argv[1]
   ; if it is 0, it is OK
   ; otherwise display err2 and terminate asm_main

   ; hence the argument is correct 
	; turn the stored character '1' or '2' to a numnber by subtracting '0'
   ; push the numeric value of the argument on stack
   ; call display_array
   ; clean the stack


   ; restore all registers
   ; leave the subroutine
   ; return control
