.thumb
.include "_Definitions.h.s"

.set BottomHelpTextId, EALiterals+0x00

LongSelect_OnInit:
	push {r4, lr}
	
	mov r4, r0
	
	ldr r0, BottomHelpTextId
	
	cmp r0, #0
	beq End
	_blh prGetTextInBuffer
	
	mov r1, r0
	mov r0, r4
	
	_blh prBottomHelpDisplay_New
	
End:
	pop {r4}

	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ WORD BottomHelpTextId
