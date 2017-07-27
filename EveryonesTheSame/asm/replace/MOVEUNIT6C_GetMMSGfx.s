.thumb
.include "_Definitions.h.s"

.set pMMSTable, EALiterals+0x00

@ .org 0x079574
MOVEUNIT6C_GetMMSGfx:
	ldr r1, pMMSTable
	
	@ r0 = *(MOVEUNIT+0x41) (MMS Entry Id)
	add  r0, #0x41
	ldrb r0, [r0]
	
	@ mov r0, #0
	sub  r0, #1 @ MMS Entry is 1-index
	
	lsl r0, #4 @ Entry Size: 0x10
	add r0, r1 @ r0 = Ptr to Entry
	
	ldr r0, [r0]
	
	bx lr

.ltorg
.align

EALiterals:
	@ POIN pMMSTable
