.thumb
.include "_Definitions.h.s"

push {lr}
add sp, #-0x10

ldr r0, =pPopupNumber
ldr r0, [r0]

mov r1, sp

_blh prString_FromNumber

lsl r0, #3

add sp, #+0x10

pop {r1}
bx r1

.ltorg
.align
