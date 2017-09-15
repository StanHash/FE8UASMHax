.thumb

TestStaff_Usability:
	mov r0, #1 @ TRUE
	
	ldr r3, =#(0x08028BFE+1)
	bx r3

.ltorg
.align

EALiterals:
	@ notin
