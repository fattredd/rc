#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

!^c::gosub NewpassGui ; Add a new password
!^d::gosub RmpassGui ; Remove a password

; To retrieve a password:
; !^p::sendPass("123")

NewPassGui:
  GUI New, -MinimizeBox -MaximizeBox +MinSize120x180 +MaxSize120x180, New pass
  GUI Add, Text,, Key:
  GUI Add, Edit, w100 vnewKey
  GUI Add, Text,, User:
  GUI Add, Edit, w100 vnewUser
  GUI Add, Text,, Pass:
  GUI Add, Edit, w100 vnewPass
  GUI Add, Button, Default x30 w60, &Add Pass
  GUI Show
  Return

ButtonAddPass:
  GUI Submit
  cred_key := "AHK_" . newKey
  if CredWrite(cred_key, newUser, newPass)
    ToolTip, Saved creds for %newUser% [%cred_key%]
  else
    ToolTip, Failed to save creds for %cred_key%
  SetTimer, EncRmToolTip, -3000
  return

RmPassGui:
  GUI New, -MinimizeBox -MaximizeBox +MinSize120x180 +MaxSize120x180, Delete pass
  GUI Add, Text,, Key:
  GUI Add, Edit, w100 voldKey
  GUI Add, Button, Default x30 w60, &Remove Pass
  GUI Show
  Return

ButtonRemovePass:
  GUI Submit
  cred_key := "AHK_" . oldKey
  if CredDelete(cred_key)
    ToolTip, Removed creds for %cred_key%
  else
    ToolTip, Failed to remove creds for %cred_key%
  SetTimer, EncRmToolTip, -3000
  return

GuiEscape:
  GUI Cancel
  Return

EncRmToolTip:
  ToolTip
  return

sendPass(key) {
  cred_key := "AHK_" . key
  if (creds := CredRead(cred_key)) {
    ToolTip % "Pasting " cred_key " pass for " creds.username
    send % creds.password
  } else {
    ToolTip No password stored for %cred_key%
  }
  SetTimer, EncRmToolTip, -3000
}

; if !CredWrite("AHK_CredForScript1", "SomeUsername", "SomePassword")
;   MsgBox failed to write cred

; if (cred := CredRead("AHK_CredForScript1"))
;   MsgBox % cred.name "," cred.username "," cred.password
; else
;   MsgBox Cred not found

; if !CredDelete("AHK_CredForScript1")
;   MsgBox Failed to delete cred

; if (cred := CredRead("AHK_CredForScript1"))
;   MsgBox % cred.name "," cred.username "," cred.password
; else
;   MsgBox Cred not found

CredWrite(name, username, password) {
  VarSetCapacity(cred, 24 + A_PtrSize * 7, 0)
  cbPassword := StrLen(password)*2
  NumPut(1         , cred,  4+A_PtrSize*0, "UInt") ; Type = CRED_TYPE_GENERIC
  NumPut(&name     , cred,  8+A_PtrSize*0, "Ptr")  ; TargetName = name
  NumPut(cbPassword, cred, 16+A_PtrSize*2, "UInt") ; CredentialBlobSize
  NumPut(&password , cred, 16+A_PtrSize*3, "UInt") ; CredentialBlob
  NumPut(3         , cred, 16+A_PtrSize*4, "UInt") ; Persist = CRED_PERSIST_ENTERPRISE (roam across domain)
  NumPut(&username , cred, 24+A_PtrSize*6, "Ptr")  ; UserName
  return DllCall("Advapi32.dll\CredWriteW"
  , "Ptr", &cred ; [in] PCREDENTIALW Credential
  , "UInt", 0    ; [in] DWORD        Flags
  , "UInt") ; BOOL
}

CredDelete(name) {
  return DllCall("Advapi32.dll\CredDeleteW"
  , "WStr", name ; [in] LPCWSTR TargetName
  , "UInt", 1    ; [in] DWORD   Type,
  , "UInt", 0    ; [in] DWORD   Flags
  , "UInt") ; BOOL
}

CredRead(name) {
  DllCall("Advapi32.dll\CredReadW"
  , "Str", name   ; [in]  LPCWSTR      TargetName
  , "UInt", 1     ; [in]  DWORD        Type = CRED_TYPE_GENERIC (https://learn.microsoft.com/en-us/windows/win32/api/wincred/ns-wincred-credentiala)
  , "UInt", 0     ; [in]  DWORD        Flags
  , "Ptr*", pCred ; [out] PCREDENTIALW *Credential
  , "UInt") ; BOOL
  if !pCred
      return
  name := StrGet(NumGet(pCred + 8 + A_PtrSize * 0, "UPtr"), 256, "UTF-16")
  username := StrGet(NumGet(pCred + 24 + A_PtrSize * 6, "UPtr"), 256, "UTF-16")
  len := NumGet(pCred + 16 + A_PtrSize * 2, "UInt")
  password := StrGet(NumGet(pCred + 16 + A_PtrSize * 3, "UPtr"), len/2, "UTF-16")
  DllCall("Advapi32.dll\CredFree", "Ptr", pCred)
  return {"name": name, "username": username, "password": password}
}
