.thumb
.include "_Definitions.h.s"

@ Arguments: r0 = Popup 6C, r1 = Argument

@ return Argument;
mov r0, r1
bx lr

.ltorg
.align
