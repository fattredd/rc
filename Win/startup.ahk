; Startup


CapsLock::
	CAlone := True
	Return
CapsLock Up::
	If (CAlone) {
		Send, {LWin down}
		Send, {Tab}
		Send, {LWin up}
		Return
	} Else {
		Return
	}

Left::
	CAlone := False
	cl := GetKeyState("CapsLock", "P")
	If (cl) {
		Send, {LWin down}{Ctrl down}
		Send, {Left}
		Send, {LWin up}{Ctrl up}
		Return
	} Else {
		Send, {Left}
		Return
	}

Right::
	CAlone := False
	cl := GetKeyState("CapsLock", "P")
	If (cl) {
		Send, {LWin down}{Ctrl down}
		Send, {Right}
		Send, {LWin up}{Ctrl up}
		Return
	} else {
		Send, {Right}
		Return
	}

AppsKey::RCtrl