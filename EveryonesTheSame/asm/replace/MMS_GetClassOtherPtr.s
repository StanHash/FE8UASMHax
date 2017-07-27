.thumb
.include "_Definitions.h.s"

.set pMMSTable,                      EALiterals+0x00
.set prClass_DefaultMovingMapSprite, EALiterals+0x04

@ .org 0x0BAC30
MMS_GetOtherPtr:
	push {lr}
	
	ldr r3, prClass_DefaultMovingMapSprite
	_blr r3
	
	ldr r1, pMMSTable
	
	@ mov r0, #0
	sub r0, #1 @ MMS Entry is 1-index
	
	lsl r0, #4 @ Entry Size: 0x10
	add r0, r1 @ r0 = Ptr to Entry
	
	ldr r0, [r0, #4]
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN pMMSTable
	@ POIN prClass_DefaultMovingMapSprite
