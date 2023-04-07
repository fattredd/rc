; http://www.daveamenta.com/2011-05/programmatically-or-command-line-change-the-default-sound-playback-device-in-windows-7/
#Include %A_LineFile%\..\VA.ahk
#Include %A_LineFile%\..\common.ahk

^#F1::
F15::
  ; Output devices to rotate through:
  deviceList := ["Optical", "Focusrite"]

  currDevice_FullName := VA_GetDeviceName(VA_GetDevice("playback"))
  currDevice_ShortName := SubStr(currDevice_FullName, 1, InStr(currDevice_FullName, "(")-2)
  currDevice_Index := hasValue(deviceList, currDevice_ShortName) - 1 ; Make it 0 indexed

  if (currDevice_Index < 0)
    ; Default to the first device in deviceList if we aren't already in the rotation
    nextDevice_Index := 1
  else
    nextDevice_Index := Mod(currDevice_Index + 1, deviceList.Length()) + 1 ; Because it's 0 indexed

  nextDevice_Name := deviceList[nextDevice_Index]
  VA_SetDefaultEndpoint(nextDevice_Name, 0)
  ToolTip Set output: %nextDevice_Name%
  SetTimer, RemoveToolTip, -500
  return


;F13::Run %A_LineFile%\..\mic_finder.ahk
F14::Run % "Rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,1" ; Open recording panel

F20::
  VA_SetMasterVolume(100, "", "Analogue")
  ToolTip, Mic ON
  SetTimer, RemoveToolTip, -500
  return
F24::
  VA_SetMasterVolume(0, "", "Analogue")
  ToolTip, Mic OFF
  SetTimer, RemoveToolTip, -500
  return
