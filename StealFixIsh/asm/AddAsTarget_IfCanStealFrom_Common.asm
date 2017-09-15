.thumb

@ .org origin
AddAsTarget_IfCanStealFrom:
	push {r4-r6, lr}
	
	@ r5 = Target Unit
	mov r5, r0
	
	@ r0 = Unit Index
	ldrb r0, [r5, #0xB]
	
	@ r0 = 0x00 = Ally, 0x40 = NPC, 0x80 = Enemy
	mov r1, #0xC0
	and r0, r1
	
	cmp r0, #0x80
	bne End
	
	ldr r0, =ppActiveUnit
	ldr r0, [r0]
	
	bl GetUnitSpeed
	
	mov r4, r0
	mov r0, r5
	
	bl GetUnitSpeed
	
	cmp r4, r0
	blt End
	
	mov r6, r5
	add r6, #0x1E
	
	mov r4, #5
	
StartItemCheck:
	ldrh r0, [r6]
	
	cmp r0, #0
	beq End
	
	bl IsItemItem @ lol
	
	cmp r0, #0
	beq ContinueItemCheck
	
	ldrb r0, [r5, #0x10]
	ldrb r1, [r5, #0x11]
	ldrb r2, [r5, #0x0B]
	mov r3, #0
	
	bl AddTarget
	
	b End
	
ContinueItemCheck:
	add r6, #2
	sub r4, #1
	bgt StartItemCheck
	
End:
	pop {r4-r6}
	pop {r0}
	bx r0

.ltorg
.align

@ Full Size: 0x54 (originally 0x60, so we can insert this inline)
