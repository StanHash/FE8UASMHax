@echo off

REM EDIT THE FOLLOWING LINES IF YOU WISH TO BUILD THIS AT HOME

	set StartDir=C:\devkitPro\devkitARM\arm-none-eabi\bin\

	set as="%StartDir%as"

REM END OF CUSTOM ENV EDITS

set IncludeDir=%~dp0_StanHaxCommon\asm

@rem Assemble into an elf
%as% -g -mcpu=arm7tdmi -mthumb-interwork -I "%IncludeDir%" %1 -o "%~n1.elf"

pause
