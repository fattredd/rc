#Requires AutoHotkey v2.0
#SingleInstance Force

; Based on work from hippibruder on superuser.com
; https://superuser.com/questions/726988/how-to-remap-a-program-to-lock-windows-winl

; WARNING: Programs that use User32\LockWorkStation (i.e. programmatically locking the operating system) may not work correctly!
; This includes Windows itself (i.e. using start menu or task manager to lock will also not work).

; The following 3 code lines are auto-executed upon script run, the Return line marks an end to the auto-executed code section.
OnExit(OnExitSub) ; Register 'OnExitSub' to be executed when this script is terminating
if getConf("lock_bypass")
  SetDisableLockWorkstationRegKeyValue(1) ; Disable LockWorkStation, so Windows doesn't intercept Win+L

#Esc::
^!l::{ ; Ctrl-Alt-L
  SetDisableLockWorkstationRegKeyValue(0) ; Temporary enable locking
  Sleep(10)
  DllCall("User32\LockWorkStation") ; Lock
  Sleep(10)
  SetDisableLockWorkstationRegKeyValue(1) ; Disable locking again
}

OnExitSub(A_ExitReason, ExitCode) {
  ; Enable LockWorkStation before script exit
  SetDisableLockWorkstationRegKeyValue(0)
  ExitApp()
}

SetDisableLockWorkstationRegKeyValue(value) {
  RegWrite(value, "REG_DWORD", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System", "DisableLockWorkstation")
}
