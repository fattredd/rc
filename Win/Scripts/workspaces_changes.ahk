#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

#HotIf WinActive("ahk_exe workspaces.exe") ; Amazon Workspaces
  #!Space::{
    WinActivate("ahk_class Shell_SecondaryTrayWnd")
    ToolTip("Activated main taskbar")
    SetTimer(RemoveToolTip,-3000)
  }
#HotIf
