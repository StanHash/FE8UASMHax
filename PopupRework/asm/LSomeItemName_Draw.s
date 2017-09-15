.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = Popup 6C, r1 = Text Struct, r2 = Argument

push {r4, lr}

mov r4, r1

ldr  r0, =pPopupShortArgument
ldrh r0, [r0]

mov r1, #0

_blh prItem_GetSomeString

mov r1, r0
mov r0, r4

_blh prText_AppendString

pop {r4}

pop {r1}
bx r1

.ltorg
.align
