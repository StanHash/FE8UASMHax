.thumb
.include "_Definitions.h.s"

@ The Wrapper 6C replaces what was previously known as "ekrPopup" and "ekrPopup2"

.set lp6CBattlePopupWrapper,        (EALiterals+0x00)
.set lpraBattlePopupShowupTable,    (EALiterals+0x04)
.set lpraPromotionPopupShowupTable, (EALiterals+0x08)

Wrapper6C_New:
	push {lr}
	
	@ Making Popup Wrapper 6C in thread 3
	
	ldr r0, lp6CBattlePopupWrapper
	mov r1, #3
	
	_blh pr6C_New
	
	@ Storing 6C
	ldr r1, =pp6CBattlePopup
	str r0, [r1]
	
	@ Storing Activity bool
	mov  r1, #0
	ldr  r2, =pBattlePopupEnded
	strb r1, [r2]
	
	ldr  r1, =#0x0203E120 @ some battle enum: 0 = close, 1 = one tile away, 2 = far?, 4 = promoting apparently
	ldrb r1, [r1]
	
	cmp r1, #4
	beq Promoting
	
	ldr r1, lpraBattlePopupShowupTable
	str r1, [r0, #0x2C]
	
	b EndLoadTable

Promoting:
	ldr r1, lpraPromotionPopupShowupTable
	str r1, [r0, #0x2C]

EndLoadTable:
	mov r0, #0x80
	_blh #0x080022EC @ Something sound related?
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN p6CBattlePopupWrapper
	@ POIN pPostBattleArray
	@ POIN pPromotionArray
