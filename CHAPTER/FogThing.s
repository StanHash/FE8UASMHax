.thumb
.include "_Definitions.h.s"

FogThing:
	push {lr}
	
	ldr r2, =(pEventSlot0 + (0xB * 4)) @ Event Slot B
	ldr r3, =pGameDataStruct
	
	ldrh r0, [r2, #0x00] @ Target X
	ldrh r1, [r3, #0x0C] @ Camera X
	
	lsl r0, #4
	sub r0, r1
	
	ldrh r1, [r2, #0x02] @ Target Y
	ldrh r2, [r3, #0x0E] @ Camera Y
	
	lsl r1, #4
	sub r1, r2
	
	@ r0 = Target X - Camera X
	@ r1 = Target Y - Camera Y
	
	_blh #0x08078A14 @ DisplayFogThingMaybe
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
