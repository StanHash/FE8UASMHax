.thumb
.include "_Definitions.h.s"

DEBMON_Loop:
	push {r4, lr}
	
	mov r4, r0
	
	ldr  r3, =pKeyStatusBuffer
	
	ldrh r0, [r3, #4] @ r0 = Current Presses
	ldrh r1, [r3, #8] @ r1 = New Presses
	
	ldr r2, =#0x112
	
	cmp r0, r2
	bne NoDebugScreenSwap
	
	tst r1, r2
	beq NoDebugScreenSwap
	
	@ Clearing Key Status
	@ mov r0, #0
	
	@ strh r0, [r3, #4]
	@ strh r0, [r3, #6]
	@ strh r0, [r3, #8]
	
	@ Clearing BG2
	ldr r0, =pBG2TileMap
	mov r1, #0
	_blh prBGMap_Fill
	
	@ Enable BG2 Sync
	mov r0, #2
	_blh prBG_Enable
	
	@ r0 = (DEBMON+0x64) = ((DEBMON+0x64) ^ 1)
	mov  r1, #0x64
	ldrh r0, [r4, r1]
		mov r2, #1
		eor r0, r2
	strh r0, [r4, r1]
	
	cmp r0, #0
	beq HandleDebugScreenEnd
	
	@ BEGIN SETUP GFX FOR DEBUG CONSOLE
	
	mov r0, #2 @ arg r0 = BG2
	mov r1, #0 @ arg r1 = default

	_blh prSetupDebugBGFont
	
	mov r0, #2 @ arg r0 = BG2
	mov r1, #0 @ arg r1 = X 0
	mov r2, #0 @ arg r2 = Y 0

	_blh prBG_SetPosition
	
	@ pPalettes[0][0] = 0;
	ldr  r0, =pPaletteBuffer
	mov  r1, #0
	strh r1, [r0]
	
	_blh prEnablePaletteSync
	
	@ (pLCDControlBuffer+1) = ((pLCDControlBuffer+1) & (0xE0)) | (0x04)
	ldr  r0, =pLCDControlBuffer
	ldrb r1, [r0, #1]
		@ Disable BG0, BG1, BG2, BG3, OBJ
		mov r2, #0xE0
		and r1, r2
		
		@ Enable BG2
		mov r2, #0x04
		orr r1, r2
	strb r1, [r0, #1]
	
	_blh prLockGameLogic
	
	@ END SETUP GFX FOR DEBUG CONSOLE
	
	b NoDebugScreenSwap
	
HandleDebugScreenEnd:
	@ BEGIN SETUP GFX FOR BACK TO GAME
	
	ldr  r0, =pLCDControlBuffer
	ldrb r1, [r0, #1]
		@ Enable BG0, BG1, BG2, BG3, OBJ
		mov r2, #0x1F
		orr r1, r2
	strb r1, [r0, #1]
	
	_blh prUnlockGameLogic
	
	@ END SETUP GFX FOR BACK TO GAME
	
NoDebugScreenSwap:
	mov  r0, #0x64
	ldrh r0, [r4, r0]
	
	cmp r0, #0
	beq NoDBGDisplay
	
	ldr r3, =pKeyStatusBuffer
	
	ldrh r0, [r3, #4] @ arg r0 = current presses
	ldrh r1, [r3, #8] @ arg r1 = new presses
	
	_blh prDebugFlushOnBG2_VScroll
	
	b End
	
NoDBGDisplay:
	mov  r0, #0x66
	ldrh r0, [r4, r0]
	
	cmp r0, #0
	beq End
	
	@ Test print to see if it works!
	
	mov r0, #24
	mov r1, #24
	adr r2, lstrHelloWorld
	
	_blh prDebugPrintOBJ
	
End:
	pop {r4}
	
	pop {r0}
	bx r0

lstrHelloWorld:
	.ascii "Hello World!"
	.byte 0

.ltorg
.align

EALiterals:
	@ nothing
