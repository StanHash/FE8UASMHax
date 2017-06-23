.thumb
.include "_Definitions.h.s"

.set prUnit_CanStandOnPosition, EALiterals+0x00
.set prCanUnitSwapWith,         EALiterals+0x04

Pivot_MakeTargetList:
	push {r4, lr}
	
	mov r4, r0 @ Unit
	
	@ Clearing Range Map
	bl ClearRangeMap
	
	ldrb r0, [r4, #0x10] @ x
	ldrb r1, [r4, #0x11] @ y
	
	@ Loading Address of routine to call
	adr r2, AddUnitToTargetListIfSwappable
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

AddUnitToTargetListIfSwappable:
	push {r4, lr}
	
	@ r4 = Target Unit Struct
	mov r4, r0
		
	@ Routine that checks if two units can swap
	ldr r3, prCanUnitSwapWith
	
	cmp r3, #0
	beq SkipCheck
	
	@ Loading active unit
	ldr r0, =ppActiveUnit
	ldr r0, [r0] @ ARG r0 = unit
	
	mov r1, r4
	
	_blr r3
	
	cmp r0, #0
	beq NoSwappiswap
	
SkipCheck:
	@ TODO: write a routine like prUnit_CanStandOnPosition that ignores units
	
	@ Loading active unit
	@ ldr r0, =ppActiveUnit
	@ ldr r0, [r0] @ ARG r0 = unit
	
	@ Loading target position
	@ ldrb r1, [r4, #0x10] @ ARG r1 = target x
	@ ldrb r2, [r4, #0x11] @ ARG r2 = target y
	
	@ Can Active Unit Stand where Target is?
	@ ldr r3, prUnit_CanStandOnPosition
	@ _blr r3
	
	@ cmp r0, #0
	@ beq NoSwappiswap
	
	@ Loading active unit again
	@ ldr r0, =ppActiveUnit
	@ ldr r3, [r0]
	
	@ ARG r0 = unit
	@ mov r0, r4
	
	@ Loading target position
	@ ldrb r1, [r3, #0x10] @ ARG r1 = target x
	@ ldrb r2, [r3, #0x11] @ ARG r2 = target y
	
	@ Can Target Unit Stand where Active is?
	@ ldr r3, prUnit_CanStandOnPosition
	@ _blr r3
	
	@ cmp r0, #0
	@ beq NoSwappiswap
	
	ldrb r0, [r4, #0x10] @ Unit.x
	ldrb r1, [r4, #0x11] @ Unit.y
	ldrb r2, [r4, #0x0B] @ Unit.id
	
	ldr r3, =prAddTargetListEntry
	mov lr, r3
	
	mov r3, #0 @ Trap id, probably irrelevant
	
	.short 0xF800
	
NoSwappiswap:
	pop {r4}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN prUnit_CanStandOnPosition
	@ POIN prCanUnitSwapWith
