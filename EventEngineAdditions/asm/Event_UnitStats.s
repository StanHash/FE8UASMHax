.thumb
.include "_Definitions.h.s"

@ THE PLAN:
@ UNIT_SET_STATS <Char> <Stat Pointer> @ SHORT 0xID40 <Char>; POIN <Stat Pointer>
@ UNIT_SET_STATS_SLOT3 <Char>          @ SHORT 0xID21 <Char>
@ UNIT_SET_<STAT> <Char> <Value>       @ SHORT (0xID28 + <STAT>) <Char>; WORD <Value>

Event_UnitStats:
	push {r4-r5, lr}
	
	mov r4, r0 @ r4 = Event Engine 6C
	
	ldr r1, [r4, #0x38] @ r1 = Current Event Pointer
	
	ldrh r0, [r1]

	mov r2, #0xF
	and r0, r2
	
	lsr r2, r0, #3
	beq NoIndividualStat
	
	mov r0, r4
	bl Event_UnitSetStat
	b End
	
NoIndividualStat:
	cmp r0, #0
	beq NoLoadFromSlot3
	
	ldr r0, =pEventSlot0
	ldr r5, [r0, #(3 * 4)] @ 3 * sizeof(Slot)
	
	b EndLoad
	
NoLoadFromSlot3:
	ldr r5, [r1, #4]
	
EndLoad:
	ldrh r0, [r1, #2]
	_blh prUnit_GetFromEventParam
	
	mov r4, r0 @ r4 = Unit
	beq End @ Goto End if no Unit
	
	mov  r1, #0
	ldsb r1, [r5, r1] @ Load HP
	strb r1, [r4, #0x12] @ Unit Max HP
	
	@ r0 = Unit
	@ r1 = HP
	
	_blh #0x08019368 @ SetUnitHP
	
	mov r3, #5 @ 6 Stats to set: Pow, Skl, Spd, Def, Res, Lck
	
	add r5, #1 @ r5 = Stat Source
	mov r1, r4
	add r1, #0x14 @ r1 = Unit Stats
	
ContinueStatSet:
	ldsb r0, [r5, r3] @ Load Stat (Signed)
	strb r0, [r1, r3] @ Store Stat

	sub r3, #1
	bge ContinueStatSet
	
	mov r0, r4
	_blh #0x080181C8 @ Check for Stat caps
	
End:
	mov r0, #0 @ Advance & Continue
	
	pop {r4-r5}
	
	pop {r1}
	bx r1

.ltorg
.align

Event_UnitSetStat:
	push {r4-r6, lr}
	
	ldr r1, [r4, #0x38] @ r1 = Current Event Pointer
	
	ldrh r0, [r1]
	
	mov r5, #0x7
	and r5, r0 @ r5 = Which stat to modify
	
	ldr r6, [r1, #4] @ r6 = Stat Value
	
	cmp r6, #0
	bge UnitSetStat_NotLoadFromSlot3
	
	ldr r0, =pEventSlot0
	ldr r6, [r0, #(3 * 4)] @ 3 * sizeof(Slot)
	
UnitSetStat_NotLoadFromSlot3:
	ldrh r0, [r1, #2]
	_blh prUnit_GetFromEventParam
	
	cmp r0, #0
	beq UnitSetStat_Return @ Return if no Unit
	
	cmp r5, #0 @ HP
	bne UnitSetStat_NotHP
	
	mov  r1, r6
	strb r1, [r0, #0x12] @ Unit Max HP
	
	@ r0 = Unit
	@ r1 = HP
	
	_blh #0x08019368 @ SetUnitHP
	
	b UnitSetStat_Return
	
UnitSetStat_NotHP:
	@ r6 is Value
	@ r5 is Stat
	@ r0 is Unit
	
	mov r1, r0
	add r1, #0x13
	
	strb r6, [r1, r5]
	
	_blh #0x080181C8 @ Check for Stat caps
	
UnitSetStat_Return:
	mov r0, #0
	
	pop {r4-r6}
	
	pop {r1}
	bx r1

EALiterals:
	@ nothing
