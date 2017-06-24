@echo off

REM EDIT THE FOLLOWING LINES IF YOU WISH TO BUILD THIS AT HOME

	set StartDir=C:\devkitPro\devkitARM\arm-none-eabi\bin\

	set as="%StartDir%as"
	set nm="%StartDir%nm"
	set objcopy="%StartDir%objcopy"

REM END OF CUSTOM ENV EDITS

set IncludeDir=%~dp0_StanHaxCommon\asm

@rem Assemble into an elf
%as% -g -mcpu=arm7tdmi -mthumb-interwork -I "%IncludeDir%" %1 -o "%~n1.elf"

@rem Loading Undefined Symbol list into the _undefinedSymbols variable
(%nm% -u "%~n1.elf") > _#_#_#_#_#_temp.txt
set /p _undefinedSymbols= < _#_#_#_#_#_temp.txt
echo y | del _#_#_#_#_#_temp.txt

if ["%_undefinedSymbols%"] equ [""] (
	@rem if the undefined symbol list is empty, then no error its fine we build and all
	%objcopy% -S "%~n1.elf" -O binary "%~n1.bin"
) else (
	@rem else, we display the names of the bad guys
    echo ERROR: Found some undefined symbols: >&2
    echo %_undefinedSymbols% >&2
)

@rem we also delete the elf, cause that's just a waste of space at this point
echo y | del "%~n1.elf"
pause
