.thumb
.include "_Definitions.h.s"

.set prUnit_GetBattleAnimPtr, EALiterals+0x00

Hook_GetUnitBattleAnimPtr:
	push {r1-r4}
	push {lr} @ This is for manually reputting it into lr
	
	ldr r4, prUnit_GetBattleAnimPtr
	_blr r4
	
	@ ldr r0, =#0x88AF060 @ General Animations
	
	pop {r1}
	mov lr, r1
	
	pop {r1-r4}
	
	bx lr

.ltorg
.align

EALiterals:
	@ POIN prUnit_GetBattleAnimPtr