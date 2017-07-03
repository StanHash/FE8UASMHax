.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = Unit Struct, r1 = WType
GetUnitWeaponRank:
	mov r3, r0
	
	@ r0 = ClassStruct + 2C + WType = &(Class.wRank[wType])
	ldr r0, [r3, #4]
	add r0, #0x2C
	add r0, r1
	
	@ r0 = class rank
	ldrb r0, [r0]
	
	@ Return 0 if our class can't wield the weapon we want
	cmp r0, #0
	beq End
	
	@ r0 = UnitStruct + 28 + WType = &(Unit.wRank[wType])
	add r0, r3, r1
	add r0, #0x28
	
	@ r0 = unit rank
	ldrb r0, [r0]
	
End:
	bx lr

.ltorg
.align
