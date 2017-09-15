.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = Popup 6C, r1 = Text Struct, r2 = Argument

push {lr}

mov r0, r1
mov r1, r2

_blh prText_AdvanceCursor

pop {r1}
bx r1

.ltorg
.align
