.thumb

.equ ParentCheck, EALiterals+0x00

NotCheck:
	push {lr}
	
	@ Calling parent check
	bl ParentCheck
	
	@ r0 = (!r0) = (r0 ^ 0x1)
	mov r1, #1
	eor r0, r1
	
End:
	pop {pc}

.ltorg
.align

EALiterals:
	@ WORD attribute mask to check for
