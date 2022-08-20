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
;Toggle := True
;Loop {
;	If (!Toggle)
;		Break
  DoubleClick()
;}
return

~!2::
;Toggle := False
return
