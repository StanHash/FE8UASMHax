Modular Stat Getters allows you to customize the stat computation "pipeline" (no actual pipelining involved because lol multitasking on gba). In other words, you can specify a list of "modifier" routines to allow you to easily add on the stat calculation.

This was originally made allow the adding of stat boosts coming from held items or skils (see circles' skill system) without having to rewrite the entire stat getters.

Example.event is the example file. It contains definitions for Vanilla Stat Getter Behaviour.

To Install, include InstallBLRange.event while EA is in BL Range (inBLRange should be defined), and Install.event wherever else. You also need to specify your stat getter modifier arrays, see Example.event for an example (Ask me (StanH_) about it on the forum or the Discord if you don't understand it).

THE MASTER DOC (Includes a Guide!):
	https://stackedit.io/viewer#!provider=gist&gistId=73fe46bb53a0b20bf2a6b963f6e2b3db&filename=MSGDoc
