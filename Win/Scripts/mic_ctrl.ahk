#NoEnv
#SingleInstance, Force
SetBatchLines, -1

; Get this info from the other script. If you lost the URL, it's:
; https://github.com/PProvost/AutoHotKey/blob/master/SoundCardAnalysis.ahk

comp    := "MASTER:1" ; Component Type
con     := "VOLUME" ; Control Type
mixer   := 5 ; Mixer Number

SetMic:
  SoundSet, % micLow, % comp, % con, % mixer
  if (ErrorLevel > 0)
      MsgBox % "There was an error.`n" ErrorLevel
  return

F16::
^!PgUp::
  SoundSet, 100, Master:1, Volume, 12
  ;SoundSet, % micHi, % comp, % con, % mixer
  return

F20::
^!PgDn::
  SoundSet, 0, Master:1, Volume, 12
;  SoundSet, % micLow, % comp, % con, % mixer
  return
