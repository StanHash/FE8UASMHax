@echo off

rem _AssembleAll.bat: assembles all .s files in folder & subfolders

set DEVKITARM=C:\devkitPro\devkitARM\arm-none-eabi\bin\

set as="%DEVKITARM%as"
set nm="%DEVKITARM%nm"
set objcopy="%DEVKITARM%objcopy"

set INCLUDE=%~dp0_StanHaxCommon\asm

set FILE_MATCH=*.s
set ASSEMBLE_BAT=%~dp0_AssembleARM.bat
set BIN2EA=%~dp0__Tools\bin2ea.exe

for /R %%F in (%FILE_MATCH%) do (
	cd %%~dpF
	
	@rem Assemble into an elf
	%as% -g -mcpu=arm7tdmi -mthumb-interwork -I "%INCLUDE%" %%F -o "%%~nF.elf"

	@rem Loading Undefined Symbol list into the _undefinedSymbols variable
	(%nm% -u "%%~nF.elf") > undeftemp.txt
	set /p _undefinedSymbols= < undeftemp.txt
	echo y | del undeftemp.txt

	if "%_undefinedSymbols%" equ "" (
		@rem if the undefined symbol list is empty, then no error its fine we build and all
		%objcopy% -S "%%~nF.elf" -O binary "%%~nF.bin"
	) else (
		@rem else, we display the names of the bad guys
		echo ERROR while assembling "%%~nxF": Found some undefined symbols: >&2
		echo %_undefinedSymbols% >&2
	)

	@rem we also delete the elf, cause that's just a waste of space at this point
	REM echo y | del "%%~nF.elf"
)

pause
