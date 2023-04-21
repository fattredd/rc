#Requires AutoHotkey v2.0
; https://www.autohotkey.com/boards/viewtopic.php?f=83&t=112274

; Example:
; ; Confine to giagantic hexagon:
; confineCursorToPolygon(
;   Point(960, 40),
;   Point(1393, 290),
;   Point(1393, 790),
;   Point(960, 1040),
;   Point(527, 790),
;   Point(537, 290)
; )
; ; Release:
; confineCursorToPolygon()

confineCursorToPolygon(points*) {
  static WH_MOUSE_LL := 14, WM_MOUSEMOVE := 0x200
  static hookHandle

  if (points.length > 0) {
    hookHandle := dllCall(
      "SetWindowsHookEx",
      "Int", WH_MOUSE_LL,
      "UInt", callbackCreate(confine, "Fast"),
      "UInt", 0,
      "UInt", 0
    )
  } else if (hookHandle) {
    dllCall("UnhookWindowsHookEx", "UInt", hookHandle)
  }

  confine(nCode, wParam, lParam) {
    critical

    if nCode == 0 && wParam == WM_MOUSEMOVE {
      cursorPos := Point(numGet(lParam, 0, "Int"), numGet(lParam, 4, "Int"))

      targetPoint := findTargetPoint(cursorPos)

      if targetPoint {
        dllCall("SetCursorPos", "Int", targetPoint.x, "Int", targetPoint.y)
      }
    }

    return dllCall(
      "CallNextHookEx",
      "UInt", 0,
      "UInt", nCode,
      "UInt", wParam,
      "UInt", lParam,
      "Int64"
    )
  }

  findTargetPoint(point) {
    windingNumber := 0
    targetPoint := unset
    targetPointDistance := unset

    loop points.length {
      startPoint := points[A_Index]
      endPoint := A_Index == points.length ? points[1] : points[A_Index + 1]

      pointPosition := point.compareToLine(startPoint, endPoint)

      if pointPosition == 0 {
        return false
      } else if pointPosition > 0 {
        if startPoint.y <= point.y {
          if endPoint.y > point.y {
            windingNumber++
          }
        }
      } else {
        if startPoint.y > point.y {
          if endPoint.y < point.y {
            windingNumber--
          }
        }
      }

      nearestPointOnEdge := findNearestPointOnLine(point, startPoint, endPoint)
      distanceToNearestPointOnEdge := nearestPointOnEdge.getDistanceTo(point)

      if !isSet(targetPointDistance) || distanceToNearestPointOnEdge < targetPointDistance {
        targetPoint := nearestPointOnEdge
        targetPointDistance := distanceToNearestPointOnEdge
      }
    }

    return isSet(targetPoint) && windingNumber == 0 ? targetPoint : false
  }

  findNearestPointOnLine(point, startPoint, endPoint) {
    lineVector := endPoint.subtract(startPoint)
    lineLength := startPoint.getDistanceTo(endPoint)
    lineUnitVector := lineVector.normalized
    projection := point.subtract(startPoint).dot(lineUnitVector)

    if projection < 0 {
      return startPoint
    } else if projection > lineLength {
      return endPoint
    } else {
      return startPoint.add(lineUnitVector.scale(projection))
    }
  }
}

class Point {
  __new(x, y) {
    this.x := x
    this.y := y
  }

  dot(other) {
    return this.x * other.x + this.y * other.y
  }

  add(other) {
    return Point(this.x + other.x, this.y + other.y)
  }

  subtract(other) {
    return Point(this.x - other.x, this.y - other.y)
  }

  scale(amount) {
    return Point(this.x * amount, this.y * amount)
  }

  normalized {
    get {
      length := this.distanceToOrigin

      if length == 0 {
        return Point(0, 0)
      }

      return Point(this.x / length, this.y / length)
    }
  }

  getDistanceTo(other) {
    x := this.x - other.x
    y := this.y - other.y

    return sqrt(x**2 + y**2)
  }

  distanceToOrigin => sqrt(this.x**2 + this.y**2)

  compareToLine(startPoint, endPoint) {
    return (endPoint.x - startPoint.x) * (this.y - startPoint.y) - (this.x - startPoint.x) * (endPoint.y - startPoint.y)
  }
}
