.thumb
.include "_Definitions.h.s"

.set prGetTargetPosition,       EALiterals+0x00
.set prUnit_CanStandOnPosition, EALiterals+0x04

Reposition_MakeTargetList:
	push {r4, lr}
	
	mov r4, r0 @ Unit
	
	@ Clearing Range Map
	bl ClearRangeMap
	
	ldrb r0, [r4, #0x10] @ x
	ldrb r1, [r4, #0x11] @ y
	
	@ Loading Address of routine to call
	adr r2, AddUnitToTargetListIfRepositionable
	add r2, #1 @ Thumb bit
	
	_blh prForEachAdjacentUnit
	
	@ Clearing Range Map again to avoid range display glitches
	bl ClearRangeMap
	
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

AddUnitToTargetListIfRepositionable:
	push {r4, lr}
	
	@ r4 = Target Unit Struct
	mov r4, r0
	
	@ Loading active unit
	ldr r3, =ppActiveUnit
	ldr r3, [r3] @ ARG r0 = unit
	
	@ Loading unit position
	ldrb r1, [r3, #0x10] @ ARG r1 = unit.x
	ldrb r2, [r3, #0x11] @ ARG r2 = unit.y
	
	@ Getting potential target position in [r1, r2]
	ldr r3, prGetTargetPosition
	_blr r3
	
	@ Checking that position
	mov r0, r4 @ Target Unit
	ldr r3, prUnit_CanStandOnPosition
	_blr r3
	
	cmp r0, #0
	beq NoRepositionHA
	
	ldrb r0, [r4, #0x10] @ Unit.x
	ldrb r1, [r4, #0x11] @ Unit.y
	ldrb r2, [r4, #0x0B] @ Unit.id
	
	ldr r3, =prAddTargetListEntry
	mov lr, r3
	
	mov r3, #0 @ Trap id, probably irrelevant
	
	.short 0xF800
	
NoRepositionHA:
	pop {r4}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN prGetTargetPosition
	@ POIN prUnit_CanStandOnPosition
