.thumb
.include "_Definitions.h.s"

@ 6C STRUCT FORMAT:
@ 2C | Array of 8-byte long fields:
@	0 | Icon Index Short (-1 = End)
@	2 | Screen X
@	4 | Screen Y
@	6 | Tile Root + Palette Id

PopupIcons6C_UpdateObj:
	push {r4-r6, lr}
	
	mov r4, r0
	adr r5, IconOBJ_OAMData
	ldr r6, =prCopyToOAM_Secondary
	
	add r4, #0x2C
	
Loop:
	ldrh r0, [r4, #0]
	
	lsl r0, #16
	asr r0, #16
	
	cmp r0, #0
	blt End
	
	ldrh r0, [r4, #2]
	ldrh r1, [r4, #4]
	ldrh r3, [r4, #6]
	
	mov  r2, r5
	
	_blr r6
	
	add r4, #8
	b Loop
	
End:
	pop {r4-r6}
	
	pop {r0}
	bx r0

.ltorg

IconOBJ_OAMData:
	.short 1      @ 1 part
	
	.short 0x0000 @ XOffset = 0; Square Shape
	.short 0x4000 @ YOffset = 0; 16 x 16
	.short 0x0000 @ TileOffset = 0

.ltorg
.align

EALiterals:
