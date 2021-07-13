pushd "%~dp0"

@echo off
setlocal ENABLEDELAYEDEXPANSION

set /A total_count=0
set /A clean_count=0
set /A skip_count=0

for %%d in ("%PROGRAMDATA%\NVIDIA Corporation\NV_Cache" "%LOCALAPPDATA%\NVIDIA\GLCache" "%LOCALAPPDATA%\D3DSCache") do (
	if exist %%d (
		echo CLEANING %%d...

		del /q %%d >nul 2>nul
		for /d %%x in (%%d) do @rd /s /q "%%x" >nul 2>nul

		echo CLEANED %%d!
		set /A clean_count=clean_count+1
	) else (
		echo %%d DOES NOT EXIST. SKIPPING^^!
		set /A skip_count=skip_count+1
	)
	set /A total_count=total_count+1
)

echo CLEANING FINISHED!

if !clean_count! geq 1 (
	set suffix=DIRECTORIES
	if !clean_count! EQU 1 set suffix=DIRECTORY
	echo CLEANED !clean_count!/!total_count! !suffix!^^!
)
if !skip_count! geq 1 (
	set suffix=DIRECTORIES
	if !skip_count! EQU 1 set suffix=DIRECTORY
	echo SKIPPED !skip_count!/!total_count! !suffix!^^!
)

pause

Rem %PROGRAMDATA% is the system's known ProgramData directory. Typically, 'C:\ProgramData'. 
Rem %LOCALAPPDATA% is the current user's 'AppData\Local' directory. Typically, 'C:\Users\<username>\AppData\Local'.

Rem The `for` loop interates over the directories captured in the parenthesises 
Rem The inner commands are a 'del' command and another 'for' command. 
Rem First, 'del' deletes every file in the selected directory and does not ask you if it's OK to delete on global wildcard. 
Rem Second, the inner 'for' loop deletes all sub-directories and their files in the selected directory. 