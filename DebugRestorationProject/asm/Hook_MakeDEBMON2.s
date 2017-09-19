.thumb
.include "_Definitions.h.s"

@ .org 08030F88

push {lr}

ldr r0, EALiterals
mov r1, #3

_blh pr6C_New

@ REPLACED SHIT
	_blh #0x0802E3A8 @ AddSnagsAndWalls
	_blh #0x08037910 @ LoadChapterBallistae
	_blh #0x08030174

pop {pc}

.ltorg
.align

EALiterals:
	@ POIN p6C_DEBMON
