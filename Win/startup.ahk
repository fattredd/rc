; Startup

#SingleInstance Force
SetWorkingDir %A_ScriptDir%

I_Icon = Scripts\assets\twister.ico
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%

;#Include Scripts\swapAudio.ahk
#Include Scripts\osrs.ahk
#Include Scripts\macropad.ahk
#Include Scripts\rs3.ahk
;#Include Scripts\komorebi.ahk
;#Include Scripts\monitorSwap.ahk

#^+R::
reload
return

CapsLock::Ctrl
;	CAlone := True
;	Return
;CapsLock Up::
;  If (CAlone) {
;    ;Send, {LWin down}
;    ;Send, {Tab}
;    ;Send, {LWin up}
;  }
;  Return

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

; Volume
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

; Autoclick
#^z::
Toggle := True
Loop
{
	If (!Toggle)
		Break
	Click
	Sleep 100 ; Make this number higher for slower clicks, lower for faster.
}
#^x::
Toggle := False
return

#^c::
HoldMouse := !Z
If (HoldMouse) {
	Send {LButton down}
} else {
	Send {LButton up}
}
return

; Lock
#Esc::
Send, {Win Down}{L}{Win Up}
return

; Win+t is terminal
#t::
RUN %localappdata%\Microsoft\WindowsApps\wt.exe
return

; Win+m is maximize
#m::
{
WinGet, winstate, MinMax, A
if winstate != 1
	WinMaximize, A
else
	WinRestore, A
}
return

#c::
{
SetTitleMatchMode, 2
Process, Exist, calc.exe
if !ErrorLevel = 0
{
	WinGet, winstate, MinMax, Calculator
	if winstate != 1
		WinMaximize, Calculator
	else
		WinRestore, Calculator
} else
	RUN C:\Windows\System32\calc.exe
}
return

NumpadDiv::^#F1

; Win+q is exit
#q::
Send, {Alt Down}{F4}{Alt Up}
return

; Alt+F17 is reload
!F17::
  reload
  Return

;*wheelup::
;*wheeldown::
;	Click
;return

; Feed Ctrl+Backspace correctly to file explorer and notepad
#IfWinActive ahk_class CabinetWClass ; File Explorer
	^Backspace::
#IfWinActive ahk_class Notepad
	^Backspace::
	Send ^+{Left}{Backspace}
#IfWinActive
