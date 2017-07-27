.thumb
.include "_Definitions.h.s"

.set pMMSTable, EALiterals+0x00

MMS_GetNormalMoveSpeed:
	ldr r1, pMMSTable
	
	mov r0, #0
	@ sub r0, #1 @ MMS Entry is 1-index
	
	lsl r0, #4 @ Entry Size: 0x10
	add r0, r1 @ r0 = Ptr to Entry
	
	ldrb r0, [r0, #0xC]
	
	bx lr

.ltorg
.align

EALiterals:
	@ POIN pMMSTable
