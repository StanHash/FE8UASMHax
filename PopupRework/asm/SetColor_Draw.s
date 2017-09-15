.thumb
.include "_Definitions.h.s"

push {lr}

mov r0, r1
mov r1, r2

_blh prText_SetColor

pop {r1}
bx r1

.ltorg
.align
