#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; Calculator
; TODO: Not currently working on win11 because it's in a ApplicationFrameHost container
#BackSpace::
#c::
  {
  SetTitleMatchMode, 2
  Process, Exist, calc.exe
  if !ErrorLevel = 0
  {
    WinGet, winstate, MinMax, Calculator
    if winstate != 1
      WinMaximize, Calculator
    else
      WinRestore, Calculator
  } else
    RUN C:\Windows\System32\calc.exe
  }
  return
