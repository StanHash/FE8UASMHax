.thumb
.include "_Definitions.h.s"

push {lr}

mov r0, r1

_blh prString_FromIdToStdBuffer
_blh prString_GetTextWidth

pop {r1}
bx r1

.ltorg
.align
