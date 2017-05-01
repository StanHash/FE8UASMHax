.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@ Routine size: 0x8 = 0x6 + literal (0x2)
GetWord:
	mov r0, #0
	ldr r0, [r1, r0] @ loading unit word
	bx lr

.ltorg
.align

EALiterals:
	@ none
