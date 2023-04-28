#Requires AutoHotkey v2.0
#SingleInstance force
SetWorkingDir(A_ScriptDir)

#Include "%A_LineFile%\..\lib\common.ahk"
#Include "%A_LineFile%\..\lib\JXON.ahk"

translate_selection() {
  ; Store previous state
  prev_win := WinGetID("A")
  prev_clipboard := ClipboardAll()

  A_Clipboard := ""
  SendInput("^c")
  ClipWait

  data := Object()
  result := translate(A_Clipboard, &data)
  tToolTip(result " (" data.source_lang ")", 2000)

  ; Restore previous state
  ClipboardAll(prev_clipboard)
  WinActivate("ahk_id " prev_win)
}

translate(msg, &data:=unset) {
  transtext := StrReplace(msg, " ", "%20")
  transurl:= "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=en&dt=t&q=" transtext
  temp := A_LineFile "\..\lib\.temp\translate_temp.json"
  Download(transurl, temp)
  sleep(50)
  json_data := FileRead(temp)
  json_data := jxon_load(&json_data)
  ;filedelete(temp)

  data := Object()
  data.out := json_data[1][1][1]
  data.source := json_data[1][1][2]
  data.source_lang := json_data[3]

  Return data.out
}

; ¿por que?
; ^!1::ttooltip(translate("¿por que?"),2000)
; ^!2::translate_selection()
