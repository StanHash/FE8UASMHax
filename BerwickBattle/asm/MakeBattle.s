.thumb
.include "fe8.inc"

.set ClearBattleRounds,     0x0802AE90
.set GetBattleUnitPointers, 0x0802AF7C
.set MakeBattleRound,       0x0802B018

.set EAL_prPlusModifierGetter, (EALiterals+0x00)

@ .org 0x02AED0
MakeBattle:
	push {r4-r7, lr}
	add sp, #-0x08
	
	@ VARIABLE ALLOCATION:
	@ r4 is ppBattleCurrentRound (gtg fst)
	@ r5 is last checked round it
	@ r6 is initializer + modifier (counting down)
	@ r7 is target + modifier (counting down)
	
	_blh ClearBattleRounds
	
	mov r0, sp     @ arg r0 = BattleUnit** First
	add r1, sp, #4 @ arg r1 = BattleUnit** Second
	
	_blh GetBattleUnitPointers
	
	ldr r4, =ppBattleCurrentRound
	
	@ Gettig Attacker "+ Modifier"
	ldr r0, [sp, #0]
	ldr r1, [sp, #4]
	ldr r3, EAL_prPlusModifierGetter
	bl  BXR3
	mov r6, r0
	
	@ Getting Defender "+ Modifier"
	ldr r0, [sp, #4]
	ldr r1, [sp, #0]
	ldr r3, EAL_prPlusModifierGetter
	bl  BXR3
	mov r7, r0
	
StartPlusRound:
	cmp r6, #0
	ble Finish
	
	@ AttackerPlus--
	sub r6, #1
	
	@ Saving current round for further check
	ldr r5, [r4]
	
	ldr r0, [sp, #0]
	ldr r1, [sp, #4]
	
	_blh MakeBattleRound
	
	@ If is the end, the go to end
	cmp r0, #0
	bne Finish
	
	cmp r7, #0
	ble StartPlusRound
	
	@ DefenderPlus--
	sub r7, #1
	
	@ Check for hit between last round, and current one
	mov r0, r5
	ldr r1, [r4]
	
	bl CheckForHit
	
	@ If there's a hit, ignore counter
	cmp r0, #0
	bne StartPlusRound
	
	@ Saving current round for further check
	ldr r5, [r4]
	
	ldr r0, [sp, #4]
	ldr r1, [sp, #0]
	
	_blh MakeBattleRound
	
	cmp r0, #0
	beq StartPlusRound
	
Finish:
	@ r3 = Last Battle Round Pointer
	ldr  r3, [r4]
	
	@ Marking end of battle
	
	ldrb r1, [r3, #2]
		mov  r0, #7 @ 0b111
		and  r1, r0 @ Only keep the first 3 bits?
		
		mov  r0, #0x80
		orr  r1, r0 @ Orr 0x80?
	strb r1, [r3, #2]
	
	add sp, #+0x08
	pop {r4-r7}
	
	pop {r3}
BXR3:
	bx r3

.ltorg
.align

@ Arguments: r0 = Start Round It, r1 = End Round It
CheckForHit:
	cmp r0, r1
	bge CheckForHit_ReturnFalse
	
CheckForHit_Continue:
	ldmia r0!, {r2}
	
	mov r3, #2 @ Miss flag
	
	tst r2, r3
	beq CheckForHit_ReturnTrue @ Miss flag not set
	
	cmp r0, r1
	blt CheckForHit_Continue @ (++It, End)
	
CheckForHit_ReturnFalse:
	mov r0, #0
	b CheckForHit_End
	
CheckForHit_ReturnTrue:
	mov r0, #1

CheckForHit_End:
	bx lr

.ltorg
.align

EALiterals:
	@ POIN prPlusModifierGetter
