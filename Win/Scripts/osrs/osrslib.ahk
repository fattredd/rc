#Requires AutoHotkey v2.0
#SingleInstance Force

#Include "%A_LineFile%\..\..\common.ahk"

global panic := False

ButtonPush(bttn) {
  if panic
    Return
	Send("{" bttn " down}")
  BPress := Random(70, 300)
  Sleep(BPress)
	Send("{" bttn " up}")
}

MouseClick() {
  Click("Left, Down")
  MClick := Random(51, 105)
  Sleep(MClick)
  Click("Left, Up")
  Return
}

DoubleClick() {
  Mouseclick()
  MSecClick := Random(120, 350)
  Sleep(MSecClick)
  Mouseclick()
  Return
}

DoubleClickLoop() {
  static prev_state := False
  static startX := 0
  static startY := 0
  static curX := 0
  static curY := 0
  static DClick_Count := 0
  if !prev_state {
    updateMouseMoved(&startX, &startY)
    prev_state := True
  }
  updateMouseMoved(&curX, &curY)
  if (getMouseMoved(curX, curY, startX, startY, 5))
    global DClick_toggle := False

  If (DClick_toggle) {
    SkipProb := Random(0, 100) ; Skip 1 in x alchs
    If (SkipProb != 0)
      DoubleClick()
    DClick_Count++
    ToolTip("DoubleClick Looping (" DClick_Count ")")
    AMSecClick := Random(-4200, -3100) ; 5-7 ticks (3000-4200s)
    SetTimer(DoubleClickLoop, AMSecClick)
    Return
  }
  ToolTip("DoubleClick Stopped (" DClick_Count ")")
  SetTimer(RemoveToolTip, -3000)
  DClick_Count := 0
  prev_state := False
}

TickTime(tick) {
  ; 0.6 Sec/tick
  Return 0.6*tick
}

SetupWindow() {
  ;x: 16	y: 13	w: 1761	h: 1054
  if (WinGetList("ahk_exe RuneLite.exe").Length > 0) {
    WinMove(16, 13, 1761, 1054, "ahk_exe RuneLite.exe")
    ToolTip("Runelite window setup")
    SetTimer(RemoveToolTip, -1000)
  } else {
    ToolTip("Runelite not found")
    SetTimer(RemoveToolTip, -1000)
  }
}

; Inv boundries
inv := {x1: 1220, x2: 1428, y1: 673, y2: 995, cols: 4, rows: 7, gapx: 7, gapy: 5}

; Spell boundries
spell := {x1: 1205, x2: 1439, y1: 662, y2: 975, cols: 7, rows: 10, gapx: 2, gapy: 0}

pick_spot(bound, row, col) {
  play := 4
  ; X calc
  col_offset := ((bound.x2 + bound.gapx) - bound.x1) // bound.cols
  col_width :=  col_offset - bound.gapx
  x1 := bound.x1 + (col_offset * col)
  x2 := x1 + col_width
  move_x := Random(x1 + play, x2 - play)

  ; Y calc
  row_offset := ((bound.y2 + bound.gapy) - bound.y1) // bound.rows
  row_width :=  row_offset - bound.gapy
  y1 := bound.y1 + (row_offset * row)
  y2 := y1 + row_width
  move_y := Random(y1 + play, y2 - play)

  ToolTip("moving to " . move_x . ", " . move_y . " [" . row . ", " . col . "]")
  SetTimer(RemoveToolTip,-5000)

  WinActivate("ahk_exe RuneLite.exe")
  MouseSpeed := Random(3, 5)
  MouseMove(move_x, move_y, MouseSpeed)
}
