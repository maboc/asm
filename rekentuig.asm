SECTION .data
	msg     db      'Rekentuig!', 0xa ;welkomst string + een LF
	l	equ	$-msg	     ;	lengte van de string
 
SECTION .text
global  _start			;defineer het entrypoint
 
_start:
 
	mov     rax, 4		;syscall 4 : write naar stream
	mov	rbx, 1		;de stream is standard out
	mov     rcx, msg 	;adres van de string
	mov	rdx, l		;lengte van de te schrijven string
	int 	0x80		;voer de syscall uit

	mov	rax, 1		;syscall voor exit
	int	0x80		;roep de syscall aan
