#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

; Volume
~RButton & WheelUp::{
  Send("{Volume_Up}")
  SetTimer(CloseContextMenu,50)
}

~RButton & WheelDown::{
  Send("{Volume_Down}")
  SetTimer(CloseContextMenu,50)
}

CloseContextMenu() {
  ; This exists because RButton can sometimes open a context menu
  KeyWait("RButton", "R")
  Send("{ALT Down}{ALT Up}")
  SetTimer(CloseContextMenu,0)
}
