#Requires AutoHotkey v2.0

#Include "%A_LineFile%\..\lib\common.ahk"

; Audio switching requires nircmd:
; `winget install nircmd`

rotate_audio() {
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
  SetTimer(RemoveToolTip,-1000)
  beepBoop(True, "E2") ; Low tone on old output
  ;VA_SetDefaultEndpoint(nextDevice_Name, 0)
  Run("nircmd setdefaultsounddevice " nextDevice_Name " 1")
  Sleep(100) ; Wait for device to swap
  beepBoop(True, "E3") ; High tone on new output
}

setMuteState(device_name := "Analogue", mic_status := unset) {
  ; True: unmuted
  ; False: muted
  new_state := !SoundGetMute("", device_name)
  if IsSet(mic_status) {
    new_state := mic_status
  }
  SoundSetMute(new_state, "", device_name)

  ; Echo
  status_str := new_state ? "OFF" : "ON"
  ToolTip(device_name " " status_str)
  SetTimer(RemoveToolTip,-500)
  beepBoop(new_state, "C3", "C4")
}

^#F1:: ; Ctrl + Win + F1
F15::rotate_audio()

^#F2:: ; Ctrl + Win + F2
F14::Run("Rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,1") ; Open recording panel

^#F11:: ; Ctrl + Win + F11
F20::setMuteState("Analogue", False) ; Off

^#F12:: ; Ctrl + Win + F12
F24::setMuteState("Analogue", True) ; On

; Win + 0 ; Toggle mic
#0::setMuteState("Analogue")
