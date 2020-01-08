%include "simple_io.inc"
global asm_main
extern rperm

SECTION .data
	size8levelfirst: db "..+------+", 0
        size8levelequals: db "  +------+", 0
        size8levelgreater: db "  +      +", 0
        size7levelfirst: db "..+-----+.", 0
        size7levelequals: db "  +-----+ ", 0
        size7levelgreater: db "  +     + ", 0
        size6levelfirst: db "...+----+.", 0
        size6levelequals: db "   +----+ ", 0
        size6levelgreater: db "   +    + ", 0
        size5levelfirst: db "...+---+..", 0
        size5levelequals: db "   +---+  ", 0
        size5levelgreater: db "   +   +  ", 0
        size4levelfirst: db "....+--+..", 0
        size4levelequals: db "    +--+  ", 0
        size4levelgreater: db "    +  +  ", 0
        size3levelfirst: db "....+-+...", 0
        size3levelequals: db "    +-+   ", 0
        size3levelgreater: db "    + +   ", 0
        size2levelfirst: db ".....++...", 0
        size2levelequals: db "     ++   ", 0
        size2levelgreater: db "     ++   ", 0
        size1levelfirst: db ".....+....", 0
        size1levelequals: db "	   +   ", 0
        size1levelgreater: db "	   +   ", 0

        emptystring: db "          ", 0

        fourspaces: db "    ", 0
        fivespaces: db "     ", 0

        entermsg: db "if you want to swap, enter a,b", 0
        endmsg: db "if you want to end, enter 0: ", 0
        donemsg: db "program done", 0
        errormsg: db "incorrect input, redo", 0
        swapmsg1: db "swappin box ", 0
        swapmsg2: db " with a box ", 0

SECTION .bss
	array: resq 8

SECTION .text

display:
        enter   0,0
        saveregs
        mov     rbx, [rbp + 16] 
        mov     rcx, [rbp + 24] 

        mov     r13, 8 
        jmp     displayline

displayline:
	mov     r12, [rcx] 
        add     rcx, 8  
        jmp     add2line

displaycheck:
	sub     rbx, 1 
        cmp     rbx, 0  
        je	linecheck
        jmp     displayline

linecheck:
        sub     r13, qword 1
        call    print_nl
        mov     rcx, array
        mov     rbx, qword 8
        cmp     r13, qword 0
        je	lastline
        jmp     displayline

lastline:
	mov     rax, fivespaces
        call    print_string
        mov     rax, [rcx]
        call    print_int
        mov     rax, fourspaces
        call    print_string
        add     rcx, 8
        sub     rbx, 1
        cmp     rbx, 0
        je	preread
        jmp     lastline

preread:
	call    print_nl
        jmp     read

add2line:
        cmp     r13, qword 1
        je	firstlevel
        cmp     r13, qword 1
        jg	betweenlevel
        jmp     lastline 

firstlevel:
	cmp     r12, qword 8
        je	s8lvl
        cmp     r12, qword 7
        je	s7lvl
        cmp     r12, qword 6
        je	s6lvl
        cmp     r12, qword 5
        je	s5lvl
        cmp     r12, qword 4
        je	s4lvl
        cmp     r12, qword 3
        je	s3lvl
        cmp     r12, qword 2
        je	s2lvl
        cmp     r12, qword 1
        je	s1lvl
        s8lvl:
                mov     rax, size8levelfirst
                call    print_string
                jmp     displaycheck                    
        s7lvl:
                mov     rax, size7levelfirst
                call    print_string
                jmp     displaycheck                    
        s6lvl:
                mov     rax, size6levelfirst
                call    print_string
                jmp     displaycheck                    
        s5lvl:
                mov     rax, size5levelfirst
                call    print_string
                jmp     displaycheck                    
        s4lvl:
                mov     rax, size4levelfirst
                call    print_string
                jmp     displaycheck                    
        s3lvl:
                mov     rax, size3levelfirst
                call    print_string
                jmp     displaycheck                    
        s2lvl:
                mov     rax, size2levelfirst
                call    print_string
                jmp     displaycheck                    
        s1lvl:
                mov     rax, size1levelfirst
                call    print_string
                jmp     displaycheck                    

betweenlevel:
	cmp     r12, r13
        je	equallevel
        cmp     r12, r13
        jg	greaterlevel
        mov     rax, emptystring
        call    print_string
        jmp     displaycheck                            

