#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

#Include "%A_LineFile%\..\lib\common.ahk"

#HotIf WinActive("ahk_exe workspaces.exe") ; Amazon Workspaces
  #!Space::{
    WinActivate("ahk_class Shell_SecondaryTrayWnd")
    tToolTip("Activated main taskbar", 3000)
  }
#HotIf
