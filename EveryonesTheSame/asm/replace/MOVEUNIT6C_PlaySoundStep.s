.thumb
.include "_Definitions.h.s"

.set prNewStepSound, 0x0807883C

.set prMMS_GetStepSoundPtr, EALiterals+0x00

@ .org 0x078D6C
MOVEUNIT6C_PlaySoundStep:
	push {r4-r6, lr}
	add sp, #-0x04
	
	@ r4 = MOVEUNIT 6C
	mov r4, r0
	
	@ r0 = MMS Index
	add  r0, #0x41
	ldrb r0, [r0]
	
	ldr r3, prMMS_GetStepSoundPtr
	_blr r3
	
	@ r5 = Step Sound Thing Pointer
	mov r5, r0
	
	mov r1, r4
	add r1, #0x43
	
	@ Incrementing thing at MOVEUNIT6C+0x43
	ldrb r0, [r1]
	add  r2, r0, #1
	strb r2, [r1]
	
	ldrh r1, [r5]
	
	@ r0 = r0 % r1
	_blh prSVCModulo
	
	@ r0 = Current Sound Index Thing
	add r0, #2
	lsl r0, #1
	add r0, r5
	
	ldrh r0, [r0]
	
	@ if 0, no sound to be played
	cmp r0, #0
	beq End
	
	@ r6 = Current Thing
	mov r6, r0
	
	mov r0, r4
	mov r1, sp
	
	_blh prMOVEUNIT_GetDisplayPos
	
	mov r2, #0
	mov r3, sp
	
	ldsh r2, [r3, r2]
	ldrh r1, [r5, #2]
	mov  r0, r6
	
	_blh prNewStepSound
	
End:
	add sp, #0x04
	pop {r4-r6}
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN prMMS_GetStepSoundPtr