equallevel:
	cmp     r12, qword 8
        je	s8lvle
        cmp     r12, qword 7
        je	s7lvle
        cmp     r12, qword 6
        je	s6lvle
        cmp     r12, qword 5
        je      s5lvle
        cmp     r12, qword 4
        je      s4lvle
        cmp     r12, qword 3
        je      s3lvle
        cmp     r12, qword 2
        je      s2lvle
	cmp     r12, qword 1
        je	s1lvle
        s8lvle:
                mov     rax, size8levelequals
                call    print_string
                jmp     displaycheck                    
        s7lvle:
                mov     rax, size7levelequals
                call    print_string
                jmp     displaycheck                    
        s6lvle:
                mov     rax, size6levelequals
                call    print_string
                jmp     displaycheck                    
        s5lvle:
                mov     rax, size5levelequals
                call    print_string
                jmp     displaycheck                    
        s4lvle:
                mov     rax, size4levelequals
                call    print_string
                jmp     displaycheck                    
        s3lvle:
                mov     rax, size3levelequals
                call    print_string
                jmp     displaycheck                    
        s2lvle:
                mov     rax, size2levelequals
                call    print_string
                jmp     displaycheck                    
        s1lvle:
                mov     rax, size1levelequals
                call    print_string
                jmp     displaycheck                    

greaterlevel:
        cmp     r12, qword 8
        je	s8lvlg
        cmp     r12, qword 7
        je	s7lvlg
        cmp     r12, qword 6
        je	s6lvlg
        cmp     r12, qword 5
        je	s5lvlg
        cmp     r12, qword 4
        je	s4lvlg
        cmp     r12, qword 3
        je	s3lvlg
        cmp     r12, qword 2
        je	s2lvlg
        cmp     r12, qword 1
        je	s1lvlg
        s8lvlg:
                mov     rax, size8levelgreater
                call    print_string
                jmp     displaycheck                    
        s7lvlg:
                mov     rax, size7levelgreater
                call    print_string
                jmp     displaycheck                    
        s6lvlg:
                mov     rax, size6levelgreater
                call    print_string
                jmp     displaycheck                    
        s5lvlg:
                mov     rax, size5levelgreater
                call    print_string
                jmp     displaycheck                    
        s4lvlg:
                mov     rax, size4levelgreater
                call    print_string
                jmp     displaycheck                    
        s3lvlg:
                mov     rax, size3levelgreater
                call    print_string
                jmp     displaycheck                    
        s2lvlg:
                mov     rax, size2levelgreater
                call    print_string
                jmp     displaycheck                    
        s1lvlg:
                mov     rax, size1levelgreater
                call    print_string
                jmp     displaycheck                    

asm_main:
	enter  0,0
        saveregs
        mov     rdi, array     
        mov     rsi, qword 8   
        call    rperm
        
        push    qword 0
        push    array
        push    qword 8
        call    display

read:
	;enter  0,0
        ;saveregs
        mov     rax, entermsg
        call    print_string
        call    print_nl
        mov     rax, endmsg
        call    print_string

	 ;; empty input buffer
        L1:
                cmp   al, 10
                je    L2
                call  read_char
                jmp   L1
        L2:

        call    read_char
        cmp     al, '0'
        je	endprog
        cmp     al, '1'
        jl	errors
        cmp     al, '9'
        jge     errors

	mov     r12, 0
        mov     r12b, al
        sub     r12b, '0'

        call    read_char
        cmp     al, ','
        jne     errors

        call    read_char
        cmp     al, '1'
        jb      errors
        cmp     al, '8'
        ja      errors
        
	mov     r13, 0
	mov     r13b, al
        sub     r13b, '0'

        mov     r14, array
        jmp     LOOP1

LOOP1:
        cmp     [r14], r12
        je      LOOP2
        add     r14, 8
        jmp     LOOP1

LOOP2:
        mov     r15, array

LOOP3:
        cmp     [r15], r13
        je      LOOP4
        add     r15, 8
        jmp     LOOP3

LOOP4:
        ;enter   0,0
        ;saveregs
        mov     [r14], r13
        mov     [r15], r12
        mov     rax, swapmsg1
        call    print_string
        mov     rax, r12
        call    print_int
        mov     rax, swapmsg2
        call    print_string
        mov     rax, r13
        call    print_int
        call    print_nl
	push    qword 0
        push    array
        push    qword 8

	;; empty input buffer
        ;K1:
                ;cmp   al, 10
                ;je    K2
		;call  read_char
		;jmp   K1
	;K2:
		;jmp   read    

	;;call    display

endprog:
        mov     rax, donemsg
        call    print_string
        call    print_nl
        jmp     asm_main_end

errors:
        enter   0,0
        saveregs
        mov     rax, errormsg
        call    print_string
        call    print_nl
        push    qword 0
        push    array
        push    qword 8
       	call	display

	 ;; empty input buffer
        ;M1:
                ;cmp   al, 10
                ;je    M2
                ;call  read_char
                ;jmp   M1
        ;M2:
                ;jmp   read

asm_main_end:
        restoregs
        leave
        ret


