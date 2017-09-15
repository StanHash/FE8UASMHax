.thumb
.include "_Definitions.h.s"

.set lpraRoutineArray, (EALiterals+0x00)

@ Arguments: r0 = Popup 6C, r1 = Text Struct
DrawPopupComponents:
	push {r4-r7, lr}
	
	mov r4, r0
	mov r5, r1
	
	ldr r6, [r4, #0x2C]
	ldr r7, lpraRoutineArray
	
Loop:
	ldmia r6!, {r0, r2}
	
	cmp r0, #0
	beq End
	
	lsl r0, #2
	ldr r3, [r7, r0]
	
	cmp r3, #0
	beq Loop
	
	mov r0, r4 @ arg r0 = Popup 6C
	mov r1, r5 @ arg r1 = Text Struct
	           @ arg r2 = Argument
	
	bl BXR3
	
	b Loop

.ltorg

End:
	pop {r4-r7}
	
	pop {r3}
BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ POIN praRoutineArray
