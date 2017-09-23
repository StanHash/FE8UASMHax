@echo off

set SOURCEFILE=Main.event
set CLEANROM=FE8_U.gba
set OUTPUTROM=ASM_TESTING.gba

cd %~dp0
(copy "%CLEANROM%" "%OUTPUTROM%") > nul

echo Assembling ASM...

echo: | (call %~dp0_AssembleAll.bat)

echo:

echo Assembling EVENTS...

cd "%~dp0__Tools\EventAssembler"
Core A FE8 "-output:%~dp0%OUTPUTROM%" "-input:%~dp0%SOURCEFILE%"

cd %~dp0
echo: | (call %~dp0_ClearAllBIN.bat) > nul

pause
