.thumb

@ replaced: 
@ mov  r0, r5
@ add  r0, #0x26
@ strb r1, [r0]
@ add  r0, #2
@ strb r1, [r0]

str  r1, [r5, #0x10]
mov  r0, #0x26
strb r1, [r5, r0]
add  r0, #2
strb r1, [r5, r0]
