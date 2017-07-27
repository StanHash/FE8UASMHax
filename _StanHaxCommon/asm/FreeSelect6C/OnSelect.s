.thumb
.include "_Definitions.h.s"

FreeSelect6C_OnSelect:
	push {lr}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ noting
