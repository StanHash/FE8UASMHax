.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@ Routine size: 0xA AAAA uneven
Call:
	push {r4, lr}
	
	ldr r4, EALiterals
	mov lr, r4
	.short 0xF800
	
	pop {r4, pc}

.ltorg
.align

EALiterals:
	@ none
