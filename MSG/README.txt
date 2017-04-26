Modular Stat Getters allows you to customize the stat computation "pipeline" (no actual pipelining involved because lol multitasking on gba). In other words, you can specify a list of "modifier" routines to allow you to easily add on the stat calculation.

This was originally made allow the adding of stat boosts coming from held items or skils (see circles' skill system) without having to rewrite the entire stat getters.

Example.event is the example file. It contains definitions for Vanilla Stat Getter Behaviour.

To Install, include InstallBLRange.event while EA is in BL Range (inBLRange should be defined), and Install.event wherever else. You also need to specify your stat getter modifier arrays, see Example.event for an example (Ask me (StanH_) about it on the forum or the Discord if you don't understand it).

STAT GETTER MODIFIER ARRAY:
	The Stat Getter Modifier Array is an null terminated array of routine pointers that returns the modified stat given its arguments (see below for specific details).
	Ex: POIN prGetUnitPow prGetEquipPow p

THE ARM MACRO:
	"prARM(routinePtr)" is equivalent to "(routinePtr | 1)", it is used to specify that a pointer is of an ARM routine (most if not all routines here are thumb, so you probably won't need it).
	WARN: do not use it outside of MSG unless specified. MSG exceptionally reverts the last bit of the pointer to default to thumb, but most other stuff do not.

UNDERSTANDING MY DEFINITION PREFIXES:
	pSomething:  'p'  = *p*ointers/offsets
	rSomething:  'r'  = *r*outines (as in actual routine data, not pointers)
	prSomething: 'pr' = *p*ointer to *r*outine
	aSomething:  'a'  = *a*rgument (as in macro argument)

[TODO: write doc for modifier helper stuff]

*** WARNING: TECHNICAL ASM STUFF ***

STAT MODIFIERS ROUTINES:
	Arguments: r0 = current stat value, r1 = ram unit struct ptr
	Returns: r0 = modified stat value

CONDITIONAL ROUTINES:
	Arguments: r0 = current stat value, r1 = ram unit struct ptr, r2 = extra argument (Set using rIf macro)
	Returns: r0 = boolean (0 or 1)
