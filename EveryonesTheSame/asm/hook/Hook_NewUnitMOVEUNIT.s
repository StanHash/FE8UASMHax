.thumb
.include "_Definitions.h.s"

.set prUnit_GetMovingMapSpriteIndex, EALiterals+0x00

@ Arguments (setup by installer): r0 = MOVEUNIT pointer, r1 = Unit Struct
Hook_NewUnitMOVEUNIT:
	@ REPLACED STUFF START
	
		@ Field 0x2C of MOVEUNIT is unit struct
		str r1, [r0, #0x2C]
		
		@ Field 0x3E of MOVEUNIT is "make camera follow moving unit" boolean
		mov r2, #0x3E
		mov r3, #1
		strb r3, [r0, r2]
	
	@ REPLACED STUFF END
	
	push {r4, lr}
	
	mov r4, r0 @ MOVEUNIT
	mov r0, r1 @ Unit Struct
	
	ldr  r3, prUnit_GetMovingMapSpriteIndex
	_blr r3
	
	mov r1, #0x41
	strb r0, [r4, r1]
	
	mov r0, r4
	
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prUnit_GetMovingMapSpriteIndex
