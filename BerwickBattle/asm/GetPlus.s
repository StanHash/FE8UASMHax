.thumb
.include "fe8.inc"

.set EAL_WeaponPlusFlag, (EALiterals+0x00)

@ Arguments: r0 = Subject, r1 = Opponent
@ Returns:   r0 = Number of rounds the Subject can handle ("+ Modifier")
BWSB_GetPlus:
	push {r4, lr}
	
	ldr r0, [r0, #0x4C] @ Weapon Attributes
	ldr r1, EAL_WeaponPlusFlag
	
	tst r0, r1
	beq ReturnOne
	
	mov r0, #2
	b End
	
ReturnOne:
	mov r0, #1
	
End:
	pop {r4}
	
	pop {r3}
BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ WORD 
