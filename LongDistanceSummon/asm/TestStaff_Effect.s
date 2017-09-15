.thumb

.set prRoutine, EALiterals+0x00

TestStaff_Usability:
	ldr r3, prRoutine
	mov lr, r3
	.short 0xF800
	
	ldr r3, =#(0x08029062+1)
	bx r3

.ltorg
.align

EALiterals:
	@ POIN prRoutine
