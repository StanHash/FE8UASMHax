.thumb
.include "_Definitions.h.s"

.set prUnit_CanStandOnPosition, EALiterals+0x00

Pivot_MakeTargetList:
	push {r4, lr}
	
	mov r4, r0 @ Unit
	
	@ Clearing Range Map
	bl ClearRangeMap
	
	ldrb r0, [r4, #0x10] @ x
	ldrb r1, [r4, #0x11] @ y
	
	@ Loading Address of routine to call
	adr r2, AddUnitToTargetListIfPivotable
	add r2, #1 @ Thumb bit
	
	_blh prForEachAdjacentUnit
	
	pop {r4}
	
	pop {r0}
	bx r0

.ltorg
.align

ClearRangeMap:
	push {lr}
	
	ldr r3, =ppRangeMapRows
	
	ldr r0, [r3]
	mov r1, #0
	
	_blh prMap_Fill
	
	pop {r0}
	bx r0

.ltorg
.align

AddUnitToTargetListIfPivotable:
	push {r4, lr}
	
	@ r4 = Target Unit Struct
	mov r4, r0
	
	@ Loading target position
	ldrb r1, [r4, #0x10] @ target.x
	ldrb r2, [r4, #0x11] @ target.y
	
	@ Loading target unit
	ldr r0, =ppActiveUnit
	ldr r0, [r0]
	
	ldrb r3, [r0, #0x10]
		sub r1, r3 @ r1 = direction.x = target.x - unit.x
		lsl r1, #1 @ r1 = direction.x*2
		add r1, r3 @ r1 = unit.x + direction.x*2
	
	ldrb r3, [r0, #0x11]
		sub r2, r3 @ r2 = direction.y = target.y - unit.y
		lsl r2, #1 @ r2 = direction.y*2
		add r2, r3 @ r2 = unit.y + direction.y*2
	
	@ Checking position, Arguments: r0 = unit, r1 = x, r2 = y
	ldr r3, prUnit_CanStandOnPosition
	_blr r3
	
	cmp r0, #0
	beq NoPivotSadface
	
	ldrb r0, [r4, #0x10] @ Unit.x
	ldrb r1, [r4, #0x11] @ Unit.y
	ldrb r2, [r4, #0x0B] @ Unit.id
	
	ldr r3, =prAddTargetListEntry
	mov lr, r3
	
	mov r3, #0 @ Trap id, probably irrelevant
	
	.short 0xF800
	
NoPivotSadface:
	pop {r4}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN prUnit_CanStandOnPosition
