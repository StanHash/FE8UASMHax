.thumb
.include "fe8.inc"

RewarpStaff_SelectOnSelect:
	push {r4, lr}
	
	mov r4, r0
	
	lsl r3, r2, #2
	
	ldr  r0, =ppMoveMapRows
	ldr  r0, [r0]
	ldr  r0, [r0, r3]
	ldrb r0, [r0, r1]
	
	cmp r0, #0
	blt No
	
	ldr  r3, =pActionStruct
	
	strb r1, [r3, #0x13] @ x target
	strb r2, [r3, #0x14] @ y target
	
	_blh #0x0802951C @ Set Staff Action Stuff (and other stuff)
	
	ldr r3, =ppActiveUnit
	ldr r3, [r3]
	
	mov r0, r4           @ arg r0 = Parent 6C
	
	ldrb r1, [r3, #0x10] @ arg r1 = X
	ldrb r2, [r3, #0x11] @ arg r2 = Y
	
	_blh BeginCameraMovement
	
	mov r0, #0x0E @ (0x08 | 0x04 | 0x02) = (Beep | Boop | Delet)
	
	b End
	
No:
	mov r0, #0x10 @ gurr sound
	
End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ nothing
