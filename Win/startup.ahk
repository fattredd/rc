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
;#Include Scripts\monitorSwap.ahk
#Include Scripts\capslock.ahk
#Include Scripts\volume.ahk
#Include Scripts\mic_ctrl.ahk
#Include Scripts\lock_bypass.ahk
#Include Scripts\calc.ahk
#Include Scripts\framewin.ahk

; # -- Win
; ^ -- Ctrl
; ! -- Alt
; + -- Shift
; <> -- Left/Right Mod

#^+R:: ; Win Ctrl Shft R
  reload
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

; Why does this key exist
AppsKey::RCtrl

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

RemoveToolTip:
  ToolTip
  return
