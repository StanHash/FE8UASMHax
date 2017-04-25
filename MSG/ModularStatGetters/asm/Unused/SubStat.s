.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@ Routine size = 0x12 + Getter Routine
SubStat:
	push {r4, lr}
	
	mov r4, r0
	bl EALiterals
	sub r4, r0
	mov r0, r4
	
	pop {r4}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ Insert Value Getter
