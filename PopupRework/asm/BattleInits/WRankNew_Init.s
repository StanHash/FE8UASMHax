.thumb
.include "_Definitions.h.s"

.set lpWRankToCheck, (EALiterals+0x00)

WRankNew_Init:
	push {r4-r7, lr}
	
	@ =============
	@ PART I: CHECK
	@ =============
	
	ldr r0, =#0x0203E188 @ Some Battle Struct #1 (After Promotion?)
	ldr r0, [r0]
	add r0, #0x28
	
	ldr r1, =#0x0203E18C @ Some Battle Struct #2 (Before Promotion?)
	ldr r1, [r1]
	add r1, #0x28 @ WRanks start
	
	ldr r3, lpWRankToCheck
	
	ldrb r2, [r1, r3]
	
	cmp r2, #0
	bne NoDisplay @ Already had the rank
	
	ldrb r2, [r0, r3]
	
	cmp r2, #0
	beq NoDisplay @ Didn't learn the rank
	
Display:
	@ ==============
	@ PART II: SETUP
	@ ==============
	
	mov r0, r3
	_blh prPopup_SetShortParam
	
	@ =====================
	@ PART III: RETURN TRUE
	@ =====================
	
	mov r0, #1
	b End

NoDisplay:
	mov r0, #0

End:
	pop {r4-r7}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ WORD wrank
