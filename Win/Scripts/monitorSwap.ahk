#Requires AutoHotkey v2.0
;
; Allow us to rotate between monitor layouts
;  using UltraMon's saved profiles
;
; Untested since V2 update

#Include "%A_LineFile%\..\lib\common.ahk"

Global ProfilePath := A_AppData . "\Realtime Soft\UltraMon\3.4.1\Profiles"
Global fileExt := ".umprofile"
Global Profiles := []
Global ProfilePaths := []
Global Selected := 1
LoadProfiles()

#^Home::{
  LoadProfiles()
  tToolTip("Reloading monitor profiles. " . ProfilePaths.Length . " found.", 900)
}

#^Left::ShiftProfile(-1)

#^Right::ShiftProfile(1)

LoadProfiles() {
  Profiles := []
  ProfilePaths := []
  ProfileFilter := ProfilePath . "\*" . fileExt
  n := 0
  Loop Files, ProfileFilter {
    fName := SubStr(A_LoopFileName, 1, -StrLen(fileExt))
    fPath := A_LoopFilePath
    Profiles[Profiles.Length+1] := fName
    ProfilePaths[ProfilePaths.Length+1] := fPath
    n += 1
  }
}

ShiftProfile(n) {
  maxNum := Profiles.Length
  nextNum := Selected - 1 + n + maxNum
  Selected := Mod(nextNum, maxNum) + 1
  tToolTip("Loaded " . Selected . " - " . Profiles[Selected], 900)
  Run(ProfilePaths[Selected])
}

OnError(LogError)
%cause% := error

LogError(exception) {
    MsgBox("Error on line " exception.Line ": " exception.Message "`n")
    Return true
}
