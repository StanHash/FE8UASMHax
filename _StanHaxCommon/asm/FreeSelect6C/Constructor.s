.thumb
.include "_Definitions.h.s"

.set p6C_FreeSelect, EALiterals+0x00

FreeSelect6C_Constructor:
	push {r4, lr}
	
	mov r4, r0
	
	ldr r0, p6C_FreeSelect
	mov r1, #3
	
	_blh pr6C_New
	
	@ Storing routine list
	str r4, [r0, #0x2C]
	
	@ Loading init routine
	ldr r3, [r4, #0x00]
	
	cmp r3, #0
	beq End
	
	bl BXR3

End:
	pop {r4}
	
	pop {r3}
BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ POIN p6C_FreeSelect
