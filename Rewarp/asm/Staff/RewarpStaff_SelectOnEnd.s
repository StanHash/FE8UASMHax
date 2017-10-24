.thumb
.include "fe8.inc"

RewarpStaff_SelectOnEnd:
	push {lr}
	
	_blh Font_ResetAllocation
	_blh MoveRange_HideGfx
	_blh BottomHelpDisplay_EndAll
	
	ldr r3, =ppActiveUnit
	ldr r3, [r3]
	
	ldrb r0, [r3, #0x10] @ arg r0 = X Pos
	ldrb r1, [r3, #0x11] @ arg r1 = Y Pos
	
	_blh SetCursorMapPosition
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ nothing
