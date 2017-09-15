.thumb
.include "_Definitions.h.s"

.set pTCS_PositionSelectCursor, 0x085A0EA0

FreeSelect6C_Init:
	push {r4, lr}
	
	mov r4, r0
	
	@ _blh prLockGameLogic
	
	ldr r0, =pTCS_PositionSelectCursor
	mov r1, #0
	
	_blh prTCS_New
	
	str r0, [r4, #0x30]
	
	mov r1, #0
	strh r1, [r0, #0x22]
	
	_blh prTCS_SetSubIndex
	
	pop {r4}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ noting
