.thumb
.include "fe8.inc"

ONINIT:
	push {lr}
	
	@ implied        @ arg r0 = Parent 6C
	adr r1, BBString @ arg r1 = String
	
	_blh BottomHelpDisplay_New
	
	pop {r1}
	bx r1

.ltorg
.align

BBString:
	.asciz "Select target position for rewarping."
	.align

EALiterals:
	@ nothing
