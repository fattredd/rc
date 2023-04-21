; OSRS
#Requires AutoHotkey v2.0
SendMode("Event")
SetWorkingDir(A_ScriptDir)
#Include "%A_LineFile%\..\lib\osrslib.ahk"
#Include "%A_LineFile%\..\lib\common.ahk"

; Map these only in Runelite
global doubleTime := -250
global DClick_toggle := False

#HotIf WinActive("ahk_class SunAwtFrame") ; Runelite
	WheelLeft:: {
    Send(2)
    Return
  }
  WheelRight:: {
    Send(4)
    Return
  }
  XButton1:: {
    if (XB1multi > 0) {
      XB1multi += 1
      Return
    }
    XB1multi := 1
    SetTimer(XB1multipress,doubleTime)
    Return
  }
  XButton2:: {
  if (XB2multi > 0) {
    XB2multi += 1
    Return
  }
  XB2multi := 1
  SetTimer(XB2multipress,doubleTime)
  Return
  }
#HotIf

XB1multipress() {
  if (XB1multi = 1) {
    Send(3)
  } else if (XB1multi = 2) {
    Send(6)
  }
  XB1multi := 0
  Return
}

XB2multipress() {
  if (XB2multi = 1) {
    Send(1)
  } else if (XB2multi = 2) {
    Send(5)
  }
  XB2multi := 0
  Return
}

F21::{ ; Doubleclick once, or panic doubleclick loop
  If DClick_toggle { ; Panic to stop DClick
    global DClick_toggle := False
    Return
  }
  DoubleClick()
  Return
}

!F13:: {
  global panic := True
  SetupWindow()
  Return
}

!F17::{ ; panic doubleclick
  global DClick_toggle := False
  global panic := True
  ToolTip("panic set")
  SetTimer(RemoveToolTip,-3000)
  Return
}

!F21::{ ; toggle doubleclick loop
  global DClick_toggle := !DClick_toggle
  If (DClick_toggle) {
    SetTimer(DoubleClickLoop, -200)
  }
}
