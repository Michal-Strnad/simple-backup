@echo off

REM -------------- Settings (!KEEP SOURCE AND DEST FOLDER SEPARATED!) --------------
set sourceFolder=PATH_TO_YOUR_FOLDER
set destinationFolder=PATH_TO_YOUR_BACKUP_FOLDER
REM ---------------------------------------------------------------------------------

REM Get current date in yyyy-MM-dd format
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set currentDate=%%i

REM Get file name of the last modified file
for /f "delims=" %%F in ('dir "%sourceFolder%\*" /b /o-d') do (
    set "lastModifiedFile=%%F"
    goto :fileFound
)
:fileFound

REM Zip file name
set zipFile=backup-%currentDate%.zip

REM Create zip file containing all files except the last modified one
"C:\Program Files\7-Zip\7z" a "%destinationFolder%\%zipFile%" "%sourceFolder%" -r -x!"%lastModifiedFile%"

REM Delete all files except the last modified one if the zip was created successfully
if exist "%destinationFolder%\%zipFile%" (
    for %%F in ("%sourceFolder%\*") do (
        if not "%%~nxF"=="%lastModifiedFile%" del "%%F"
    )
)

exit
