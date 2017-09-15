.thumb
.include "_Definitions.h.s"

push {lr}

ldr  r0, =ppPopupUnit
ldr  r0, [r0] @ r0 = Popup Unit Pointer
ldr  r0, [r0] @ r0 = Popup Char Pointer
ldrh r0, [r0] @ r0 = Popup Char Name Id

_blh prString_FromIdToStdBuffer
_blh prString_GetTextWidth

pop {r1}
bx r1

.ltorg
.align
