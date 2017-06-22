.thumb
.include "_Definitions.h.s"

.set prMakeTargetList,      EALiterals+0x00
.set prCommandAvailability, EALiterals+0x04

TargetCommandUsability:
	push {lr}
	
	@ First, we need to check whether the active unit can use our command
	@ -------------------------------------------------------------------
	
	@ Loading Active Unit in r0
	ldr r3, =ppActiveUnit
	ldr r0, [r3]
	
	@ Checking if the command is available for active unit
	ldr r3, prCommandAvailability
	_blr r3
	
	@ If not available, return non usable
	cmp r0, #0
	beq ReturnNotUsable
	
	@ Now we need to check for the target list to not be empty
	@ --------------------------------------------------------
	
	@ Loading Active Unit again
	ldr r3, =ppActiveUnit
	ldr r0, [r3]
	
	@ Making our target list
	ldr r3, prMakeTargetList
	_blr r3
	
	@ Getting target list size
	_blh prGetTargetListSize
	
	@ If not targets, then command is unusable
	cmp r0, #0
	beq ReturnNotUsable
	
	@ Return Usable
	mov r0, #1
	b End
	
ReturnNotUsable:
	mov r0, #3
	
End:
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prMakeTargetList
	@ POIN prCommandAvailability
