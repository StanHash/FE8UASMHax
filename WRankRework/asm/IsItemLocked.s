.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = Item Short, r1 = Subject Unit (unused for now, but added for further hacking if needed)
IsItemLocked:
	push {lr}
	
	_blh prItem_GetAttributes
	
	ldr r1, =0x003D3C00 @ 0b1111010011110000000000, bits set for WLock Attributes
	and r0, r1
	
	pop {r1}
	bx r1
	
.ltorg
.align
