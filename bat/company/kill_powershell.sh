@echo off

echo 监听powershell.exe进程....
:start
taskkill /F /IM powershell.exe
choice /t 15 /d y /n  >nul

goto start
