.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.equ RoutinePtr, EALiterals+0x00
.equ RoutineArg, EALiterals+0x04

@ Routine size: 0xA reeeeee wasted space reeeeee
CallWithArgument:
	push {lr}
	
	ldr r2, RoutineArg
	ldr r3, RoutinePtr
	
	mov lr, r3
	.short 0xF800
	
	pop {pc}

.ltorg
.align

EALiterals:
	@ POIN what
	@ WORD arg
