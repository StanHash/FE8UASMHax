.thumb
.include "fe8.inc"

.set EAL_pFreeSelectDef,  (EALiterals+0x00)
.set EAL_prNewFreeSelect, (EALiterals+0x04)

RewarpStaff_Targetting:
	push {r4, lr}
	
	mov r4, r0 @ var r4 = Unit
	
	_blh MoveRange_HideGfx
	
	@ Clearing Range Map
	
	ldr r0, =ppRangeMapRows
	ldr r0, [r0] @ arg r0 = pointer to row array
	
	mov r1, #0   @ arg r1 = fill value
	
	_blh Map_Fill
	
	@ Clearing Movement Map
	
	ldr r0, =ppMoveMapRows
	ldr r0, [r0] @ arg r0 = pointer to row array
	
	mov r1, #1
	neg r1, r1   @ arg r1 = fill value
	
	_blh Map_Fill
	
	@ Setting up Movement Map
	
	ldrb r0, [r4, #0x10] @ arg r0 = Center X
	ldrb r1, [r4, #0x11] @ arg r1 = Center Y
	
	mov r2, #1           @ arg r2 = Min Range
	mov r3, #10          @ arg r3 = Max Range
	
	_blh Map_IncRange, r4
	
	mov r0, #1
	
	_blh MoveRange_ShowGfx
	
	ldr r0, EAL_pFreeSelectDef
	ldr r1, EAL_prNewFreeSelect
	
	bl BXR1
	
	pop {r4}
	
	pop {r1}
BXR1:
	bx r1

.ltorg
.align

EALiterals:
	@ POIN pFreeSelectDef
	@ POIN prNewFreeSelect
