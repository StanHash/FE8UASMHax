.thumb
.include "_Definitions.h.s"

@ .set lprPopupAddIcon, (EALiterals+0x00)

WTypeIcon_Draw:
	push {r4-r5, lr}

	@ r4 = Popup 6C, r5 = Text Struct
	mov r4, r0
	mov r5, r1

	@ arg r1 = Icon Index for WType
	ldr  r1, =pPopupShortArgument
	ldrh r1, [r1]
	add  r1, #0x70

	@ arg r0 = Popup 6C
	mov r0, r4

	@ arg r2 = local X
	ldrb r2, [r5, #2]

	ldr r3, [r4, #0x4C]
	@ ldr  r3, lprPopupAddIcon
	bl BXR3

	mov r0, r5
	mov r1, #0x10

	_blh prText_AdvanceCursor

	mov  r1, #0x42
	ldrb r1, [r4, r1]

	mov r0, #1

	_blh prIcon_LoadPalette

	pop {r4-r5}

	pop {r3}
BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ nothing
