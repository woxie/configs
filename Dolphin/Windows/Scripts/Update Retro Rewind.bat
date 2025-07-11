@echo off
setlocal EnableExtensions EnableDelayedExpansion

::── Change to script folder ────────────────────────────────────────────────
cd /d "%~dp0"

::── Prompt for ZIP file, allow drag-and-drop, default to RetroRewind.zip ────
echo.
set "zipfile="
set /p "zipfile=Please enter the path to the zip file (drag & drop allowed) or press Enter to use 'RetroRewind.zip': "
if "%zipfile%"=="" (
    set "zipfile=RetroRewind.zip"
)

::── Strip any surrounding quotes (handles drag-and-drop) ────────────────────
set "zipfile=%zipfile:"=%"

::── Convert to a fully-qualified path ─────────────────────────────────────
for %%I in ("%zipfile%") do set "zipfile=%%~fI"

echo.
echo Using zip file: "%zipfile%"
echo.

::── Fail early if it doesn’t exist ─────────────────────────────────────────
if not exist "%zipfile%" (
    echo [ERROR] The zip file "%zipfile%" was not found.
    echo Please verify the file name and path.
    pause
    exit /b 1
)

echo Extracting "%zipfile%" to specified folders...
echo.

::── Loop through your ::DEST: lines at the bottom ──────────────────────────
for /f "tokens=* delims=" %%D in ('findstr /B "::DEST:" "%~f0"') do (
    rem strip the prefix, turn into absolute
    set "dest=%%D"
    set "dest=!dest:~7!"
    for %%F in ("!dest!") do set "absPath=%%~fF"

    echo Processing destination: "!absPath!"
    if exist "!absPath!" (
        echo Running extraction into "!absPath!"...
        powershell -NoProfile -Command ^
          "Expand-Archive -LiteralPath '!zipfile!' -DestinationPath '!absPath!' -Force"
    ) else (
        echo Folder "!absPath!" not found - skipping.
    )
    echo.
)

echo Extraction complete.
endlocal
pause
exit /b 0

::DEST:..\Dolphin\User\Load\Riivolution
::DEST:..\Dolphin Clones\Dolphin2\Load\Riivolution
::DEST:..\Dolphin Clones\Dolphin3\Load\Riivolution
::DEST:..\Dolphin Clones\Dolphin4\Load\Riivolution
::DEST:..\Dolphin Clones\Dolphin5\Load\Riivolution
::DEST:..\Dolphin Clones\Dolphin6\Load\Riivolution
