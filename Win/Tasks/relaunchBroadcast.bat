@ECHO OFF

SET EXEName="Broadcast.exe"
SET EXEFullPath="C:\Program Files\NVIDIA Corporation\NVIDIA Broadcast\NVIDIA Broadcast.exe"

TASKLIST | FINDSTR /I "%EXEName%"
IF ERRORLEVEL 1 GOTO :StartBroadcast
GOTO :EOF

:StartBroadcast
START "" %EXEFullPath%
call ..\Scripts\notification.bat -tooltip warning -time 3000 -title "Broadcast crashed" -text "Restarting now..." -icon warning
GOTO :EOF
