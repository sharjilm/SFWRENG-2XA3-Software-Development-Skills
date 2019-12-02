%include "simple_io.inc"
global  asm_main

SECTION .data

peg1: dq 0,0,0,0,0,0,3,4,9
peg2: dq 0,0,0,0,0,0,0,2,9
peg3: dq 0,0,0,0,0,0,0,1,9

SECTION .bss
N: resq 3

SECTION .text

line1:   ; subroutine line1 expects one address A on stack
         ; it uses three numbers, N1 stored at  address A, 
         ; N2 stored at address address A+72, and 
         ; N3 stored at address A+144
         ; all three numbers N1, N2, and N3 are expected to be
         ; OK and in the range 0..9
         ;
; line1 displays a line that is composed like this
; 12-N1 dots, N1 pluses, one |, N1 pluses, 12-N1 dots
; continued the same for N2 and continued the same for N3
;
; for instance if N1=9, N2=9, N3=9 the display will look likes this 
;...+++++++++|+++++++++......+++++++++|+++++++++......+++++++++|+++++++++...
;
; for instance if N1=4, N2=2, N3=1 the display will look likes this 
;........++++|++++..................++|++.....................+|+...........
;
; for instance if N1=3, N2=0, N3=0 the display will look likes this 
;.........+++|+++.....................|........................|............

   ; enter subroutine
   ; save all registers

   ; get address of N1
   ; get N1
   ; store it at N
   ; get address of N2
   ; get N2
   ; store it at N+8
   ; get address of N3
   ; get N3
   ; store it at N+16

   ; N is now array of size 3, N[0]=N1, N[1]=N2, N[2]=N3

   ; in a counting loop traverse the array N
   ; use rbx as the loop control, i.e. rbx=0,1, and 2
   ; use r12 as an address of the item of array N, i.e. r12=N,N+8,N+16
   
       ; compute 12-[r12]
       ; in a loop 1.. 12-[r12] display '.'             <-------------------+
                                                                            |
       ; in a loop 1..[r12] display '+'                 <----------------+  |      
                                                                         |  |
       ; display '|'                                                     |  |
                                                                         |  |
       ; in a loop 1..[r12] displayi                                     |  |
                               ; note you can cut and paste from above --+  |
                               ; just rename the labels                     |
                                                                            |
       ; compute 12-[r12] or use a stored one if you stored it previously   |
       ; in a loop 1.. 12-[r12] display '.'                                 |
                               ; note you can cut and paste from above -----+
                               ; just rename the labels
    
   ; bottom of the loop traversing N
   ; increment rbx by 1
   ; increment r12 by 8
   ; either back to the top of the loop or not

   ; restore all registers
   ; leave subroutine
   ; return control
   
asm_main:
   enter	0,0             ; setup routine
   saveregs              ; save all registers

   mov	rbx, peg1        
   add 	rbx, qword 64   ; this does 9, 9, 9
   ;add 	rbx, qword 56   ; this does 4, 2, 1
   ;add 	rbx, qword 48   ; this does 3, 0, 0

	push 	rbx			    ; push the address of N1, N2, N3
	call	line1
	add	rsp, 8          ; clean stack   
	
   
   restoregs             ; restore all registers
   leave                     
   ret
