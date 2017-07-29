.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = Item Short, r1 = Unit Struct
GetMaxRange:
	push {lr}
	
	ldr r3, =#0x08017684 @ Vanilla Max Range Getter (for Item only)
	
	mov lr, r3
	.short 0xF800
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ notin
