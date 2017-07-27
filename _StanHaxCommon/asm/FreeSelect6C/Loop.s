.thumb
.include "_Definitions.h.s"

FreeSelect6C_Loop:
	push {r4-r5, lr}
	
	mov r4, r0
	
	_blh prHandlePPCursorMovement
	
	@ (r1, r2) = Cursor Map Pos
	ldr r0, =pGameDataStruct
	ldrh r1, [r0, #0x14]
	ldrh r2, [r0, #0x16]
	
	@ r3 = New Key Presses
	ldr  r3, =pKeyStatusBuffer
	ldrh r3, [r3, #8] @ New Presses
	
	mov r0, #0x01 @ A
	tst r3, r0
	beq NoAPress
	
	ldr r3, [r4, #0x2C]
	ldr r3, [r3, #0x08] @ OnAPress
	
	cmp r3, #0
	beq Finish
	
	mov r0, r4
	bl BXR3
	
	b HandleCode
	
NoAPress:
	mov r0, #0x02 @ B
	tst r3, r0
	beq NoBPress

	ldr r3, [r4, #0x2C]
	ldr r3, [r3, #0x0C] @ OnBPress
	
	cmp r3, #0
	beq Finish
	
	mov r0, r4
	bl BXR3
	
	b HandleCode
	
NoBPress:
	mov r0, #1
	lsl r0, #8 @ R
	tst r3, r0
	beq NoRPress
	
	ldr r3, [r4, #0x2C]
	ldr r3, [r3, #0x10] @ OnRPress
	
	cmp r3, #0
	beq Finish
	
	mov r0, r4
	bl BXR3
	
	@ b HandleCode
	
HandleCode:
	mov r5, r0
	
	mov r0, #2
	tst r5, r0
	beq NoDelete
	
	mov r0, r4
	_blh pr6C_BreakLoop
	
	b End @ No need to draw, so go directly to end
	
NoDelete:
	mov r0, #4
	tst r5, r0
	beq NoBeep
	
	ldr  r0, =pChapterDataStruct
	add  r0, #0x41
	ldrb r0, [r0]
	
	lsl r0, #0x1E
	blt NoBeep
	
	mov r0, #0x6A
	_blh prPlaySound
	
NoBeep:
	mov r0, #8
	tst r5, r0
	beq NoBoop
	
	ldr  r0, =pChapterDataStruct
	add  r0, #0x41
	ldrb r0, [r0]
	
	lsl r0, #0x1E
	blt NoBoop
	
	mov r0, #0x6B
	_blh prPlaySound
	
NoBoop:
	mov r0, #0x10
	tst r5, r0
	beq NoGurr

	ldr  r0, =pChapterDataStruct
	add  r0, #0x41
	ldrb r0, [r0]
	
	lsl r0, #0x1E
	blt NoGurr
	
	mov r0, #0x6C
	_blh prPlaySound
	
NoRPress:
NoGurr:
Finish:
	@ Update Cursor Graphics
	
	ldr r3, =pGameDataStruct
	
	mov r0, #0x20
	ldsh r1, [r3, r0]
	
	mov r0, #0x0C
	ldsh r2, [r3, r0]
	
	sub r1, r2
	
	mov r0, #0x22
	ldsh r2, [r3, r0]
	
	mov r0, #0x0E
	ldsh r3, [r3, r0]
	
	sub r2, r3
	
	ldr r0, [r4, #0x30]
	_blh prTCS_Draw
	
End:
	pop {r4-r5}
	
	pop {r3}
BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ noting
