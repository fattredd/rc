#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; Volume
~RButton & WheelUp::
  Send {Volume_Up}
  SetTimer, CloseContextMenu, 50
  return

~RButton & WheelDown::
  Send {Volume_Down}
  SetTimer, CloseContextMenu, 50
 return

CloseContextMenu:
  KeyWait, RButton, R
  Send, {ALT Down}{ALT Up}
  SetTimer, CloseContextMenu, off
  return
