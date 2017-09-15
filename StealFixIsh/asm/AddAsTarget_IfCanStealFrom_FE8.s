.include "_Definitions.h.s"

.set origin,       (0x08025BA0)

.set GetUnitSpeed, (. + prUnit_GetSpeed      - origin)
.set IsItemItem,   (. + prItem_IsItem        - origin)
.set AddTarget,    (. + prAddTargetListEntry - origin)

.include "AddAsTarget_IfCanStealFrom_Common.asm"
