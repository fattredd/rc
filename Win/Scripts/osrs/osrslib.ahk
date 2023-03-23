#NoEnv
#SingleInstance, Force
SetBatchLines, -1

#Include %A_LineFile%\..\common.ahk

panic := False
MouseClick() {
  if panic
    return
  Click, Left, Down
  Random, MClick, 40, 90
  Sleep, %MClick%
  Click, Left, Up
}
ButtonPush(bttn) {
  if panic
    return
	Send {%bttn% down}
  Random, BPress, 70, 300
  Sleep, %BPress%
	Send {%bttn% up}
}
DoubleClick() {
  Mouseclick()
  Random, MSecClick, 70, 300
  Sleep, %MSecClick%
  Mouseclick()
}

SetupWindow() {
  ;x: 16	y: 13	w: 1761	h: 1054
  WinMove, ahk_exe RuneLite.exe,, 16, 13, 1761, 1054
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
  Random, move_x, x1 + play, x2 - play

  ; Y calc
  row_offset := ((bound.y2 + bound.gapy) - bound.y1) // bound.rows
  row_width :=  row_offset - bound.gapy
  y1 := bound.y1 + (row_offset * row)
  y2 := y1 + row_width
  Random, move_y, y1 + play, y2 - play

  ToolTip % "moving to " . move_x . ", " . move_y . " [" . row . ", " . col . "]"
  SetTimer, RemoveToolTip, -5000

  WinActivate, ahk_exe RuneLite.exe
  Random, MouseSpeed, 3, 5
  MouseMove, move_x, move_y,
  MouseMove, X, Y, %MouseSpeed%
}

!F13::
  panic := True
  SetupWindow()
  return
!F18::
  panic := True
  reload
  Return
