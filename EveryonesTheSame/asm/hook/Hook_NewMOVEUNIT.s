.thumb
.include "_Definitions.h.s"

.set prGetClassDefaultMovingMapSprite, EALiterals+0x00

@ .org 0x0785F0
Hook_NewMOVEUNIT:
	@ State:
		@ r0 = pointer to where we want to store moving map sprite index at
		@ r1 = sp
		@ r2 = garanteed 0
		@ r3 = used by callHack_r3 (normally 0)
		@ r5 = MOVEUNIT 6C
		@ lr = return address
	
	mov r3, #0
	
	push {r0-r5}
	mov r4, lr @ Saving lr
		@ r5 = Map Sprite Entry Stack Pointer (currently class)
		add r5, r1, #4

		ldrb r0, [r5] @ Loading class id
		
		@ Getting moving map sprite
		ldr  r3, prGetClassDefaultMovingMapSprite
		_blr r3
		
		@ Storing moving map sprite
		strb r0, [r5]
	mov lr, r4 @ Loading lr
	pop {r0-r5}
	
	@ REPLACED STUFF BEGIN
		ldrb r1, [r1, #4]
		strb r1, [r0]
		
		sub  r0, #1   @ r0 = Struct+0x40
		strb r3, [r0] @ r3 = 0

		lsl r0, r5, #5      @ r0 = r5 * 0x20 = 0x380 * 0x20 = 0x7000
		ldr r4, =#0x6010000 @ Start of Obj tiles VRAM
		add r0, r0, r4      @ r0 = 0x6017000
	@ REPLACED STUFF END

	bx lr

.ltorg
.align

EALiterals:
	@ POIN prGetClassDefaultMovingMapSprite
