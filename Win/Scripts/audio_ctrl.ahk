#Requires AutoHotkey v2.0

; http://www.daveamenta.com/2011-05/programmatically-or-command-line-change-the-default-sound-playback-device-in-windows-7/
#Include "%A_LineFile%\..\common.ahk"

; Audio switching requires nircmd:
; `winget install nircmd`

^#F1:: ; Ctrl + Win + F1
F15:: {
  ; Output devices to rotate through:
  deviceList := ["Optical", "Focusrite"]

  currDevice_FullName := SoundGetName()

  currDevice_ShortName := SubStr(currDevice_FullName, 1, InStr(currDevice_FullName, "(")-2)
  currDevice_Index := hasValue(deviceList, currDevice_ShortName) - 1 ; Make it 0 indexed

  if (currDevice_Index < 0)
    ; Default to the first device in deviceList if we aren't already in the rotation
    nextDevice_Index := 1
  else
    nextDevice_Index := Mod(currDevice_Index + 1, deviceList.Length) + 1 ; Because it's 0 indexed

  nextDevice_Name := deviceList[nextDevice_Index]
  ToolTip("Set output: " nextDevice_Name)
  Run("nircmd setdefaultsounddevice " nextDevice_Name " 1")
  SetTimer(RemoveToolTip,-1000)
  Return
}

;F13::Run %A_LineFile%\..\mic_finder.ahk

^#F2:: ; Ctrl + Win + F2
F14::Run("Rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,1") ; Open recording panel

setMuteMic(mic_status := unset) {
  device_name := "Analogue"
  ; True: unmuted
  ; False: muted
  new_state := !SoundGetMute("", device_name)
  if IsSet(mic_status) {
    new_state := mic_status
  }
  SoundSetMute(new_state, "", device_name)
  status_str := new_state ? "OFF" : "ON"
  ToolTip("Mic " status_str)
  SetTimer(RemoveToolTip,-500)
  Return
}

^#F11:: ; Ctrl + Win + F11
F20::setMuteMic(False) ; Off

^#F12:: ; Ctrl + Win + F12
F24::setMuteMic(True) ; On

; Win + 0 ; Toggle mic
#0::setMuteMic()