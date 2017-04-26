.thumb

CheckStatus:
	ldr r1, [r1, #0x30]
	
	mov r3, #0xF
	and r1, r3
	
	@ r1 is status id
	
	mov r0, #0
	
	cmp r1, r2
	bne End
	
	mov r0, #1

End:
	bx lr

.ltorg
.align

EALiterals:
	@ WORD attribute mask to check for
