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
    static XBmulti := 0
    if (XBmulti > 0) {
      XBmulti += 1
      Return
    }
    XBmulti := 1
    SetTimer(XBmultipress,doubleTime)

    XBmultipress() {
      if (XBmulti = 1) {
        Send(3)
      } else if (XBmulti = 2) {
        Send(6)
      }
      XBmulti := 0
      Return
    }
    Return
  }
  XButton2:: {
    static XBmulti := 0
    if (XBmulti > 0) {
      XBmulti += 1
      Return
    }
    XBmulti := 1
    SetTimer(XBmultipress,doubleTime)

    XBmultipress() {
      if (XBmulti = 1) {
        Send(1)
      } else if (XBmulti = 2) {
        Send(5)
      }
      XBmulti := 0
      Return
    }
    Return
  }
#HotIf

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
  tToolTip("panic set", 3000)
  Return
}

!F21::{ ; toggle doubleclick loop
  global DClick_toggle := !DClick_toggle
  If (DClick_toggle) {
    SetTimer(DoubleClickLoop, -200)
  }
}
