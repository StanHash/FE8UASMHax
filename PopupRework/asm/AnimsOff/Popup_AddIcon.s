.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = Popup 6C, r1 = Icon Index Short, r2 = X Offset

.set POPUP_6C_UPDATER_OFFSET, 0x50

Popup6C_AddIcon:
	push {r4-r7, lr}
	
	mov r4, r0 @ r4 = Popup 6C
	mov r5, r1 @ r5 = Icon Index Short
	mov r7, r2 @ r7 = X Offset
	
	ldr r0, [r4, #POPUP_6C_UPDATER_OFFSET]
	
	cmp r0, #0
	bne NoNeedToMakeThat6CBecauseItAlreadyExists
	
	ldr r0, =#0x08592228 @ The 6C pointer
	mov r1, r4
	
	_blh pr6C_New
	
	mov r1, #1
	neg r1, r1
	
	mov  r2, #0x2C
	strh r1, [r0, r2]
	
	str r0, [r4, #POPUP_6C_UPDATER_OFFSET]
	
NoNeedToMakeThat6CBecauseItAlreadyExists:
	@ r0 = 6C pointer
	
	add r0, #0x2C
	mov r6, r0
	
Loop:
	mov  r0, #0
	ldsh r0, [r6, r0]
	
	cmp r0, #0
	blt MakeNew @ Register OBJ Graphics and add icon to updater
	
	add r6, #8 @ Icon slot is already taken, loop some more
	b Loop
	
MakeNew:
	@ Storing Icon Id
	strh r5, [r6, #0]
	
	@ r0 = Popup Root Tile X
	mov  r0, #0x37
	ldrb r0, [r4, r0]
	
	@ r0 = RealRootX = (RootX + 1) * TileSize
	add r0, #1
	lsl r0, #3 @ TileSize = 2^3 = 8
	
	@ r0 = RealRootX + Icon X Offset
	add r0, r7
	
	@ Storing Icon X
	strh r0, [r6, #2]
	
	@ r0 = Popup Root Tile Y
	mov  r0, #0x38
	ldrb r0, [r4, r0]
	
	@ r0 = (RootY + 1) * TileSize
	add r0, #1
	lsl r0, #3 @ TileSize = 2^3 = 8
	
	@ Storing Icon Y
	strh r0, [r6, #4]
	
	mov r2, r4
	add r2, #0x40
	
	@ r1 = tile; tile += 4;
	ldrh r1, [r2]
	add  r3, r1, #4 @ Advance output root by 2 tiles
	strh r3, [r2]
	
	@ r2 = General Palette Index
	ldrh r2, [r2, #2]
	
	@ r0 = Local Palette Index
	mov r0, #0x0F
	and r0, r2
	
	@ r0 = (Pal << 12) | OBJTileIndex
	lsl r0, #0xC
	orr r0, r1
	
	@ Storing that
	strh r0, [r6, #6]
	
	@ arg r0 = Icon Short
	mov  r0, r5
	
	@ arg r1 = Obj Tile Root Index
	
	_blh prIcon_LoadOBJGfx
	
	@ Setting next entry to unused
	
	mov r0, #1
	neg r0, r0
	
	strh r0, [r6, #8]
	
End:
	pop {r4-r7}
	
	pop {r1}
	bx r1

.ltorg
.align

