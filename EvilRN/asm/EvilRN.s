.thumb

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.set NextRN100, 0x08000C64

@ EvilRN (tm) formula: (Credit to SEVA :) )
@ (3*(A^2)) - ((2*(A^3))/100) = TrueRN*100

@ Original routine offset: 0x08000CB8
@ Args: r0 = chance; Returns: r0 = 1 if hit, 0 if miss
RollHitRN:
	push {r4-r5, lr}
	
	mov r4, r0
	
	_blh NextRN100 @ r0 = A
	
	mov r1, r0 @ r1 = A
	mul r1, r0 @ r1 = A^2
	
	lsl r5, r1, #1 @ r5 = 2*(A^2)
	add r5, r1 @ r5 = 3*(A^2)
	
	mul r1, r0 @ r1 = A^3
	
	lsl r0, r1, #1 @ r0 = 2*(A^3)
	mov r1, #100 @ r1 = 100
	
	mul r4, r1 @ r4 = Chance*100 (doing it here since we have 100 loaded in a register)
	
	svc 6 @ Divide, r0 = (2*(A^3))/100
	
	sub r1, r5, r0 @ r1 = (3*(A^2)) - ((2*(A^3))/100)
	
	mov r0, #0 @ r0 = False by default
	
	@ Comparing Chance*100 to TrueRN*100
	cmp r4, r1
	ble End
	
	mov r0, #1
	
End:
	pop {r4-r5}
	
	pop {r1}
	bx r1
