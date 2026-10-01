@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0indexnow_submit.ps1"
if errorlevel 1 (
  echo.
  echo IndexNow submission failed. Review the message above.
  pause
  exit /b 1
)
echo.
echo IndexNow submission completed.
pause
