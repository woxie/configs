@echo off
setlocal

:: Get the directory of the batch file
set scriptPath=%~dp0

:: Resolve the parent directory and Dolphin Clones path
for %%i in ("%scriptPath%..") do set parentDir=%%~fi
set dolphinClonesPath=%parentDir%\Dolphin Clones
set dolphinPath=%parentDir%\Dolphin

:: Ask user for the number of instances
set /p instance=Enter the Dolphin instance to open (2-6): 

:: Validate numeric input (simple check)
if not defined instance (
    echo No input detected. Exiting.
    exit /b
)

:: Validate the range
if %instance% lss 2 (
    echo Minimum number of instances is 2. Exiting.
    exit /b
)
if %instance% gtr 6 (
    echo Maximum number of instances is 6. Exiting.
    exit /b
)
echo Starting Dolphin instance %%i...
	if exist "%dolphinClonesPath%\Dolphin%instance%" (
        echo Starting Dolphin instance %instance%...
		start "" "%dolphinPath%\Dolphin.exe" -u "%dolphinClonesPath%\Dolphin%instance%"
    ) else (
        echo Folder "%dolphinClonesPath%\Dolphin%instance%" not found.
    )
    echo.

echo All requested Dolphin instances have been started.
endlocal
exit