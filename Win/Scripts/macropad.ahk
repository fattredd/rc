#Persistent
#SingleInstance force

;=================================================================
;                      Macro Pad Shortcuts                       ;
;=================================================================

;=================================================================
;                       Layer 0 RED
;;=================================================================
;Row 1

F13::Send x
F14::Send a
F15::Send {ShiftDown}={ShiftUp}
;F16:: ; hardcoded mute (directly on HW)

;Row 2

;F17::Send ; panic doubleclick loop osrs.ahk
F18::Send [
F19::Send ]
;F20:: ; mic_ctrl.ahk mic on

;Row 3

;F21::  ; doubleclick osrs.ahk
F22::Send j
F23::Send k
;F24:: ; mic_ctrl.ahk mic off


;=================================================================
;                       Layer 1  GREEN
;;=================================================================
;Row 1

;!F13::Return
!F14::Return
!F15::Return
!F16::Return

;Row 2

;!F17::Return ; reload in startup.ahk
;!F18::Return ; alt reload
!F19::Send x
!F20::Return

;Row 3

;!F21::Return doubleclick loop osrs.ahk
!F22::Send j
!F23::Send l
!F24::Send k


;=================================================================
;                       Layer 2 YELLOW
;;=================================================================
;Row 1

+F13::Return
+F14::Return
+F15::Return
+F16::Return

;Row 2

+F17::Return
+F18::Return
+F19::Return
+F20::Return

;Row 3

+F21::Return
+F22::Return
+F23::Return
+F24::Return

;=================================================================
;                       Layer 3 BLUE
;;=================================================================
;Row 1

^F13::Return
^F14::Return
^F15::Return
^F16::Reload

;Row 2

^F17::Return
^F18::Return
^F19::Return
^F20::Return

;Row 3

^F21::Return
^F22::Return
^F23::Send ***REMOVED*** ; rs2
^F24::Send ***REMOVED*** ; gim
