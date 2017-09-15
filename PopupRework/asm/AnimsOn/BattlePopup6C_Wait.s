.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = popup
BattlePopup6C_Wait:
	push {r4-r7, lr}
	
	mov r4, r0
	
	mov  r1, #0x30
	ldsh r1, [r4, r1]
	
	cmp r1, #0
	blt HandleKeyPresses @ counter < 0  =>  check for key presses
	beq Finish           @ counter = 0  =>  end
	
	sub  r1, #1
	strh r1, [r4, #0x30]
	
	b End
	
HandleKeyPresses:
	ldr  r3, =pKeyStatusBuffer
	ldrh r3, [r3, #8] @ new presses
	
	cmp r3, #0
	beq End
	
Finish:
	mov r0, r4
	_blh pr6C_BreakLoop
	
	ldr r0, [r4, #0x50]
	_blh prAIS_Free
	
	_blh prBG1_Clear
	
End:
	pop {r4-r7}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ nothing
