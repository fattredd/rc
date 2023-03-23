; enchanter

#NoEnv
#SingleInstance, Force

SetBatchLines, -1
SendMode, Event
SetWorkingDir, %A_ScriptDir%
#Include %A_LineFile%\..\osrslib.ahk

; Begin script
!F21::
  panic := False
  max_items := 13
  Loop, 4 {
    cur_row := A_Index - 1
    Loop, 4 {
      ButtonPush(4)
      if max_items = 0:
        return
      cur_col := A_Index - 1
      pick_spot(spell, 7, 2) ; dragonstone enchant
      Random, SecClick, 100, 200
      Sleep, %SecClick%
      MouseClick()
      pick_spot(inv, cur_row, cur_col)
      Random, MSecClick, 200, 400
      Sleep, %MSecClick%
      if panic
        return
      MouseClick()
      Random, AMSecClick, 400, 500
      Sleep, %AMSecClick%
      max_items := max_items - 1
      if panic
        return
    }
  }
  Return
