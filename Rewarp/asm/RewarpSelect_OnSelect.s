.thumb
.include "_Definitions.h.s"

.set ACTION_REWARP, EALiterals+0x00

RewarpSelect_OnSelect:
	push {r4, lr}

	mov r4, r0
	
	_blh #0x08003D20 @ Resets Font Struct
	
	@ ldr r0, =ppMoveMapRows
	@ ldr r0, [r0]
	
	@ lsl r3, r2, #2
	
	@ add r0, r3
	@ ldr r0, [r0]
	
	@ add r0, r1
	@ ldrb r0, [r0]
	
	@ cmp r0, #0xFF
	@ beq Err
	
	@ lsl r0, r1, #4
	@ add r0, #8
	
	@ lsl r1, r2, #4
	@ add r1, #8
	
	@ _blh #0x0807F858
	
	ldr r3, =pActionStruct
	
	strb r1, [r3, #0x13]
	strb r2, [r3, #0x14]
	
	ldr r0, ACTION_REWARP
	strb r0, [r3, #0x11]
	
	_blh prMoveRange_HideGfx
	_blh prBottomHelpDisplay_EndAll
	
	@ ldr r3, =ppActiveUnit
	@ ldr r3, [r3]
	
	@ ldrb r0, [r3, #0x10]
	@ ldrb r1, [r3, #0x11]
	
	@ _blh prSetCursorMapPosition
	
	ldr r3, =ppActiveUnit
	ldr r3, [r3]
	
	ldrb r1, [r3, #0x10]
	ldrb r2, [r3, #0x11]
	
	mov r0, r4
	
	_blh prBeginCameraMovement
	
	@ mov r0, #0x4
	mov r0, #0x06 @ Ends selection & Plays beep sound
	b End
Err:
	mov r0, #0x10 @ Plays gurr sound

End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ WORD ACTION_REWARP
