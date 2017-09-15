.thumb
.include "_Definitions.h.s"

@ Using existing literals in case the data was repointed
.set ppPopupTSA, 0x08075D1C @ Base TSA
.set ppPopupImg, 0x08075D14 @ Image/Tile Gfx
.set ppPopupPal, 0x08075D2C @ Palette
.set ppPopupTBG, 0x08075DDC @ Text BG

.set lprGetPopupLen,       (EALiterals+0x00)
.set lprDrawPopupContents, (EALiterals+0x04)

@ Arguments: r0 = Popup 6C (maybe fake?)
DrawBattlePopup:
	push {r4-r7, lr}
	add sp, #-0x08
	
	@ var r4   = Popup 6C
	@ var r5   = Pixel Width
	@ var r6   = Tile Width
	@ var r7   = gfx Start Offset
	@ var [sp] = Text Struct
	
	mov r4, r0
	
	@ LOADING TILE GRAPHICS
	
	ldr r0, =ppPopupImg
	ldr r0, [r0]
	
	ldr r1, =#0x06002000 @ VRAM + 0x2000
	
	_blh prSVCLZSSUncomp16bit
	
	@ LOADING TILE CONFIGURATION
	
	ldr r0, =ppPopupTSA
	ldr r0, [r0]
	
	ldr r1, =#0x02019790 @ Some TSA Buffer
	
	_blh prSVCLZSSUncomp8bit
	
	@ SETTING UP FONT
	
	ldr r3, =prFont_SetupForUI
	mov lr, r3
	
	ldr r0, =#0x02017648 @ Some Font Struct
	ldr r1, =#0x06002100 @ Root = VRAM + 0x2100
	ldr r2, =#0x108      @ Size = 0x108
	mov r3, #1           @ Pal  = 1
	
	.short 0xF800
	
	_blh #0x08004428 @ Sets some special drawing routine (maybe to draw a blue background?)
	
	@ LOADING PALETTE
	
	ldr r0, =ppPopupPal
	ldr r0, [r0]
	
	ldr r1, =#0x020228C8 @ Palette Buffer for Palette #1
	
	mov r2, #8
	
	_blh prSVCMemcopyFast
	
	@ GEN LEN
	
	mov r0, r4
	ldr r3, lprGetPopupLen
	
	_blr r3
	
	mov r5, r0
	
	@ GEN FRAME TILES
	
	ldr r0, =pBG1TileMap
	
	add r1, r5, #7
	lsr r1, #3
	
	mov r6, r1
	
	_blh #0x08075B78 @ Makes Actual Tile Map (Size relative and all) from the TSA
	
	@ INIT TEXT
	
	mov r0, sp
	mov r1, r6
	
	_blh prText_Init
	
	mov r0, sp
	
	@ r1 = (TileWidth*8 - PixelWidth) / 2
	lsl r1, r6, #3
	sub r1, r5
	lsr r1, #1
	
	_blh prText_SetCursor
	
	@ SETUP TEXT BG
	
	ldr r0, =ppPopupTBG
	ldr r0, [r0]
	
	ldr r1, =#0x06002100
	
	_blh prSVCLZSSUncomp16bit
	
	@ SETTING UP BG
	
	@ BG 1
	mov r0, #1
	
	@ r1 = (TileSize+4)*8
	add r1, r6, #4
	lsl r1, #3
	
	@ r1 = XOffset = (240 - Size) / 2
	mov r3, #240
	sub r1, r3, r1
	asr r1, #1
	
	strh r1, [r4, #0x32]
	
	@ r1 = -XOffset
	neg r1, r1
	
	@ r2 = YOffset
	mov r2, #48
	
	strh r2, [r4, #0x34]
	
	@ r2 = -48
	neg r2, r2
	
	_blh prBG_SetPosition
	
	mov r0, #1
	_blh prBG_Enable
	
	@ YES ALL IS DONE HERE
	
	mov r0, r4
	mov r1, sp
	
	ldr r2, lprDrawPopupContents
	_blr r2
	
	_blh #0x08001F80 @ Sets up (clears?) some special effects
	
	mov r1, #0x01
	lsl r1, #8
	
	mov  r0, #0x48
	ldrh r0, [r4, r0]
	
	_blh #0x08071990 @ Plays a sound?
	
	add sp, #+0x08
	pop {r4-r7}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN GetPopupLen
	@ POIN DrawPopupComponents
