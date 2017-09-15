.thumb
.include "_Definitions.h.s"

WRankUp_Init:
	push {r4, lr}
	
	@ =============
	@ PART I: CHECK
	@ =============
	
	@ Check Instigator
	
	ldr r0, =pBattleUnitInstiagator
	mov r4, r0
	
	_blh prBattleUnit_ShouldWRankUp
	
	cmp r0, #0
	bne Display
	
	@ Check Target
	
	ldr r0, =pBattleUnitTarget
	mov r4, r0
	
	_blh prBattleUnit_ShouldWRankUp
	
	cmp r0, #0
	beq NoDisplay
	
Display:
	
	@ ==============
	@ PART II: SETUP
	@ ==============
	
	@ r0 = WType
	mov  r0, #0x50
	ldrb r0, [r4, r0]
	
	_blh prPopup_SetShortParam
	
	@ =====================
	@ PART III: RETURN TRUE
	@ =====================
	
	mov r0, #1
	b End
	
NoDisplay:
	mov r0, #0
	
End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ nothing
