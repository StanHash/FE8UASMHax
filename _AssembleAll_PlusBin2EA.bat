@echo off

rem _AssembleAll.bat: Calls _AssembleARM.bat for all .s files in folder & subfolders

set FILE_MATCH=*.s
set ASSEMBLE_BAT=%~dp0_AssembleARM.bat
set BIN2EA=%~dp0__Tools\bin2ea.exe

for /R %%F in (%FILE_MATCH%) do (
	echo Assembling "%%~nxF"...
	cd %%~dpF
	(echo: | (call %ASSEMBLE_BAT% %%~nxF)) > nul
	(%BIN2EA% "%%~nF.bin" "%%~nF.bin.event" -short) > nul
)

pause
