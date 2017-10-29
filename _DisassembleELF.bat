@echo off

REM EDIT THE FOLLOWING LINES IF YOU WISH TO BUILD THIS AT HOME

	set StartDir=C:\devkitPro\devkitARM\arm-none-eabi\bin\

	set objdumb="%StartDir%objdump"

REM END OF CUSTOM ENV EDITS

@rem Assemble into an elf
%objdumb% -d "%1"

pause
