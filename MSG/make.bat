@echo off

set SOURCEFILE=Example.event
set CLEANROM=FE8_U.gba
set OUTPUTROM=HACK.gba

cd %~dp0
(copy "%CLEANROM%" "%OUTPUTROM%") > nul

cd "%~dp0EventAssembler"
Core A FE8 "-output:%~dp0%OUTPUTROM%" "-input:%~dp0%SOURCEFILE%"

pause
