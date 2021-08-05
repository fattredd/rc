; Startup

I_Icon = Scripts\assets\twister.ico
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%


#SingleInstance Force
#Include Scripts\swapAudio.ahk

CapsLock::
	;CAlone := True
	Return
CapsLock Up::
	If (CAlone) {
		Send, {LWin down}
		Send, {Tab}
		Send, {LWin up}
		Return
	} Else {
		Return
	}

Left::
	CAlone := False
	cl := GetKeyState("CapsLock", "P")
	If (cl) {
		Send, {LWin down}{Ctrl down}
		Send, {Left}
		Send, {LWin up}{Ctrl up}
		Return
	} Else {
		Send, {Left}
		Return
	}

Right::
	CAlone := False
	cl := GetKeyState("CapsLock", "P")
	If (cl) {
		Send, {LWin down}{Ctrl down}
		Send, {Right}
		Send, {LWin up}{Ctrl up}
		Return
	} else {
		Send, {Right}
		Return
	}

AppsKey::RCtrl

~RButton & WheelUp::
 Send {Volume_Up}
 SetTimer, CloseContextMenu, 50
return

~RButton & WheelDown::
 Send {Volume_Down}
 SetTimer, CloseContextMenu, 50
return

 CloseContextMenu:
KeyWait, RButton, R
Send, {ALT Down}{ALT Up}
SetTimer, CloseContextMenu, off
return

;Nothing
Launch_Mail::
Launch_App1::
return

#^z::
Toggle := True
Loop
{
	If (!Toggle)
		Break
	Click
	Sleep 370 ; Make this number higher for slower clicks, lower for faster.
}
#^x::
Toggle := False
return

#^c::
HoldMouse := !HoldMouse
If (HoldMouse) {
	Send {LButton down}
} else {
	Send {LButton up}
}
return

NumpadDiv::^#F1

; @gj2mY7Rm*7^gtY
