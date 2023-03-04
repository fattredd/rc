#NoEnv
#SingleInstance, Force
SetBatchLines, -1

; Get this info from the other script. If you lost the URL, it's:
; https://github.com/PProvost/AutoHotKey/blob/master/SoundCardAnalysis.ahk

F20::
^!PgUp::
  SoundSet, 100, Master:1, Volume, 12
  ;SoundSet, % micHi, % comp, % con, % mixer
  return

F24::
^!PgDn::
  SoundSet, 0, Master:1, Volume, 12
;  SoundSet, % micLow, % comp, % con, % mixer
  return
