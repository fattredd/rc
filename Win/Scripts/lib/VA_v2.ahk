#Requires AutoHotkey v2.0

; Converted some things from VA v2.3
; https://www.autohotkey.com/board/topic/21984-vista-audio-control-functions/?p=143564

; WIP - Not currently functioning

; mmdeviceapi.idl

VA_SetDefaultEndpoint(device_desc, role) {
  /* Roles:
        eConsole        = 0  ; Default Device
        eMultimedia     = 1
        eCommunications = 2  ; Default Communications Device
  */
  if ! device := VA_GetDevice(device_desc) {
    Return 0
  }
  id := 0
  if VA_IMMDevice_GetId(device, &id) = 0     {
    cfg := ComObject("{294935CE-F637-4E7C-A41B-AB255460B862}",
                     "{568b9108-44bf-40b4-9006-86afe5b5a620}")
    hr := VA_xIPolicyConfigVista_SetDefaultEndpoint(cfg, id, role)
    ObjRelease(cfg)
  }
  ObjRelease(device)
  Return hr = 0
}

; device_desc = device_id
;               | ( friendly_name | 'playback' | 'capture' ) [ ':' index ]
VA_GetDevice(device_desc := "playback") {
  ; https://learn.microsoft.com/en-us/windows/win32/coreaudio/mmdevice-api
  static CLSID_MMDeviceEnumerator := "{BCDE0395-E52F-467C-8E3D-C4579291692E}"
  static IID_IMMDeviceEnumerator  := "{A95664D2-9614-4F35-A746-DE8DB63617E6}"
  if !(deviceEnumerator := ComObject(CLSID_MMDeviceEnumerator, IID_IMMDeviceEnumerator)) {
    Return 0
  }

  device := 0

  m := []
  if device_desc is integer {
    m[2] := device_desc
    if m[2] >= 4096 { ; Probably a device pointer, passed here indirectly via VA_GetAudioMeter or such.
      ObjAddRef(device := m[2])
      goto VA_GetDevice_Return
    }
  } else {
    RegExMatch(device_desc, "(.*?)\s*(?::(\d+))?$", &m)
  }

  if m[1] ~= "^(?i:playback|p)$"
    m[1] := "", flow := 0 ; eRender
  else if m[1] ~= "^(?i:capture|c)$"
    m[1] := "", flow := 1 ; eCapture
  else if (m[1] . m[2]) = ""  ; no name or number specified
    m[1] := "", flow := 0 ; eRender (default)
  else
    flow := 2 ; eAll

  if (m[1] . m[2]) = "" { ; no name or number (maybe "playback" or "capture")
    VA_IMMDeviceEnumerator_GetDefaultAudioEndpoint(deviceEnumerator, flow, 0, &device)
    goto VA_GetDevice_Return
  }

  devices := 0
  VA_IMMDeviceEnumerator_EnumAudioEndpoints(deviceEnumerator, flow, 1, &devices)

  if m[1] = "" {
    VA_IMMDeviceCollection_Item(devices, m[2]-1, &device)
    goto VA_GetDevice_Return
  }

  count := 0
  VA_IMMDeviceCollection_GetCount(devices, &count)
  index := 0
  searchName := m[1]
  Loop count {
    if VA_IMMDeviceCollection_Item(devices, A_Index-1, &device) = 0 {
      deviceName := VA_GetDeviceName(device)
      SendRaw(deviceName)
      Send("{Enter}")
      if InStr(deviceName, searchName) && (m[2] = "" || ++index = m[2]) {
        goto VA_GetDevice_Return
      } else {
        ObjRelease(device)
        device:=0
      }
    }
  }
VA_GetDevice_Return:
  if devices
    ObjRelease(devices)

  Return device ; may be 0
}

VA_GetDeviceName(device) {
  static PKEY_Device_FriendlyName := Buffer(20)
  ; functiondiscoverykeys_devpkey.h
  ; PKEY_Device_FriendlyName := 0xa45c254edf1c4efd802067d146a850e014
  NumPut("Char",  0xa4, PKEY_Device_FriendlyName)
  NumPut("Int64", 0x5c254edf1c4efd80, PKEY_Device_FriendlyName, 1)
  NumPut("Int64", 0x2067d146a850e014, PKEY_Device_FriendlyName, 9)

  prop := Buffer(16,0xFF)
  store := 0
  VA_IMMDevice_OpenPropertyStore(device, 0, &store)
  ; interface IPropertyStore = propsys.idl
  hr := ComCall(5, store, "ptr", PKEY_Device_FriendlyName, "ptr", prop) ; GetValue([in] REFPROPERTYKEY key, [out] PROPVARIANT *pv);
  ObjRelease(store)

  ; struct tag_inner_PROPVARIANT == PropIdlBase.Idl
  str_ptr := NumGet(prop, 8, "Ptr")
  VA_WStrOut(&deviceName := str_ptr)
  Return deviceName
}

VA_IMMDevice_GetId(this, &Id) {
  hr := ComCall(5, this, "uint*", Id)
  VA_WStrOut(&Id)
  Return hr
}
VA_IMMDevice_OpenPropertyStore(this, Access, &Properties) {
  Return ComCall(4, this, "uint", Access, "ptr*", &Properties:=0)
}
VA_xIPolicyConfigVista_SetDefaultEndpoint(this, DeviceId, Role) {
  Return ComCall(12, this, "wstr", DeviceId, "int", Role)
}
VA_IMMDeviceEnumerator_GetDevice(this, id, &Device) {
  ; https://learn.microsoft.com/en-us/windows/win32/api/mmdeviceapi/nf-mmdeviceapi-immdeviceenumerator-getdevice
  Return ComCall(5, this, "wstr", id, "ptr*", &Device)
}
VA_IMMDeviceEnumerator_GetDefaultAudioEndpoint(this, DataFlow, Role, &Endpoint) {
  Return ComCall(4, this, "int", DataFlow, "int", Role, "ptr*", &Endpoint)
}
VA_IMMDeviceEnumerator_EnumAudioEndpoints(this, DataFlow, StateMask, &Devices) {
  Return ComCall(3, this, "int", DataFlow, "uint", StateMask, "ptr*", &Devices)
}
; IMMDeviceCollection
VA_IMMDeviceCollection_GetCount(this, &Count) {
  Return ComCall(3, this, "uint*", &Count)
}
VA_IMMDeviceCollection_Item(this, Index, &Device) {
  Return ComCall(4, this, "uint", Index, "ptr*", &Device)
}

VA_WStrOut(&str) {
  try {
    str := StrGet(ptr := str, "UTF-16")
  } catch {
    str := ""
  }
  DllCall("ole32\CoTaskMemFree", "ptr", ptr)  ; FREES THE STRING.
}
