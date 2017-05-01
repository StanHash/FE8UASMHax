.thumb

.equ RoutineArray, EALiterals+0x00

SequenceLoop:
	push {r4-r6, lr}
	
	mov r4, r1 @ Save param 1
	mov r5, r2 @ Save param 2
	
	@ Shamelessly taken from FE8_calc_loop.asm
	mov r6, pc
	add r6, #(RoutineArray - OffsetSubtract)
OffsetSubtract:
	
	@ stat is r0
	
StartLoop:
	ldmia r6!, {r3}
	
	cmp r3, #0
	beq End
	
	mov r1, #1
	orr r3, r1 @ sets the last bit to 1, so that it calls thumb (calling arm would require using bx instead of bl?)
	
	@ r0 is already current stat value
	mov r1, r4 @ r1 = param 1
	mov r2, r5 @ r2 = param 2
	
	@ call modifier routine
	mov lr, r3
	.short 0xF800
	
	b StartLoop

End:	
	pop {r4-r6}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN to null terminated routine pointer array
