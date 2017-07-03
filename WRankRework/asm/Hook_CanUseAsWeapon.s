.thumb
.include "_Definitions.h.s"

.set GetUnitWeaponRank, EALiterals+0x00
.set ReturnOffset, (0x08016748+1)

@ .org 0x16738
HookFrom_16738:
	@ CURRENT STATE:
		@ r0 = Unit Struct
		@ r1 = Weapon Type
		@ r2 = Weapon Rank
		
		@ r3-r5 are free
	
	mov r4, r2
	
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
	ldr r3, =ReturnOffset
	bx r3

.ltorg
.align

EALiterals:
	@ POIN GetUnitWeaponRank
