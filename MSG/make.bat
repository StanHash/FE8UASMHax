@echo off

set SOURCEFILE=Main.event
set CLEANROM=FE8_CLEAN_U.gba
set OUTPUTROM=HACK.gba

cd %~dp0
copy "%CLEANROM%" "%OUTPUTROM%"

cd "%~dp0EventAssembler"
Core A FE8 "-output:%~dp0%OUTPUTROM%" "-input:%~dp0%SOURCEFILE%"

pause
