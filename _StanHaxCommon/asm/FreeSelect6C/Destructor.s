.thumb
.include "_Definitions.h.s"

FreeSelect6C_Destructor:
	push {r4, lr}
	
	mov r4, r0
	
	@ ldr r3, [r0, #0x2C]
	@ ldr r3, [r3, #0x04]
	
	@ cmp r3, #0
	@ beq NoCall
	
	@ bl BXR3
	
@ NoCall:
	@ ldr r0, [r4, #0x30]
	@ _blh prTCS_Free
	
	@ _blh prMoveRange_HideGfx

	pop {r4}
	
	pop {r3}
BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ noting
