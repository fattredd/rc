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
