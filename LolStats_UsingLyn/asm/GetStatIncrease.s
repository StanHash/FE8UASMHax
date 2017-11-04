.thumb

.global GetStatIncrease
.type   GetStatIncrease, %function

@ Arguments: r0 = Growth
@ Returns: r0 = Stat Increase
GetStatIncrease:
	push {r4-r5, lr}
	
	mov r4, r0
	mov r5, #0
	
Continue:
	ldr r3, =NextRN_100
	mov lr, r3
	.short 0xF800
	
	sub r4, r0 @ r4 = (r4 - RN100)
	blt End    @ if (r4 < 0) goto End;
	
	add r5, #1 @ stat++
	
	b Continue
	
End:
	mov r0, r5
	
	pop {r4-r5}
	
	pop {r1}
	bx r1
