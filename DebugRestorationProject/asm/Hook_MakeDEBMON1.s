.thumb
.include "_Definitions.h.s"

@ .org 0803103C

push {lr}

ldr r0, EALiterals
mov r1, #3

_blh pr6C_New

@ Replaced shit
	mov  r1, #0x14
	ldsh r0, [r4, r1]
	lsl  r0, #4
	_blh #0x08015A40
	strh r0, [r4, #0x0C]

pop {pc}

.ltorg
.align

EALiterals:
	@ POIN p6C_DEBMON
