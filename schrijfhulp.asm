global	print_string, print_integer, print_crlf	;externalize functions

SECTION .text
	;; ---------------------------------------------------------------------------
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
	pop	rax		;en rax weer terug halen
	
	ret			;terug naar de aanroepende functie

	;; ---------------------------------------------------------------------------
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

	;; ---------------------------------------------------------------------------
	;; Print een integer
	;; de te printen waarde wordt in eax verwacht
print_integer:
	push	rbx 		;Dan eerst even de veranderende registers opslaan
	push	rdx
	push 	rcx
	push	rsi
	
	;; eerst de integer afbreken tot afzonderlijke digits
	mov	ebx, 10		;de divisor
	xor	esi, esi	;de teller voor deze taak
deel_loop:	
	xor	edx, edx	;edx nul maken

	div 	ebx		;edx:eax / ebx =>edx rest eax; quotient

	push	rdx		;plaats de rest op de stack
	inc	esi

	cmp	eax, 0x0	;is het quotient al 0?
	jz	print_loop	;als eax 0 is kunnen we gaan printen
	jmp	deel_loop	;en ander doen we het gewoon nog een keer

print_loop:	
	mov	eax, 0x4	;syscall voor schrijven naar stream
	mov	ebx, 0x1	;schrijven naar de std. out
	pop	rcx		;haal een cijfer van de stack
	add	ecx, 0x30	;0x30 erbij om er een leesbaar cijfer van te maken (zie een ascii tabel)
	mov	[teprinten], ecx ;De waarde van crlf wordt de huidige waarde van ecx
	mov	ecx, teprinten	 ;ecx krijgt het adres van teprinten
	mov	edx,1		 ;lengte van teprinten is 1
	int	0x80		;voer de syscall uit

	dec	esi		;teller eentje minder
	cmp	esi, 0		;is esi al 0
	ja	print_loop	;kennelijk zijn we er nog niet...nog een keer

	
	pop	rsi
	pop	rcx
	pop 	rdx
	pop	rbx		;En de veranderde register terughalen
	ret			;en terug naar de aanroepende funtie

	;; ---------------------------------------------------------------------------
	;; functie print een LF en een CR (gemaks functie)
	;; er wordt geen input verwacht
print_crlf:
	push	rax	    	;opslaan van de registers
	push	rdi

	mov	eax, crlf	;lets print a cr and a lf
	;;  mov	di, crlf	adres van crlf in es:di
	lea 	eax, [crlf]
	mov	edi, eax
	mov	al, 0xa		;lf in al
	stosb			;opslaan in crlf
	mov	al, 0xd		;cr in al
	stosb			;opslaan in crlf

	mov	rax, crlf	;en nog maar eens het adres van de stirng in rax
	call 	print_string	;do it...print

	pop	rdi
	pop	rax		;terug zetten van de registers
	
	ret			;en weer terug


SECTION .data
	teprinten	db 0		;de te printen string
	crlf		db 10, 13,0	;een lf en een cr (zie ascii)
	
