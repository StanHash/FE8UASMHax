.thumb

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

.set NextRN_100, 0x08000C64

@ Arguments: r0 = Growth
@ Returns: r0 = Stat Increase
GetStatIncrease:
	push {r4-r5, lr}
	
	mov r4, r0
	mov r5, #0
	
Continue:
	_blh NextRN_100
	
	sub r4, r0 @ r4 = (r4 - RN100)
	blt End    @ if (r4 < 0) goto End;
	
	add r5, #1 @ stat++
	
	b Continue
	
End:
	mov r0, r5
	
	pop {r4-r5}
	
	pop {r1}
	bx r1
