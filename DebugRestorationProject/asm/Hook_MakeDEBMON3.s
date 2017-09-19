.thumb
.include "_Definitions.h.s"

@ .org 08030E94

push {lr}

@ REPLACED SHIT
	_blh #0x080194BC @ InitChapterMap

ldr r0, EALiterals
mov r1, #3

_blh pr6C_New

@ REPLACED SHIT
	_blh #0x0802E3A8 @ AddSnagsAndWalls
	_blh #0x08000D28 @ GetGlobalClock

pop {pc}

.ltorg
.align

EALiterals:
	@ POIN p6C_DEBMON
