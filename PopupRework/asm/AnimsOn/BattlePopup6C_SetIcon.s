.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = Popup 6C, r1 = Icon Index Short, r2 = X Offset

.set POPUP_AIS_OFFSET, 0x50

BattlePopup6C_SetIcon:
	push {r4-r7, lr}
	
	@ Saving arguments
	mov r4, r0
	mov r5, r1
	mov r6, r2
	
	ldr r0, [r4, #POPUP_AIS_OFFSET]
	
	cmp r0, #0
	beq NoFree
	
	_blh prAIS_Free
	
NoFree:
	ldr r0, =#0x0878D518 @ Icon AIS?
	mov r1, #150
	
	_blh prAIS_New
	
	str r0, [r4, #POPUP_AIS_OFFSET]
	
	@ mov r1, #0x2440
	mov r1, #0x91
	lsl r1, #6
	
	strh r1, [r0, #8]
	
	@ Setting up AIS x
	ldrh r1, [r4, #0x32]
	add  r1, #0x10
	add  r1, r6
	strh r1, [r0, #2]
	
	@ Setting up AIS y
	ldrh r1, [r4, #0x34]
	add  r1, #8
	strh r1, [r0, #4]
	
	@ Loading icon graphics
	
	mov r0, r5
	mov r1, #0x40
	
	_blh prIcon_LoadOBJGfx
	
	pop {r4-r7}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ nothing
