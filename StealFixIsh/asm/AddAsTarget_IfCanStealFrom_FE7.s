.set origin,       (0x080244AC)

.set GetUnitSpeed, (. + 0x08018B30 - origin)
.set IsItemItem,   (. + 0x08016D38 - origin)
.set AddTarget,    (. + 0x0804ACFC - origin)

.set ppActiveUnit, (0x03004690)

.include "AddAsTarget_IfCanStealFrom_Common.asm"
