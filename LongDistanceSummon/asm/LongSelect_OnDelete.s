.thumb
.include "_Definitions.h.s"

LongSelect_OnDelete:
	push {r4, lr}
	
	mov r4, r0
	
	ldr r0, =ppRangeMapRows
	ldr r0, [r0]
	mov r1, #0
	
	_blh prMap_Fill
	
	_blh prMoveRange_HideGfx
	_blh prBottomHelpDisplay_EndAll
	
	@ ldr r3, =ppActiveUnit
	@ ldr r3, [r3]

	@ ldrb r1, [r3, #0x10]
	@ ldrb r2, [r3, #0x11]

	@ mov r0, r4

	@ _blh prBeginCameraMovement

	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ notin
