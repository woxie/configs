@echo off
setlocal

:: Get the directory of the batch file
set scriptPath=%~dp0

:: Resolve the parent directory and Dolphin Clones path
for %%i in ("%scriptPath%..") do set parentDir=%%~fi
set dolphinClonesPath=%parentDir%\Dolphin Clones
set dolphinPath=%parentDir%\Dolphin

:: Ask user for the number of instances
set /p instances=Enter the number of Dolphin instances to open (2-6): 

:: Validate numeric input (simple check)
if not defined instances (
    echo No input detected. Exiting.
    exit /b
)

:: Validate the range
if %instances% lss 2 (
    echo Minimum number of instances is 2. Exiting.
    exit /b
)
if %instances% gtr 6 (
    echo Maximum number of instances is 6. Exiting.
    exit /b
)

:: Start the first instance
echo Starting Dolphin instance 1...
start "" "%dolphinPath%\Dolphin.exe"
timeout /t 2 /nobreak >nul

:: Loop to execute Dolphin instances (2 and onwards)
for /l %%i in (2,1,%instances%) do (
    echo Starting Dolphin instance %%i...
	if exist "%dolphinClonesPath%\Dolphin%%i" (
        echo Starting "%dolphinClonesPath%\Dolphin%%i"...
        start "" "%dolphinPath%\Dolphin.exe" -u "%dolphinClonesPath%\Dolphin%%i"
		timeout /t 2 /nobreak >nul
    ) else (
        echo Folder "%dolphinClonesPath%\Dolphin%%i" not found - skipping.
    )
    echo.
)

echo All requested Dolphin instances have been started.
endlocal
exit