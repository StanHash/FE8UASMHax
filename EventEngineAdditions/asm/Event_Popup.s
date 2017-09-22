.thumb
.include "_Definitions.h.s"

@ THE PLAN:
@ POPUP_ITEM   <Item>     @ SHORT 0xID20 Item
@ POPUP_UNIT   <Char>     @ SHORT 0xID21 Char
@ POPUP_NUMBER <Number>   @ SHORT 0xID42 0000;   WORD Number
@ POPUP_CALL <Time> <Def> @ SHORT 0xID43 <Time>; POIN Def

Event_Popup:
	push {r4, lr}
	
	mov r3, r0 @ r3 = Event Engine 6C
	
	ldr r1, [r3, #0x38] @ r1 = Current Event Pointer
	
	ldrh r0, [r1]
	mov r2, #0xF
	and r0, r2
	
	cmp r0, #0
	beq POPUP_ITEM
	
	cmp r0, #1
	beq POPUP_UNIT
	
	cmp r0, #2
	beq POPUP_NUMBER
	
	cmp r0, #3
	beq POPUP_CALL
	
	b End
	
POPUP_ITEM:
	ldrh r0, [r1, #2]
	
	cmp r0, #0
	bge POPUP_ITEM_DontLoadFromSlot2
	
	ldr r0, =pEventSlot0
	ldr r0, [r0, #8]

POPUP_ITEM_DontLoadFromSlot2:
	_blh prPopup_SetShortParam
	
	mov r0, #0
	b End

POPUP_UNIT:
	ldrh r0, [r1, #2]
	
	_blh prUnit_GetFromEventParam
	_blh prPopup_SetUnitParam
	
	mov r0, #0
	b End

POPUP_NUMBER:
	ldr r0, [r1, #4]
	
	cmp r0, #0
	bge POPUP_NUMBER_DontLoadFromSlot2
	
	ldr r0, =pEventSlot0
	ldr r0, [r0, #8]
	
POPUP_NUMBER_DontLoadFromSlot2:
	_blh prPopup_SetNumberParam
	
	mov r0, #0
	b End

POPUP_CALL:
	ldr  r0, [r1, #4] @ r0 = Popup Def Pointer
	
	cmp r0, #0
	bge POPUP_CALL_DontLoadPopupFromSlot2
	
	ldr r0, =pEventSlot0
	ldr r0, [r0, #8]
	
POPUP_CALL_DontLoadPopupFromSlot2:
	ldrh r1, [r1, #2] @ r1 = Time
	mov  r2, #0       @ r2 = Style
	@ r3 = Event Engine 6C
	
	_blh prPopup_MakeSimple, r4
	
	mov r0, #2 @ Advance & Yield
	
End:
	pop {r4}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ nothing
