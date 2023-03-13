#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

;#IfWinActive ahk_exe workspaces.exe ; Amazon Workspaces
  #!Space::
    WinActivate, ahk_class Shell_SecondaryTrayWnd
    ToolTip, "Activated main taskbar"
    SetTimer, RemoveToolTip, -3000
    Return
;#IfWinActive
