.thumb

StateFlagCheck:
	ldr r0, [r1, #0xC]
	and r0, r2
	
	cmp r0, #0
	beq End
	
	mov r0, #1

End:
	bx lr

.ltorg
.align

EALiterals:
	@ none
