setlocal
cd /d %~dp0
powershell -ep Bypass ./backup.ps1
pause
