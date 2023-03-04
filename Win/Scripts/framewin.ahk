#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; This applies to apps using ApplicationFrameWindow
; which is a generic windows thing that applies to
; a few things like:
; calculator, img viewer

#IfWinActive ahk_class ApplicationFrameWindow
  Esc::Send, {AltDown}{F4}{AltUp}
  XButton1::Send, {Left}
  XButton2::Send, {Right}
#IfWinActive
