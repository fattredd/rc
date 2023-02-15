#NoEnv
SendMode, Event
SetBatchLines, -1

; Map these only in RS3
#IfWinActive ahk_class JagWindow ; RS3
	WheelLeft::
    Send b
    Return
  WheelRight::
    Send {,}
    Return
  XButton1::
    Send i
    Return
  XButton2::
    Send p
    Return
#IfWinActive
