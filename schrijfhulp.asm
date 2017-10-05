global	print_string		;externalize print_string

	;; telt de lengte van een zero-terminated string
	;; Ik verwacht het adres van de string in eax
	;; Bij terugkeer staat in edx de lengte van de string
strlen:
	push	rax		;voor de zekerheid rax maar opslaan
	xor	edx, edx	;edx initialiseren als 0
teller:	
	cmp	byte [eax], 0x0	;is eax 0?
	jz	terug		;kennelijk zijn we klaar
	inc	edx		;nog geen nul...edx 1 ophogen
	inc	eax		;dan eax maar eentje ophogen
	jmp	teller		;en nog een rondje
	
terug:				;we kunnen ons herstellen en terug naar de aanroepende functie. EDX is nu gevuld met de lengte van de string
	pop	rax		;en rx weer terug halen
	
	ret			;terug naar de aanroepende functie

	;; printing zero-terminated strings naar std out
	;; ik verwacht het adres van een zero-terminated string in eax
print_string:
	push	rax		;voor de zekerherid rax maar even bewaren
	push	rbx
	push	rcx
	push 	rdx

	mov	ebx, 0x1	;we printen naar standaard out
	mov 	ecx, eax	;ecx is nu het adres van de string
	call	strlen		;bij terugkeer heeft edx de lengte van de string
	mov	eax, 0x4	;system call voor schrijven

	int	0x80		;voer de call uit

	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax		;en rax weer terug van de stack
	
	ret			;en terug naar de aanroeper
