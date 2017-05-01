@echo off

rem _ClearAll.bat

for /R %%F in (*.elf) do (
	del %%F
)

for /R %%F in (*.bin) do (
	echo Deleting "%%~nxF"...
	del %%F
)

pause
