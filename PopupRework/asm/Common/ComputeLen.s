.thumb
.include "_Definitions.h.s"

.set lpraRoutineArray, (EALiterals+0x00)

@ Arguments: r0 = Popup 6C
ComputePopupLen:
	push {r4-r7, lr}
	
	mov r4, r0
	
	ldr r5, [r4, #0x2C] @ r5 = popup def
	ldr r7, lpraRoutineArray
	
	mov r6, #0
	
Loop:
	ldmia r5!, {r0, r1}
	
	cmp r0, #0
	beq End
	
	lsl r0, #2
	ldr r3, [r7, r0]
	
	cmp r3, #0
	beq Loop
	
	mov r0, r4 @ arg r0 = Popup 6C
	           @ arg r1 = Argument 
	
	bl BXR3
	add r6, r0
	
	b Loop
	
.ltorg

End:
	mov r0, r6
	
	pop {r4-r7}
	
	pop {r3}
BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ POIN praRoutineArray
