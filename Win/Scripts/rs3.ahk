#Requires AutoHotkey v2.0
SendMode("Event")

; Map these only in RS3
#HotIf WinActive("ahk_class JagWindow") ; RS3
	WheelLeft::Send("b")
  WheelRight::Send(",")
  XButton1::Send("i")
  XButton2::Send("p")
#HotIf
