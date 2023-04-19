#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir(A_ScriptDir)

; CapsLock::{
; 	CAlone := True
; }
; CapsLock Up::{
;   If (CAlone) {
;     Send, {LWin down}
;     Send, {Tab}
;     Send, {LWin up}
;   }
; }

Left::{
	CAlone := False
	cl := GetKeyState("CapsLock", "P")
	If (cl) {
		Send("{LWin down}{Ctrl down}")
		Send("{Left}")
		Send("{LWin up}{Ctrl up}")
	} Else {
		Send("{Left}")
	}
}

Right::{
	CAlone := False
	cl := GetKeyState("CapsLock", "P")
	If (cl) {
		Send("{LWin down}{Ctrl down}")
		Send("{Right}")
		Send("{LWin up}{Ctrl up}")
	} else {
		Send("{Right}")
	}
}
