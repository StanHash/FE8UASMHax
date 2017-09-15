.thumb
.include "_Definitions.h.s"

Wrapper6C_Cleanup:
	push {r4-r7, lr}
	
	ldr r1, =pBattlePopupEnded
	mov r0, #1
	
	strb r0, [r1]
	
	mov r0, #0x1
	lsl r0, #8
	
	_blh #0x080022EC
	
	pop {r4-r7}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
