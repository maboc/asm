SECTION .data
	msg     db      'Rekentuig!', 0xa ;welkomst string + een LF
	l	equ	$-msg	     ;	lengte van de string
	n	db	10	     ;Hier willen we de faculteit van uitrekenen
 
SECTION .text
global  _start			;defineer het entrypoint
 
_start:
 
	mov     eax, 4		;syscall 4 : write naar stream
	mov	ebx, 1		;de stream is standard out
	mov     ecx, msg 	;adres van de string
	mov	edx, l		;lengte van de te schrijven string
	int 	0x80		;voer de syscall uit

	mov	eax, 1		;initialiseer de te vermenigvuldigen waarde
	xor 	ecx, ecx	;initialiseer de teller
loopje:
	inc	ecx	   ;de teller 1 ophogen

	mul	ecx		;rdx:rax <= rax*rcx

	cmp	ecx, 10		;Is rcx al gelijk aan n
	jb	loopje

	
einde:	
	mov	eax, 1		;syscall voor exit
	int	0x80		;roep de syscall aan
