.thumb
.include "_Definitions.h.s"

.set lprPopupDrawComponents, (EALiterals+0x00)
.set lprPopupIconAdder,      (EALiterals+0x04)

@ Arguments: r0 = Popup 6C
DrawPopup:
	push {r4-r7, lr}
	add sp, #-0x08
	
	@ var r4   = 6C pointer
	@ var r5   = Tile Width
	@ var r6   = Offset to start gfx at
	@ var r7   = (TileX, TileY) pair
	@ var [sp] = Text Struct
	
	@ r4 = 6C pointer
	mov r4, r0
	
	@ null the 6C pointer to icon updater
	mov r0, #0x50
	mov r1, #0
	str r1, [r4, r0]
	
	@ r1 = gfx width
	mov  r1, #0x46
	ldrh r1, [r4, r1]
	
	@ r5 = tile width
	lsr r5, r1, #3
	
	mov r0, #7 @ 0b111
	tst r0, r1
	beq RoundWidth
	
	@ Add 1 if the gfx width doesn't align to a tile
	add r5, #1
	
RoundWidth:
	@ r6 = (TileWidth*8 - GfxWidth) / 2 = Offset to start at for alignment
	lsl r6, r5, #3
	sub r6, r1
	asr r6, r6, #1
	
	mov  r2, #0x34
	ldsb r2, [r4, r2]
	
	add r0, r2, #1 @ r0 here is not useful, we are checking if r2 is equal to -1 (aka if (r2 + 1) sets the zero flag)
	bne XSet
	
	@ r7 = ((30 - TileWidth) / 2) - 1 = Default X
	mov r2, #30
	sub r2, r5
	asr r2, #1
	sub r2, #1
	
XSet:
	mov  r3, #0x35
	ldsb r3, [r4, r3]
	
	add r0, r3, #1 @ same as for x
	bne YSet
	
	mov r3, #8 @ Default Y
	
YSet:
	@ r7 = pair(TileX, TileY)
	_MakePair r7, r2, r3, r0
	
	@ Allocating Space for Argument 5
	add sp, #-0x04
	
	@ PREPARE
	ldr r3, =prMakeUIWindowTileMap @ 0804E368
	mov lr, r3
	
	@ arg [sp] = Window Style
	mov  r0, #0x36
	ldrb r0, [r4, r0]
	str  r0, [sp]
	
	_GetPairFirst  r0, r7 @ arg r0 = tile x
	_GetPairSecond r1, r7 @ arg r1 = tile y
	add r2, r5, #2        @ arg r2 = tile width
	mov r3, #4            @ arg r3 = tile height
	
	@ CALL
	.short 0xF800
	
	@ Deallocating Space for Argument 5
	add sp, #+0x04
	
	@ Storing X to field 37
	_GetPairFirst r1, r7
	mov  r0, #0x37
	strb r1, [r4, r0]
	
	@ Storing Y to field 38
	_GetPairSecond r1, r7
	mov  r0, #0x38
	strb r1, [r4, r0]
	
	@ Storing W to field 39
	add  r1, r5, #2
	mov  r0, #0x39
	strb r1, [r4, r0]
	
	@ Storing H (3?) to field 3A
	mov  r1, #3
	mov  r0, #0x3A
	strb r1, [r4, r0]
	
	@ Initializing Text
	
	mov r0, sp @ arg r0 = Text Struct pointer
	mov r1, r5 @ arg r1 = Tile Amount
	
	_blh prText_Init
	
	mov r0, sp @ arg r0 = Text Struct pointer
	
	@ arg r1 = Color Id
	mov  r1, #0x3B
	ldrb r1, [r4, r1]
	
	_blh prText_SetColor
	
	mov r0, sp @ arg r0 = Text Struct pointer
	mov r1, r6 @ arg r1 = Local X Cursor
	
	_blh prText_SetCursor
	
	@ Storing icon adder to 6C
	ldr r1, lprPopupIconAdder
	str r1, [r4, #0x4C]
	
	@ And here the fun begins (in theory)
	
	mov r0, r4
	mov r1, sp
	
	@ Drawing/Generating Component Gfx
	ldr r3, lprPopupDrawComponents
	_blr r3
	
	@ Last part of the routine is for displaying the text
	
	@ r1 = Tile Row Offset 
	_GetPairSecond r1, r7 @ r1 = Tile Y
	add r1, #1 @ r1 = Tile Y + 1 (Text Y Start)
	lsl r1, #5
	
	@ r1 = Tile Root Offset
	_GetPairFirst  r0, r7
	add r0, #1
	add r1, r0
	lsl r1, #1
	
	@ arg r1 = Tile Root Pointer
	ldr r0, =pBG0TileMap
	add r1, r0
	
	@ arg r0 = Text Struct
	mov r0, sp
	
	@ Displaying Text on Screen
	_blh prText_Draw
	
	_blh #(0x08003C94) @ probably resets the font to what it needs to be?
	
	add sp, #+0x08
	pop {r4-r7}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN RoutineArray
	@ POIN IconAdder
