.thumb

.equ ConditionRoutinePtr, EALiterals+0x00
.equ ConditionArgument,   EALiterals+0x04
.equ ModifierRoutine,     EALiterals+0x08

ExecIf:
	push {r4-r5, lr}
	
	@ Storing Modifier arguments
	mov r4, r0
	mov r5, r1

	ldr r2, ConditionArgument
	
	@ Calling condition
	ldr r3, ConditionRoutinePtr
	mov lr, r3
	.short 0xF800
	
	cmp r0, #0
	beq Skip
	
	mov r0, r4
	mov r1, r5
	bl ModifierRoutine
	
	b End

Skip:
	mov r0, r4
	
End:
	pop {r4-r5}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN pCondition
	@ WORD conditionArgument
	@ Insert Exec routine
