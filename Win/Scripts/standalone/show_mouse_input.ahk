; Taken from https://www.autohotkey.com/boards/viewtopic.php?f=19&t=10159
#Requires AutoHotkey v1
#include %A_LineFile%\..\..\lib\mousedelta.ahk
#SingleInstance Force

Gui, Add, ListBox, w300 h200 hwndhOutput
Gui, Add, Text, xm w300 center, Hit F12 to toggle on / off
Gui, Show,, Mouse Watcher

MacroOn := 1
md := new MouseDelta("MouseEvent")

Return

GuiClose:
	md.Delete()
	md := ""
	ExitApp

F12::
	MacroOn := !MacroOn
	md.SetState(MacroOn)
	Return

; Gets called when mouse moves
; x and y are DELTA moves (Amount moved since last message), NOT coordinates.
MouseEvent(MouseID, x := 0, y := 0) {
	global hOutput
	static text := ""
	static LastTime := 0

	t := A_TickCount
	text := "x: " x ", y: " y (LastTime ? (", Delta Time: " t - LastTime " ms, MouseID: " MouseID) : "")
	ToolTip % "test: " text
  GuiControl, , % hOutput, % text
	sendmessage, 0x115, 7, 0,, % "ahk_id " hOutput
	LastTime := t
}
