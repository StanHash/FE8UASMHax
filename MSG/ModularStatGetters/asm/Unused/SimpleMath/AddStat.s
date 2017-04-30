.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@ Routine size = 0x10 + Getter Routine
AddStat:
	push {r4, lr}
	
	mov r4, r0
	bl EALiterals
	add r0, r4
	
	pop {r4}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ Insert Value Getter
