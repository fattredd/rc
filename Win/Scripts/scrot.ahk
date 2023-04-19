#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

; Screenshot with ShareX if it's installed
sharex_path := "C:\Program Files\ShareX\ShareX.exe"

if FileExist(%sharex_path%) {
  #+s::Send("{CtrlDown}{PrintScreen}{CtrlUp}")
}
