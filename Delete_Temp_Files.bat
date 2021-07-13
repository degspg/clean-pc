pushd "%~dp0"

@echo off
setlocal ENABLEDELAYEDEXPANSION

set /A total_count=0
set /A clean_count=0
set /A skip_count=0

echo STARTING CLEANING OF TEMP DIRECTORIES...

for /d %%d in ("%TEMP%\" "%WINDIR%\Temp\" "%WINDIR%\SoftwareDistribution\Download\") do (
	if exist %%d (
		echo CLEANING %%d...

		del /q "%%d" >nul 2>nul
		for /d %%x in (%%d) do @rd /s /q "%%x" >nul 2>nul

		echo CLEANED %%d 

		set /A clean_count=clean_count+1

		rem Uncomment the below to open Explorer windows for each cleared temp directory. 
		rem Explorer %%d
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

Rem %TEMP% is the user's known temporary data directory. Typically, 'C:\Users\<user>\AppData\Local\Temp'. 
Rem %WINDIR% is the systems's known Windows directory. Typically, 'C:\Windows'.  

Rem Commands are in pairs of a 'del' command and a 'for' command. 
Rem First 'del' line in each pair deletes every file in the selected path,
Rem and does not ask you if it's OK to delete on global wildcard. 
Rem Second 'for' line uses a for-loop to delete all directories and their files in the selected path.