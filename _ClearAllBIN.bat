@echo off

rem _ClearAllBIN.bat

echo Deleting ASM binaries...

for /R %%F in (*.bin) do (
	del %%F
)

for /R %%F in (*.elf) do (
	del %%F
)

for /R %%F in (*.bin.event) do (
	del %%F
)

pause
