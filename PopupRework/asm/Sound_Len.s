.thumb
.include "_Definitions.h.s"

mov  r2, #0x48
strh r1, [r0, r2]

mov r0, #0

bx lr

.ltorg
.align
