; OSRS

SendMode, Event
SetWorkingDir, %A_ScriptDir%
#Include %A_LineFile%\..\osrs\osrslib.ahk
#Include %A_LineFile%\..\common.ahk

; Map these only in Runelite
doubleTime := -250
#IfWinActive ahk_class SunAwtFrame ; Runelite
	WheelLeft::
    Send 2
    Return
  WheelRight::
    Send 4
    Return
  XButton1::
    if (XB1multi > 0) {
      XB1multi += 1
      return
    }
    XB1multi := 1
    SetTimer, XB1multipress, %doubleTime%
    Return
  XButton2::
  if (XB2multi > 0) {
    XB2multi += 1
    return
  }
  XB2multi := 1
  SetTimer, XB2multipress, %doubleTime%
  Return
#IfWinActive

XB1multipress:
  if (XB1multi = 1) {
    Send 3
  } else if (XB1multi = 2) {
    Send 6
  }
  XB1multi := 0
  return

XB2multipress:
  if (XB2multi = 1) {
    Send 1
  } else if (XB2multi = 2) {
    Send 5
  }
  XB2multi := 0
  return

F21:: ; Doubleclick once, or panic doubleclick loop
  If (DClick_toggle) { ; Panic to stop DClick
    DClick_toggle := False
    Return
  }
  gosub DoubleClick
  return

!F13::
  panic := True
  gosub SetupWindow
  return

!F17:: ; panic doubleclick
  DClick_toggle := False
  panic := True
  ToolTip, panic set
  SetTimer, RemoveToolTip, -3000
  return

!F21:: ; toggle doubleclick loop
  DClick_toggle := !DClick_toggle
  If (DClick_toggle) {
    gosub, initMouseMoved
    SetTimer, DoubleClickLoop, -200
  }
  return
