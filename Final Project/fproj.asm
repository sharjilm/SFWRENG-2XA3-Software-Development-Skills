%include "simple_io.inc"
global asm_main
extern rperm

SECTION .data
   array: dq 1,2,3,4,5,6,7,8
   prompt1: db "enter a,b to swap",10,0
   prompt2: db "0 to terminate: ",0
   a1: db "first coordinate not 1..8",10,0
   a2: db "comma not there",10,0
   a3: db "second coordinate not 1..8",10,0

SECTION .text

display:
   enter 0,0
   saveregs
   mov   rax, [array]
   call  print_int
   mov   al,','
   call  print_char
   mov   rax, [array+8]
   call  print_int
   mov   al,','
   call  print_char
   mov   rax, [array+16]
   call  print_int
   mov   al,','
   call  print_char
   mov   rax, [array+24]
   call  print_int
   mov   al,','
   call  print_char
   mov   rax, [array+32]
   call  print_int
   mov   al,','
   call  print_char
   mov   rax, [array+40]
   call  print_int
   mov   al,','
   call  print_char
   mov   rax, [array+48]
   call  print_int
   mov   al,','
   call  print_char
   mov   rax, [array+56]
   call  print_int
   call  print_nl
   restoregs
   leave
   ret 

asm_main:
   enter 0,0
   saveregs

   call  display

   mov   rdi, array
   mov   rsi, 8

   call  rperm

   call  display

prompt:
   mov   rax, prompt1
   call  print_string
   mov   rax, prompt2
   call  print_string

read:
   call  read_char
   cmp   al, '0'
   je    asm_main_end
   cmp   al, '1'
   jb    error1
   cmp   al, '8'
   ja    error1

   mov   r12, 0
   mov   r12b, al
   sub   r12b, '0'

   call  read_char
   cmp   al, ','
   jne   error2

   call  read_char
   cmp   al, '1'
   jb    error3
   cmp   al, '8'
   ja    error3

   mov   r13, 0
   mov   r13b, al
   sub   r13b, '0'
   
   mov   r14, array
LOOP1:
   cmp   [r14], r12
   je    LOOP2
   add   r14, 8
   jmp   LOOP1
LOOP2:
   mov   r15, array
LOOP3:
   cmp   [r15], r13
   je    LOOP4
   add   r15, 8
   jmp   LOOP3
LOOP4:
   mov   [r14], r13
   mov   [r15], r12

   call  display
   ;; empty input buffer
M1:
   cmp   al, 10
   je    M2
   call  read_char
   jmp   M1
M2:
   jmp   prompt

error1:
   call  print_nl
   mov   rax, a1
   call  print_string
   ;; empty input buffer
L1:
   cmp   al, 10
   je    L2
   call  read_char
   jmp   L1
L2:
   jmp   prompt

error2:
   call  print_nl
   mov   rax, a2
   call  print_string
   ;; empty input buffer
K1:
   cmp   al, 10
   je    K2
   call  read_char
   jmp   K1
K2:
   jmp   prompt

error3:
   call  print_nl
   mov   rax, a3
   call  print_string
   ;; empty input buffer
T1:
   cmp   al, 10
   je    T2
   call  read_char
   jmp   T1
T2:
   jmp   prompt

asm_main_end:
   restoregs
   leave
   ret
