@echo off

REM -------------- Settings (!KEEP SOURCE AND DEST FOLDER SEPARATED!) --------------
set sourceFolder=PATH_TO_YOUR_FOLDER
set destinationFolder=PATH_TO_YOUR_BACKUP_FOLDER
set numOfBackups=5
set excludedFiles= #Separate by commas eg. file1,file2,file3 or keep it empty. Folders work too.
REM ---------------------------------------------------------------------------------

REM Get current date in yyyy-MM-dd format
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set currentDate=%%i

REM Extract folder name from sourceFolder
for %%F in ("%sourceFolder%") do set folderName=%%~nF

REM Zip file name
set zipFile=%folderName%-%currentDate%.zip

REM Prepare exclude parameters for 7-Zip
setlocal enabledelayedexpansion
set excludeParams=
for %%E in (%excludedFiles%) do (
    set excludeParams=!excludeParams! -xr^^^!%%E
)
endlocal & set "excludeParams=%excludeParams%"

REM Start zipping
"C:\Program Files\7-Zip\7z" a "%destinationFolder%\%zipFile%" "%sourceFolder%" -r %excludeParams%

REM Remove old backups
setlocal enabledelayedexpansion
set count=0
for /f "delims=" %%F in ('dir "%destinationFolder%\*.zip" /b /o-d') do (
    set /a count+=1
    if !count! gtr %numOfBackups% del "%destinationFolder%\%%F"
)
endlocal

exit
