.thumb
.include "_Definitions.h.s"

@ Subcodes:
	@ 0 = LDR
	@ 1 = LDRH
	@ 2 = LDRB
	@ 3 = LDSH
	@ 4 = LDSB
	@ 8 = STR
	@ 9 = STRH
	@ A = STRB

Event_MemoryReadWrite:
	push {r4, lr}
	
	@ Read Event Cursor
	ldr r4, [r0, #0x38] @ r1 = Current Event Pointer
	
	@ r0 = Subcode
	ldrh r0, [r4]
	mov  r3, #0xF
	and  r0, r3
	
	@ r4 = Arguments
	ldrh r4, [r4, #2]
	
	@ r1 = (Short) & F
	mov r1, r4
	and r1, r3
	
	@ r2 = (Short >> 4) & F
	lsr r2, r4, #4
	and r2, r3
	
	@ r3 = (Short >> 8) & F
	lsr r4, #8
	and r3, r4
	
	@ r4 = Event Slot 0 Pointer
	ldr r4, =pEventSlot0
	
	@ r1 = Slot1
	lsl r1, #2
	add r1, r4
	
	@ r2 = [Slot2]
	lsl r2, #2
	ldr r2, [r4, r2]
	
	@ r3 = [Slot3]
	lsl r3, #2
	ldr r3, [r4, r3]
	
	@ r4 = SubSubcode (first 3 bits of subcode)
	mov r4, #0x7
	and r4, r0
	
	@ r1 = Value Slot
	@ r2 = Pointer Slot Value
	@ r3 = Offset Slot  Value
	
	@ If 4th bit of subcode, this is READ
	lsr r0, #3
	beq Case_Read

Case_Write:
	cmp r4, #0
	beq Case_SlotToWord
	
	cmp r4, #1
	beq Case_SlotToShort
	
	cmp r4, #2
	beq Case_SlotToByte
	
	b Finish
	
Case_Read:
	cmp r4, #0
	beq Case_WordToSlot
	
	cmp r4, #1
	beq Case_ShortToSlot
	
	cmp r4, #2
	beq Case_ByteToSlot
	
	cmp r4, #3
	beq Case_SShortToSlot
	
	cmp r4, #4
	beq Case_SByteToSlot
	
	b Finish
	
Case_WordToSlot:
	ldr r0, [r2, r3]
	str r0, [r1]
	b Finish

Case_ShortToSlot:
	ldrh r0, [r2, r3]
	str	 r0, [r1]
	b Finish

Case_ByteToSlot:
	ldrb r0, [r2, r3]
	str  r0, [r1]
	b Finish

Case_SShortToSlot:
	ldsh r0, [r2, r3]
	str  r0, [r1]
	b Finish

Case_SByteToSlot:
	ldsb r0, [r2, r3]
	str  r0, [r1]
	b Finish

Case_SlotToWord:
	ldr r0, [r1]
	str r0, [r2, r3]
	b Finish

Case_SlotToShort:
	ldr  r0, [r1]
	strh r0, [r2, r3]
	b Finish

Case_SlotToByte:
	ldr  r0, [r1]
	strb r0, [r2, r3]
	
Finish:
	mov r0, #0
	
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
