.thumb

@ Routine size = 0xC + Getter Routine
AddStat:
	push {lr}
	
	mov r0, r1
	mov r1, r2
	mov r2, r3
	bl EALiterals

	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ Insert Getter
