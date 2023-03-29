; OSRS

SendMode, Event
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


MouseClick:
  Click, Left, Down
  Random, MClick, 51, 105
  Sleep, %MClick%
  Click, Left, Up
  return

DoubleClick:
  gosub Mouseclick
  Random, MSecClick, 120, 350
  Sleep, %MSecClick%
  gosub Mouseclick
  return


F21::
  If (DClick_toggle) { ; Panic to stop DClick
    DClick_toggle := False
    Return
  }
  gosub DoubleClick
  return

!F21::
  DClick_toggle := !DClick_toggle
  If (DClick_toggle) {
    gosub, initMouseMoved
    SetTimer, DoubleClickLoop, -200
  }
  return

DoubleClickLoop:
  gosub, updateMouseMoved
  if (getMouseMoved(curX, curY, startX, startY, 5))
    DClick_toggle := False

  If (DClick_toggle) {
    Random, SkipProb, 0, 100 ; Skip 1 in x alchs
    If (SkipProb != 0)
      gosub DoubleClick
    DClick_Count++
    ToolTip, DoubleClick Looping (%DClick_Count%)
    Random, AMSecClick, -4200, -3100 ; 5-7 ticks (3000-4200s)
    SetTimer, DoubleClickLoop, %AMSecClick%
    Return
  }
  ToolTip, DoubleClick Stopped (%DClick_Count%)
  SetTimer, RemoveToolTip, -3000
  DClick_Count := 0
  return

F17::
  DClick_toggle := False
  return
