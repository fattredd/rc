#NoEnv
#SingleInstance, Force

; USAGE:
; ToolTip, Somemsg
; SetTimer, RemoveToolTip, -3000
RemoveToolTip:
  ToolTip
  return

initMouseMoved:
  MouseGetPos, startX, startY

updateMouseMoved:
  MouseGetPos, curX, curY

getMouseMoved(currentX, currentY, startX, startY, tolerance := 5) {
  if (Abs(currentX - startX) > tolerance)
    return True
  if (Abs(currentY - startY) > tolerance)
    return True
  return False
}

hasValue(haystack, needle, approx=False) {
  if(!isObject(haystack))
      return -1
  if(haystack.Length()==0)
      return -1
  for k,v in haystack
      if(v==needle)
          return k
      if(approx)
        if (InStr(v, needle))
          return k
  return -1
}
