.thumb
.include "_Definitions.h.s"

.set prMMS_GetNormalMovSpeed, EALiterals+0x00

@ .org 0x07947C
MOVEUNIT6C_GetMovementSpeed:
	push {r4, lr}
	
	@ Honestly I don't get the first half of this routine, it's copied straight from the vanilla game
	
	@ r4 = MOVEUNIT 6C
	mov r4, r0
	
	add  r0, #0x4A
	ldrh r1, [r0]
	
	mov r0, #0x80
	
	tst r0, r1
	beq Bit7NotSet
	
	add r1, #0x80
	
Bit7NotSet:
	mov r0, r4
	
	add  r0, #0x44
	ldrb r0, [r0]
	
	cmp r0, #0
	beq FieldSetToFalse
	
	mov r0, #1
	lsl r0, #8 @ r0 = 0x100
	
	b End

FieldSetToFalse:
	cmp r1, #0x40
	beq ComputeNormalSpeed
	
	cmp r1, #0
	beq ComputeStandardSpeed
	
	@ Uhhh, I'm tired I'll stop here for now
	@ If you see this, please tell me (StanH_) because it means I forgot about it
	
ComputeStandardSpeed:
	_blh #0x8030CC0 @ Cannot press A to speed up movement
	
	cmp r0, #0
	bne ComputeFastSpeed
	
	ldr  r0, =pKeyStatusBuffer
	ldrh r0, [r0, #4] @ Current Key Status
	
	mov r1, #1
	
	tst r0, r1
	beq ComputeFastSpeed
	
	mov r0, #0x80
	b End

ComputeFastSpeed:
	ldr  r0, =pChapterDataStruct
	add  r0, #0x40
	ldrb r0, [r0]
	
	lsr r0, #7
	beq ComputeNormalSpeed
	
	mov r0, #0x40
	b End
	
ComputeNormalSpeed:
	mov r0, r4
	
	add  r0, #0x41
	ldrb r0, [r0]
	
	ldr r3, prMMS_GetNormalMovSpeed
	_blr r3
	
End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prMMS_GetNormalMovSpeed
