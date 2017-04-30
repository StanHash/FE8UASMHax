.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

Negate:
	neg r0, r0
	bx lr

.ltorg
.align

EALiterals:
	@ Insert Value Getter
