.thumb

.equ SwitchingRoutine, EALiterals+0x00

SwitchConstant:
	bl SwitchingRoutine @ HAS to return 0 or 1
	
	lsl r0, #2 @ r0 = r0*4 = r0*sizeof(2 opcodes) // 2 opcodes because 1 mov & 1 b
	sub r0, #2 @ r0 = r0-2
	add pc, r0

	@ Case 0
	mov r0, #0
	b End
	
	@ Case 1
	mov r0, #0
	
End:
	bx lr

.ltorg
.align

EALiterals:
	@ Routine that returns the value we want
