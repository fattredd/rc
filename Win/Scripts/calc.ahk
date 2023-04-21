#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

; Calculator
#BackSpace::
#c::{
  SetTitleMatchMode(1)
  HWID := WinExist("Calculator")
  if !HWID = 0 {
    winstate := WinGetMinMax("Calculator")
    if (winstate != 1)
      WinMaximize("Calculator")
    else
      WinRestore("Calculator")
  } else {
    Run("C:\Windows\System32\calc.exe")
  }
}
