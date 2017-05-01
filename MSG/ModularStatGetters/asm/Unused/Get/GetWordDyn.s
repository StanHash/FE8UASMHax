.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@ Routine size: 0x8 = 0x6 + literal (0x2)
GetWord:
	push {lr}
	
	bl EALiterals
	
	mov r1, #0
	ldr r0, [r0, r1] @ loading unit word
	
	pop {pc}

.ltorg
.align

EALiterals:
	@ Routine
