.thumb
.include "_Definitions.h.s"

.set pSaveRoutineList, EALiterals+0x00

SaveSuspendedData:
	push {r4-r7, lr}
	
	mov r4, r0
	
	ldr  r1, =pChapterDataStruct
	ldrb r1, [r1, #0x14] @ Difficulty byte
	
	mov r0, #0x8 @ 0b1000, probably "not saveable" bit
	
	tst r0, r1
	bne End
	
	@ Skipping checksum shenanigans
	
	mov r0, r4
	_blh prSaveData_GetSRAMLocation
	mov r4, r0
	
	ldr r7, =pGenericBuffer
	adr r6, pSaveRoutineList
	
ModuleLoop:
	ldmia r6!, {r5}
	
	cmp r5, #0
	beq End
	
	ldr r1, [r5, #0x04] @ Save Routine
	
	@ Calling Save Routine
	mov r0, r7
	bl BXR1
	
	ldr r2, [r5, #0x08] @ ARG r2 = Data Size
	
	cmp r2, #0
	beq ModuleLoop @ If size is 0, no reason to try saving anything
	
	mov r0, r7 @ ARG r0 = Input pointer (our buffer)
	mov r1, r4 @ ARG r1 = SRAM pointer
	
	add r4, r2 @ Advancing our SRAM cursor
	
	_blh prSaveData_SaveToSRAM
	b ModuleLoop
	
End:
	pop {r4-r7}
	
	pop {r1}
BXR1:
	bx r1

.ltorg
.align

EALiterals:
	@ List of module pointers

@ A SAVE MODULE:
	@ POIN LoadRoutine (args: r0 = pointer to input  buffer)
	@ POIN SaveRoutine (args: r0 = pointer to output buffer)
	@ WORD DataSize
