#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir(A_ScriptDir)

; USAGE:
; ToolTip, Somemsg
; SetTimer, RemoveToolTip, -3000
RemoveToolTip() {
  ToolTip()
  Return
}

updateMouseMoved(&curX, &curY) {
  MouseGetPos(&curX, &curY)
}

getMouseMoved(currentX, currentY, startX, startY, tolerance := 5) {
  if (Abs(currentX - startX) > tolerance)
    Return True
  if (Abs(currentY - startY) > tolerance)
    Return True
  Return False
}

hasValue(haystack, needle, approx:=False) {
  if(!isObject(haystack))
      Return -1
  if(haystack.Length==0)
      Return -1
  for k,v in haystack
      if(v==needle)
          Return k
      if(approx)
        if (InStr(v, needle))
          Return k
  Return -1
}
