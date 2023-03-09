#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; Screenshot with ShareX if it's installed
sharex_path := "C:\Program Files\ShareX\ShareX.exe"

if FileExist(%sharex_path%) {
  #+s::Send {CtrlDown}{PrintScreen}{CtrlUp}
}
