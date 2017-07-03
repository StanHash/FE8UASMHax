.thumb
.include "_Definitions.h.s"

.set prItem_IsLocked, EALiterals+0x00

@ .org 0x17F20
AutolevelWRanks:
	push {r4-r6, lr}
	
	@ r4 = Unit Struct
	mov r4, r0
	
	_blh prUnit_GetItemCount
	sub r5, r0, #1 @ r5 = i
	
StartLoop:
	lsl r0, r5, #1 @ r0 = Item Index*2
	add r0, r4
	add r0, #0x1E
	
	@ r6 = Item Short
	ldrh r6, [r0]
	
	@ Getting item attributes
	mov r0, r6
	_blh prItem_GetAttributes
	
	mov r1, #0x5 @ WA_WEAPON | WA_STAFF
	
	tst r0, r1
	beq ContinueLoop @ If item isn't a weapon or staff, continue
	
	@ Checking if item is locked
	mov r0, r6
	mov r1, r4
	
	@ Call
	ldr r3, prItem_IsLocked
	_blr r3
	
	cmp r0, #0
	bne ContinueLoop @ If item is a prf, continue
	
	mov r0, r6
	_blh prItem_GetWType
	
	@ Loading unit class WRank
	ldr r1, [r4, #4]
	add r1, #0x2C
	add r1, r0
	ldrb r1, [r1]
	
	cmp r1, #0
	beq ContinueLoop @ If class cannot use weapon, continue
	
	@ r1 = &Unit.wRank[Item.wRank]
	add r1, r0, r4
	add r1, #0x28
	
	@ r0 = Item Short, r6 = &Unit.wRank[Item.wRank]
	mov r0, r6
	mov r6, r1
	
	@ r6 is now &Unit.wRank[Item.wRank]
	
	@ r0 = Item WRank
	_blh prItem_GetWRank
	
	@ r1 = Unit WRank
	ldrb r1, [r6]
	
	cmp r1, r0
	bge ContinueLoop @ If Unit WRank >= Item WRank, continue
	
	@ Storing item WRank
	strb r0, [r6]
	
ContinueLoop:
	sub r5, #1
	bge StartLoop
	
End:
	pop {r4-r6}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN prItem_IsLocked
