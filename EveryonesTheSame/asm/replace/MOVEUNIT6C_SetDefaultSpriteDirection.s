.thumb
.include "_Definitions.h.s"

.set prMMS_GetDefaultDirection, EALiterals+0x00

@ .org 0x0786BC
MOVEUNIT6C_SetDefaultSpriteDirection:
	push {r4, lr}
	
	@ r4 = MOVEUNIT 6C
	mov r4, r0
	
	add  r0, #0x41
	ldrb r0, [r0]
	
	ldr r3, prMMS_GetDefaultDirection
	_blr r3
	
	mov r1, r0
	mov r0, r4
	
	_blh prMOVEUNIT_SetSprDirection
	
	pop {r4}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN prMMS_GetDefaultDirection
