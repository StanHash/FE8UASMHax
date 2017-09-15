.thumb
.include "_Definitions.h.s"

ItemIcon_Draw:
	push {r4-r5, lr}

	mov r4, r0
	mov r5, r1

	ldr  r0, =pPopupShortArgument
	ldrh r0, [r0]

	_blh prItem_GetIconIndex

	mov r1, r0
	mov r0, r4

	ldrb r2, [r5, #2]

	ldr r3, [r4, #0x4C]
	bl BXR3

	mov r0, r5
	mov r1, #0x10

	_blh prText_AdvanceCursor

	mov  r1, #0x42
	ldrb r1, [r4, r1]

	mov r0, #0

	_blh prIcon_LoadPalette

	pop {r4-r5}

	pop {r3}
BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ nothing
