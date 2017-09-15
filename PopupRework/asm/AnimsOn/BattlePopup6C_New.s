.thumb
.include "_Definitions.h.s"

.set lp6CBattlePopup,        (EALiterals+0x00)
.set lprBattlePopup_SetIcon, (EALiterals+0x04)

@ Arguments: r0 = Popup Definition, r1 = Time, r2 = Parent 6C
BattlePopup6C_New:
	push {r4-r7, lr}
	
	mov r5, r0
	mov r6, r1
	
	ldr r0, lp6CBattlePopup
	mov r1, r2
	
	_blh pr6C_NewBlocking
	
	mov r4, r0
	
	@ Storing Popup Definition
	str r5, [r4, #0x2C]
	
	@ Storing palette index
	mov r0, #0x12
	mov r1, #0x42
	strb r0, [r4, r1]
	
	@ Storing time
	
	cmp r6, #0
	bne NoNeg
	sub r6, #1
NoNeg:
	strh r6, [r4, #0x30]
	
	@ Storing icon adding routine
	ldr r0, lprBattlePopup_SetIcon
	str r0, [r4, #0x4C]
	
	@ Setting null AIS
	mov r0, #0
	str r0, [r4, #0x50]
	
	pop {r4-r7}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN p6CBattlePopup
	@ POIN prBattlePopup_SetIcon
