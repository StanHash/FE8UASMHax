.thumb

.equ RoutineArrayPtr, EALiterals+0x00

@ call from whatever stat getter
CoreLoop:
	push {r4-r5, lr}
	
	mov r4, r0 @ r4 = unit struct ptr
	mov r0, #0 @ stat starts at 0
	
	ldr r5, RoutineArrayPtr
	
StartLoop:
	ldmia r5!, {r2}
	
	cmp r2, #0
	beq Finish
	
	@ r0 is already current stat value
	mov r1, r4 @ r1 = char struct ptr
	
	@ call modifier routine
	mov lr, r2
	.short 0xF800
	
	b StartLoop
	
Finish:
	@ Check if greater or equal to zero
	cmp r0, #0
	bge End
	
	mov r0, #0

End:	
	pop {r4-r5}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ null terminated routine pointer array
