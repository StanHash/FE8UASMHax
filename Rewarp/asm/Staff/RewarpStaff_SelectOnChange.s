.thumb
.include "fe8.inc"

ONCHANGE:
	push {lr}
	
	lsl r3, r2, #2
	
	ldr  r0, =ppMoveMapRows
	ldr  r0, [r0]
	ldr  r0, [r0, r3]
	ldrb r0, [r0, r1]
	
	cmp r0, #0
	blt Invalid
	
	mov r0, #0x20 @ (0x20 = Set Valid Cursor)
	b End
	
Invalid:
	mov r0, #0x40 @ (0x40 = Set Invalid Cursor)

End:
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ nothing
