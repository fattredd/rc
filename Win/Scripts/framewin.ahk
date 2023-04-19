#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

; This applies to apps using ApplicationFrameWindow
; which is a generic windows thing that applies to
; a few things like:
; calculator, img viewer

#HotIf WinActive("ahk_class ApplicationFrameWindow")
  Esc::Send("{AltDown}{F4}{AltUp}")
  XButton1::Send("{Left}")
  XButton2::Send("{Right}")
#HotIf
