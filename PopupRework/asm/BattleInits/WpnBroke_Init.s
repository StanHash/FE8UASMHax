.thumb
.include "_Definitions.h.s"

WpnBroke_Init:
	push {r4, lr}
	
	@ =============
	@ PART I: CHECK
	@ =============
	
	@ Check Instigator
	
	ldr r0, =pBattleUnitInstiagator
	mov r4, r0
	
	_blh prBattleUnit_ShouldWpnBroke
	
	cmp r0, #0
	bne Display
	
	@ Check Target
	
	ldr r0, =pBattleUnitTarget
	mov r4, r0
	
	_blh prBattleUnit_ShouldWpnBroke
	
	cmp r0, #0
	beq NoDisplay
	
Display:
	
	@ ==============
	@ PART II: SETUP
	@ ==============
	
	@ r0 = Item Short
	mov  r0, #0x4A
	ldrh r0, [r4, r0]
	
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
