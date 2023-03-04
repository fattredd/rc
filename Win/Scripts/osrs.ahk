; OSRS

SendMode, Event

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
  Random, MClick, 40, 90
  Sleep, %MClick%
  Click, Left, Up
  return

DoubleClick:
  gosub Mouseclick
  Random, MSecClick, 70, 300
  Sleep, %MSecClick%
  gosub Mouseclick
  return


F21::
  gosub DoubleClick
  return

!F21::
  Toggle := True
  Loop {
    If (!Toggle)
      Break
    gosub DoubleClick
    Random, AMSecClick, 2200, 2700
    Sleep, %AMSecClick%
  }
  return

F17::
  Toggle := False
  return
