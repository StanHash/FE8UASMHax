.thumb
.include "_Definitions.h.s"

push {r4, lr}

mov r4, r1

mov r0, r2

_blh prString_FromIdToStdBuffer

mov r1, r0
mov r0, r4

_blh prText_AppendString

pop {r4}

pop {r1}
bx r1

.ltorg
.align
