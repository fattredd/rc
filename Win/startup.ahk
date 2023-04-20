; Startup
#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

I_Icon := "Scripts\assets\twister.ico"
if FileExist(I_Icon)
  TraySetIcon(I_Icon)

#Include "Scripts\audio_ctrl.ahk"
#Include "Scripts\osrs.ahk"
#Include "Scripts\macropad.ahk"
#Include "Scripts\rs3.ahk" ; TODO test
;#Include "Scripts\monitorSwap.ahk"
;#Include "Scripts\scrot.ahk"
#Include "Scripts\capslock.ahk" ; TODO test
#Include "Scripts\volume.ahk"
#Include "Scripts\lock_bypass.ahk"
#Include "Scripts\calc.ahk"
#Include "Scripts\framewin.ahk"
#Include "Scripts\symbols.ahk"
#Include "Scripts\workspaces_changes.ahk" ; TODO test

; # -- Win
; ^ -- Ctrl
; ! -- Alt
; + -- Shift
; <> -- Left/Right Mod

#^+R::reload ; Win Ctrl Shft R
^F17::reload ; Ctrl+F17

;Nothing
Launch_Mail::
Launch_App1::
Browser_Home::Return

; Autoclick
#^z:: {
  Loop {
    ToolTip("Autoclicking. Esc to stop")
    If GetKeyState("Esc", "P") {
      ToolTip()
      Break
    }
    Click
    Sleep 100
  }
}

#^c:: {
  static HoldMouse := False
  HoldMouse := !HoldMouse
  If (HoldMouse) {
    ToolTip("Holding down mouse. Ctrl+Win+c to stop")
    Send "{LButton down}"
  } else {
    ToolTip()
    Send "{LButton up}"
  }
}

; Why does this key exist
AppsKey::RCtrl

; Win+t is terminal
#t::{
  Run "C:\Users\ash\AppData\Local\Microsoft\WindowsApps\wt.exe"
  ;Run "%localappdata%\Microsoft\WindowsApps\wt.exe"
}

; Win+m is maximize
#m::{
  winstate := WinGetMinMax("A")
  if winstate != 1
    WinMaximize("A")
  else
    WinRestore("A")
}

NumpadDiv::^#F1

; Win+q is exit
#q::Send "{Alt Down}{F4}{Alt Up}"

; *wheelup::
; *wheeldown::Click

; Feed Ctrl+Backspace correctly to file explorer and notepad
#HotIf WinActive("ahk_class CabinetWClass") ; File Explorer
	^Backspace::Return
#HotIf WinActive("ahk_class Notepad")
	^Backspace::Send "^+{Left}{Backspace}"
#HotIf
