.thumb
.include "_Definitions.h.s"

push {r4, lr}
add sp, #-0x10

mov r4, r1

ldr r0, =pPopupNumber
ldr r0, [r0]

mov r1, sp

_blh prString_FromNumber

mov r0, r4
mov r1, sp

_blh prText_AppendString

add sp, #+0x10
pop {r4}

pop {r1}
bx r1

.ltorg
.align
