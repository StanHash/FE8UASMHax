.thumb

.equ ConditionRoutinePtr, EALiterals+0x00
.equ ModifierRoutine,     EALiterals+0x04

ExecIf:
	push {r4-r5, lr}
	
	push {r0-r2} @ Storing arguments for ModifierRoutine
		
		@ Calling condition
		ldr r3, ConditionRoutinePtr
		mov lr, r3
		.short 0xF800
		
		mov r3, r0
		
	pop {r0-r2} @ Loading arguments for ModifierRoutine
	
	cmp r3, #0
	beq End
	
	bl ModifierRoutine
	
End:
	pop {r4-r5, pc}

.ltorg
.align

EALiterals:
	@ POIN pCondition
	@ WORD conditionArgument
	@ Insert Exec routine
