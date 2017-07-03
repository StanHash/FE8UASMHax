.thumb
.include "_Definitions.h.s"

.set ReturnOffset, (0x08017E98+1)

@ .org 0x17E72
HookFrom_17E72:
	@ CURRENT STATE:
		@ r4 = Unit Struct
		@ r0-r3 are free
	
	@ r3 = i = 7 (last rank, we doing the thing in reverse order)
	mov r3, #7
	
	@ r2 = &Class.wRanks[0]
	ldr r2, [r4, #4]
	add r2, #0x2C
	
StartLoop:
	@ r0 = Class Base Rank
	add r0, r2, r3
	ldrb r0, [r0]
	
	cmp r0, #0
	beq StoreRank @ Store 0 if class cannot use weapon
	
	@ r1 = Class Base Rank
	mov r1, r0
	
	ldr r0, [r4]
	add r0, #0x14
	add r0, r3
	
	@ r0 = Character Base Rank
	ldrb r0, [r0]
	
	@ Store 0 if Character has not base wRank for that weapon
	cmp r0, #0
	beq StoreRank
	
	@ Store Higher rank
	cmp r0, r1
	bge StoreRank
	
	mov r0, r1
	
StoreRank:
	@ r1 = &(Unit.wRanks[i])
	add r1, r4, r3
	add r1, #0x28
	
	@ Store
	strb r0, [r1]

	sub r3, #1
	bge StartLoop @ branch if r3 >= 0
	
End:
	ldr r3, =ReturnOffset
	bx r3

.ltorg
.align

EALiterals:
	@ nothing
