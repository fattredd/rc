#NoEnv
#SingleInstance, Force
SetBatchLines, -1

#Include %A_LineFile%\..\common.ahk

; Get this info from the other script. If you lost the URL, it's:
; https://github.com/PProvost/AutoHotKey/blob/master/SoundCardAnalysis.ahk

F20::
^!PgUp::
  ToolTip, Mic ON
  SetTimer, RemoveToolTip, -1000
  SoundSet, 100, Master:1, Volume, 12
; SoundSet, % micHi, % comp, % con, % mixer
  return

F24::
^!PgDn::
  ToolTip, Mic OFF
  SetTimer, RemoveToolTip, -1000
  SoundSet, 0, Master:1, Volume, 12
; SoundSet, % micLow, % comp, % con, % mixer
  return

; https://www.autohotkey.com/boards/viewtopic.php?t=79886
^F19::Run % "Rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,1"
^F20::Run %A_LineFile%\..\mic_finder.ahk
