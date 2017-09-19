.thumb
.include "_Definitions.h.s"

DEBMON_Init:
	push {lr}
	
	mov r1, #0
	
	@ Screen Debug display bool
	mov  r2, #0x64
	strh r1, [r0, r2]
	
	@ OBJ Debug display bool
	mov  r2, #0x66
	strh r1, [r0, r2]
	
	push {r4}
	mov r4, #0xFF
	
Continie:
	mov r0, r4
	mov r1, #2
	_blh prDebugPrintHex
	
	adr r0, STRINGTOPRINT
	_blh prDebugPrint
	
	sub r4, #1
	bge Continie
	
	pop {r4}
	
	pop {r0}
	bx r0

.align
STRINGTOPRINT:
	.ascii "AGBFE DEBUG MONITOR"
	.byte 0x0A, 0

.ltorg
.align

EALiterals:
	@ nothing
