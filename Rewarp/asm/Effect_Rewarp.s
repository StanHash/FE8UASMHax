.thumb
.include "_Definitions.h.s"

.set prFreeSelect6C_New,   EALiterals+0x00
.set pRewarpFreeSelectDef, EALiterals+0x04

Effect_Rewarp:
	push {lr}
	
	ldr r0, pRewarpFreeSelectDef
	
	ldr r3, prFreeSelect6C_New
	_blr r3
	
	@ 0x01 = ???, 0x02 = Kill Menu, 0x04 = Beep Sound, 0x10 = Clear Menu Gfx
	mov r0, #0x17
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prFreeSelect6C_New
	@ POIN pRewarpFreeSelectDef
