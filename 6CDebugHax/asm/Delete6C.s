.thumb

@ 6C Destruction Fix: Stores 0 to name pointer on deallocation, useful for not mixing up different 6Cs when using the script
@ inject through BL at 0x2D48

@ Replaced:
str r5, [r4]
str r5, [r4, #0xC]

@ Added: Sets Name to Null
str r5, [r4, #0x10]

@ Return
bx lr
