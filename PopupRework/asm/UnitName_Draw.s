.thumb
.include "_Definitions.h.s"

push {r4, lr}

mov r4, r1

ldr  r0, =ppPopupUnit
ldr  r0, [r0] @ r0 = Popup Unit Pointer
ldr  r0, [r0] @ r0 = Popup Char Pointer
ldrh r0, [r0] @ r0 = Popup Char Name Id

_blh prString_FromIdToStdBuffer

mov r1, r0
mov r0, r4

_blh prText_AppendString

pop {r4}

pop {r1}
bx r1

.ltorg
.align
