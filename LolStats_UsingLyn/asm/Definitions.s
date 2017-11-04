
.macro SET_FUNC name, value
	.global \name
	.type   \name, %function
	.set    \name, \value
.endm

SET_FUNC NextRN_100,      (0x08000C64+1)
SET_FUNC GetStatIncrease, (0x0802B9A0+1)
