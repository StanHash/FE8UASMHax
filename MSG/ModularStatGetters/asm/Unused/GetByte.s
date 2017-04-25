.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@ Routine size: 0x8 = 0x6 + literal (0x2)
GetByte:
	mov r0, #0
	ldrb r0, [r1, r0] @ loading unit str
	bx lr

.ltorg
.align

EALiterals:
	@ none
