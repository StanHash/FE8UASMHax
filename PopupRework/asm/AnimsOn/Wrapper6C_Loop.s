.thumb
.include "_Definitions.h.s"

.set lprBattlePopup_New, (EALiterals+0x00)

Wrapper6C_Loop:
	push {r4-r7, lr}
	
	mov r4, r0
	
Continue:
	@ r5 = Init Routine, r6 = Popup Def, r7 = Time; [r4, #0x2C]++
	ldr   r1, [r4, #0x2C]
	ldmia r1!, {r5-r7}
	str   r1, [r4, #0x2C]
	
	cmp r5, #0
	beq Finish
	
	mov r3, r5
	bl BXR3
	
	cmp r0, #0
	beq Continue
	
	ldr r3, lprBattlePopup_New
	
	mov r0, r6
	mov r1, r7
	mov r2, r4
	
	bl BXR3
	
	mov r0, r4
	_blh pr6C_BreakLoop
	
	b End
	
Finish:
	mov r0, r4
	mov r1, #1
	
	_blh pr6C_GotoLabel
	
End:
	pop {r4-r7}
	
	pop {r3}
BXR3:
	bx r3

.ltorg
.align

EALiterals:
	@ prBattlePopup_New
