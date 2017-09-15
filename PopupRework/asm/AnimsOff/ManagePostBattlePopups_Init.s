.thumb
.include "_Definitions.h.s"

.set lpBattlePopupShowupTable, (EALiterals+0x00)

ManagePostBattlePopups_Init:
	ldr r1, lpBattlePopupShowupTable
	str r1, [r0, #0x2C]
	
	bx lr

.ltorg
.align

EALiterals:
	@ POIN pBattlePopupShowupTable
