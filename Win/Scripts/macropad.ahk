#Requires AutoHotkey v2.0
#SingleInstance force
SetWorkingDir(A_ScriptDir)

#Include "%A_LineFile%\..\enc.ahk"
#Include "%A_LineFile%\..\osrs.ahk"
#Include "%A_LineFile%\..\audio_ctrl.ahk"
#Include "%A_LineFile%\..\user_status.ahk"

;=================================================================
;                      Macro Pad Shortcuts                       ;
;=================================================================

;=================================================================
;                       Layer 0 RED (C) - media
;;=================================================================
;Row 1

F13::Return
;F14:: ; audio_ctrl.ahk recording dialog
;F15:: ; audio_ctrl.ahk swap audio device
;F16:: ; hardcoded mute (directly on HW)

;Row 2

F17::Return
F18::Send("{Media_Prev}")
F19::Send("{Media_Next}")
;F20:: ; audio_ctrl.ahk mic on

;Row 3

;F21::  ; doubleclick osrs.ahk
F22::Send("j")
F23::Send("{Media_Play_Pause}")
;F24:: ; audio_ctrl.ahk mic off


;=================================================================
;                       Layer 1  YELLOW (L) - Alt - reddit/osrs
;;=================================================================
;Row 1

;!F13::Return ; panic and setupWindow osrslib.ahk
!F14::Send("-")
!F15::Send("{Shift down}={Shift up}")
;!F16:: ; hardcoded mute (directly on HW)

;Row 2

;!F17::Send() ; stop doubleclick loop osrs.ahk
!F18::Send("[")
!F19::Send("]")
!F20::Send("{Shift down}c{Shift up}")

;Row 3

;!F21::Return ; doubleclick toggle osrs.ahk
!F22::Send("j")
!F23::Send("k")
!F24::Send("l")


;=================================================================
;                       Layer 2 GREEN (D) - Shift - Accounts?
;;=================================================================
;Row 1

+F13::Return
+F14::Return
+F15::Return
;+F16:: ; hardcoded mute (directly on HW)

;Row 2

+F17::Return
+F18::Return
+F19::Return
+F20::set_user_online(True) ; user_status.ahk

;Row 3

+F21::Return
+F22::Return
+F23::Return
+F24::set_user_online(False) ; user_status.ahk

;=================================================================
;                       Layer 3 BLUE (U) - Ctrl - passwd manager
;;=================================================================
;Row 1

^F13::NewpassGui() ; enc.ahk - Add a new password
^F14::RmpassGui() ;  enc.ahk - Remove a password
^F15::Return
;^F16:: ; hardcoded mute (directly on HW)

;Row 2

;^F17::Return ; reload startup.ahk
^F18::Return
^F19::Return
^F20::Return

;Row 3

^F21::Return
^F22::Return
^F23::sendPass("rs2") ; enc.ahk - Window cred manager "AHK_rs2"
^F24::sendPass("gim") ; enc.ahk
