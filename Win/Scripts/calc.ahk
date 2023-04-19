#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

; Calculator
; TODO: Not currently working on win11 because it's in a ApplicationFrameHost container
#BackSpace::
#c::{
  SetTitleMatchMode(2)
  ErrorLevel := ProcessExist("calc.exe")
  if !ErrorLevel = 0 {
    winstate := WinGetMinMax("Calculator")
    if (winstate != 1)
      WinMaximize("Calculator")
    else
      WinRestore("Calculator")
  } else {
    Run("C:\Windows\System32\calc.exe")
  }
}
