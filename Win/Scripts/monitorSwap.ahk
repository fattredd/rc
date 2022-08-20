;
; Allow us to rotate between monitor layouts
;  using UltraMon's saved profiles
;

Global ProfilePath := A_AppData . "\Realtime Soft\UltraMon\3.4.1\Profiles"
Global fileExt := ".umprofile"
Global Profiles := []
Global ProfilePaths := []
Global Selected := 1
LoadProfiles()

#^Home::
  LoadProfiles()
  ToolTip % "Reloading monitor profiles. " . ProfilePaths.Length() . " found."
  SetTimer, RemoveToolTip, -900
  return

#^Left::
  ShiftProfile(-1)
  return

#^Right::
  ShiftProfile(1)
  return

LoadProfiles() {
  Profiles := []
  ProfilePaths := []
  ProfileFilter = %ProfilePath%\*%fileExt%
  n = 0
  Loop, Files, %ProfileFilter%
  {
    fName := SubStr(A_LoopFileName, 1, -StrLen(fileExt))
    fPath := A_LoopFileFullPath
    Profiles[Profiles.Length()+1] := fName
    ProfilePaths[ProfilePaths.Length()+1] := fPath
    n += 1
  }
}

ShiftProfile(n) {
  maxNum := Profiles.Length()
  nextNum := Selected - 1 + n + maxNum
  Selected := Mod(nextNum, maxNum) + 1
  ToolTip % "Loaded " . Selected . " - " . Profiles[Selected]
  SetTimer, RemoveToolTip, -900
  Run % ProfilePaths[Selected]
}

RemoveToolTip:
  ToolTip,,,, [color="darkred"]20[/color]
  Return

OnError("LogError")
%cause% := error

LogError(exception) {
    MsgBox % "Error on line " exception.Line ": " exception.Message "`n"
    return true
}
