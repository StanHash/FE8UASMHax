.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = Popup 6C, r1 = Argument

push {lr}

ldr  r0, =pPopupShortArgument
ldrh r0, [r0]

mov r1, #0

_blh prItem_GetSomeString
_blh prString_GetTextWidth

pop {r1}
bx r1

.ltorg
.align
