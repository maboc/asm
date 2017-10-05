SECTION .data
	msg     db      'Rekentuig!', 0xa ;welkomst string + een LF
	l	equ	$-msg	     ;	lengte van de string
	n	db	10	     ;Hier willen we de faculteit van uitrekenen
 
SECTION .text
global  _start			;defineer het entrypoint
 
_start:
 
	mov     rax, 4		;syscall 4 : write naar stream
	mov	rbx, 1		;de stream is standard out
	mov     rcx, msg 	;adres van de string
	mov	rdx, l		;lengte van de te schrijven string
	int 	0x80		;voer de syscall uit

	xor 	rcx, rcx	;initialiseer de teller
loopje:
	inc	rcx	   ;de teller 1 ophogen
	mov	rax, 1		;initialiseer de te vermenigvuldigen waarde

	mul	rcx		;rdx:rax <= rax*rcx

	cmp	rcx, n		;Is rcx al gelijk aan n
	jb	loopje

	
einde:	
	mov	rax, 1		;syscall voor exit
	int	0x80		;roep de syscall aan
