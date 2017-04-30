.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

@ Routine size = 0xC + Getter Routine
AddStat:
	push {lr}
	
	mov r0, r1
	blh 0x08016B28 @ GetUnitEquippedWeapon
	bl EALiterals

	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ Insert Getter
