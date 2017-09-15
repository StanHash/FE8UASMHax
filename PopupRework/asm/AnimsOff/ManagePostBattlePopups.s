.thumb
.include "_Definitions.h.s"

ManagePostBattlePopups:
	push {r4-r7, lr}
	
	mov r4, r0
	
Continue:
	@ r5 = Init Routine, r6 = Popup Def, r7 = Time; [r4, #0x2C]++
	ldr   r1, [r4, #0x2C]
	ldmia r1!, {r5-r7}
	str   r1, [r4, #0x2C]
	
	@ Checks for null routine (which would mark the end)
	
	cmp r5, #0
	beq Finish
	
	@ Calling Test/Init routine
	
	mov r1, r5
	bl BXR1
	
	@ If test results false, continue
	
	cmp r0, #0
	beq Continue
	
	@ Making Popup
	
	mov r0, r6 @ arg r0 = Popup Definition
	mov r1, r7 @ arg r1 = Time
	mov r2, #0 @ arg r2 = Win Style (0)
	mov r3, r4 @ arg r3 = Parent 6C
	
	_blh prPopup_MakeSimple, r5
	
	@ Breaking current loop (will only take effect after the popup will be destroyed. allows a 8 frame delay between each popup)
	
	mov r0, r4
	_blh pr6C_BreakLoop
	
	b End
	
Finish:
	mov r0, r4
	mov r1, #1
	
	_blh pr6C_GotoLabel
	
End:
	pop {r4-r7}
	
	pop {r1}
BXR1:
	bx r1

.ltorg
.align

EALiterals:
	@ nothing
