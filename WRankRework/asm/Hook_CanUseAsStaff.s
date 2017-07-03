.thumb
.include "_Definitions.h.s"

.set GetUnitWeaponRank, EALiterals+0x00
.set ReturnOffset, (0x080167FA+1)

@ .org 0x167E4
HookFrom_167E4:
	@ CURRENT STATE:
		@ r2 = ROM Item Struct
		@ r3 = Unit Struct
		
		@ r0-r1 are free
	
	push {r4}
	
	@ r4 = WRank
	ldrb r4, [r2, #0x1C]
	
	@ ARG r1 = WType
	ldrb r1, [r2, #0x07]
	
	@ ARG r0 = Unit
	mov r0, r3
	
	ldr r3, GetUnitWeaponRank
	_blr r3
	
	cmp r0, r4
	blt ReturnFalse @ Return False if our unit doesn't have enough rank to use the weapon
	
	@ Return True
	
	mov r0, #1
	b End
	
ReturnFalse:
	mov r0, #0
	
End:
	pop {r4}
	
	ldr r3, =ReturnOffset
	bx r3

.ltorg
.align

EALiterals:
	@ POIN GetUnitWeaponRank
