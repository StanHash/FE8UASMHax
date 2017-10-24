.thumb
.include "_Definitions.h.s"

@ THE PLAN:
@ SUB 0 = Rescue
@ SUB 1 = Drop

Event_Rescue:
	push {r4-r6, lr}
	
	@ VARIABLES:
	@ r4 is Event Cursor
	@ r5 is Rescuer
	@ r6 is Rescuee
	
	@ r1 = Event Cursor
	ldr r4, [r0, #0x38]
	
	ldrh r2, [r4]
	
	@ r3 = event subcode
	mov r3, #0xF
	and r3, r2
	
	cmp r3, #0
	bne HandleDrop
HandleRescue:
	ldrh r0, [r4, #2]
	_blh prUnit_GetFromEventParam
	
	mov r5, r0
	beq End @ Return if no Unit
	
	ldrh r0, [r4, #4]
	_blh prUnit_GetFromEventParam
	
	mov r6, r0
	beq End @ Return if no Unit
	
	@ r0 is unit being rescued
	_blh #0x08037A6C @ TryRemoveFromBallista
	
	mov r0, r5
	mov r1, r6
	
	_blh #0x0801834C @ Rescue
	
	mov r0, r6
	
	_blh #0x0802810C @ Hide Unit (probably)
	
	b End
	
HandleDrop:
	
	
End:
	mov r0, #0 @ Advance And Continue
	
	pop {r4-r6}
	
	pop {r1}
	bx r1
@rescue ASMC
@expects coordinates of rescuing unit in Slot 0x1 (0xYYYYXXXX)
@and rescuee in Slot 0x2 (0xYYYYXXXX)

@ .thumb
@ .org 0

@ push {r4-r5,lr}
@ ldr r2, =0x30004bc @slot 1
@ ldrh r0,[r2]    @x coords
@ ldrh r1,[r2,#2] @y coords
@ bl GetUnitFromCoords
@ cmp r0,#0
@ beq End
@ ldr r5, =0x8019430 @turn deployment no into ram ptr
@ mov lr,r5
@ .short 0xf800
@ mov r4,r0 @save rescuer's ram
@ ldr r2, =0x30004c0 @slot 2
@ ldrh r0,[r2]
@ ldrh r1,[r2,#2]
@ bl GetUnitFromCoords
@ cmp r0,#0
@ beq End
@ mov lr,r5
@ .short 0xf800
@ mov r1,r0 @rescuee in r1
@ mov r0,r4 @rescuer in r0
@ ldr r3,=0x801834c @rescue routine
@ mov  lr,r3
@ .short 0xf800

@ End:
	@ pop {r4-r5}
	@ pop {r0}
	@ bx r0

@ GetUnitFromCoords:
	@ gets deployment number, given r0=x and r1=y
	@ ldr r2, =0x202e4d8 @pointer to unit map
	@ ldr r2, [r2]
	@ lsl r1, #2 @ y*4
	@ add r1, r2 @ row address
	@ ldr r1, [r1]
	@ ldrb r0, [r1, r0]
	@ bx lr
