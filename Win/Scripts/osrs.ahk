; OSRS

SendMode, Event

MouseClick() {
    Click, Left, Down
    Random, MClick, 40, 90
    Sleep, %MClick%
    Click, Left, Up
}

DoubleClick() {
  Mouseclick()
  Random, MSecClick, 70, 300
  Sleep, %MSecClick%
  Mouseclick()
}


F21::
  DoubleClick()
  return

F22::
Toggle := True
Loop {
	If (!Toggle)
		Break
  DoubleClick()
  Random, AMSecClick, 2200, 2700
  Sleep, %AMSecClick%
}
return

F23::
Toggle := False
return
