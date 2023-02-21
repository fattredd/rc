#NoEnv
#SingleInstance, Force

; https://superuser.com/questions/726988/how-to-remap-a-program-to-lock-windows-winl

; WARNING: Programs that use User32\LockWorkStation (i.e. programmatically locking the operating system) may not work correctly!
; This includes Windows itself (i.e. using start menu or task manager to lock will also not work).
; Script changes Win-L to show a msgbox and Ctrl-Alt-L to lock windows

; The following 3 code lines are auto-executed upon script run, the return line marks an end to the auto-executed code section.
; Register user defined subroutine 'OnExitSub' to be executed when this script is terminating
OnExit, OnExitSub
; Disable LockWorkStation, so Windows doesn't intercept Win+L and this script can act on that key combination
SetDisableLockWorkstationRegKeyValue( 1 )
return

#Esc::
^!l::
  ; Ctrl-Alt-L
  ; Temporary enable locking
  SetDisableLockWorkstationRegKeyValue( 0 )
  ; Lock
  Sleep, 250
  DllCall( "User32\LockWorkStation" )
  Sleep, 250
  ; Disable locking again
  SetDisableLockWorkstationRegKeyValue( 1 )
  return

OnExitSub:
  ; Enable LockWorkStation, because this script is ending (so other applications aren't further disturbed)
  SetDisableLockWorkstationRegKeyValue( 0 )
  ExitApp
  return

SetDisableLockWorkstationRegKeyValue( value ) {
  RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, %value%
}
