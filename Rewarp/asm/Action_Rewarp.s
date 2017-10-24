.thumb
.include "_Definitions.h.s"

Action_Rewarp:
	push {r4, lr}
	
	ldr r3, =pActionStruct
	
	ldrb r1, [r3, #0x13]
	ldrb r2, [r3, #0x14]
	
	strb r1, [r3, #0x0E]
	strb r2, [r3, #0x0F]
	
End:
	mov r0, #1 @ Continue because lol
	
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	
