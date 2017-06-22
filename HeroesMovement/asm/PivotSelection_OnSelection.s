.thumb
.include "_Definitions.h.s"

.set ACTION_MOVEACTIVEUNIT, EALiterals+0x00

PivotSelection_OnSelection:
	push {r4, lr}
	
	@ r4 = Target Struct
	mov r4, r1
	
	@ [r0, r1] = [target.x, target.y]
	ldrb r0, [r4, #0]
	ldrb r1, [r4, #1]
	
	@ LOADING STUFF FROM UNIT STRUCT
	@ ------------------------------
	
	ldr r3, =ppActiveUnit
	ldr r3, [r3]
	
	ldrb r2, [r3, #0x10]
		sub r0, r2 @ r0 = direction.x = target.x - unit.x
		lsl r0, #1 @ r0 = direction.x*2
		add r0, r2 @ r0 = unit.x + direction.x*2
	
	ldrb r2, [r3, #0x11]
		sub r1, r2 @ r1 = direction.y = target.y - unit.y
		lsl r1, #1 @ r1 = direction.y*2
		add r1, r2 @ r1 = unit.y + direction.y*2
	
	@ r2 = target unit index (actually only used for animation)
	ldrb r2, [r4, #2]
	
	@ SAVING STUFF TO ACTION STRUCT
	@ -----------------------------
	
	ldr r3, =pActionStruct
	
	strb r0, [r3, #0x0E] @ Action xMove
	strb r1, [r3, #0x0F] @ Action yMove
	strb r2, [r3, #0x0D] @ Target Unit
	
	ldr r2, ACTION_MOVEACTIVEUNIT
	strb r2, [r3, #0x11] @ Action Index
	
	@ 0x02 = Kill Unit Selection, 0x04 = Beep Sound, 0x10 = Clear Unit Selection Gfx
	mov r0, #0x16
	
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ WORD ACTION_MOVEACTIVEUNIT
	