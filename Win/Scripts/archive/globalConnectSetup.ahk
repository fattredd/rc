; Startup and
#SingleInstance Force
#NoEnv

#Include %A_LineFile%\..\common.ahk

EnvGet, pin, pin
if (pin == "") {
  MsgBox, "You need to set a 'pin' ENV variable"
  Return
}

; Find and click the icon
CoordMode, Pixel, Screen
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\globalConnect.png
if ErrorLevel {
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\globalConnect2.png
  if ErrorLevel {
    ToolTip, Icon not found. Are you already connected?
    SetTimer, RemoveToolTip, -3000
    Return
  }
}

CoordMode, Mouse, Screen
MouseClick, Left, FoundX, FoundY

; Click the connect button
Sleep, 500
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\connect.png
if ErrorLevel {
  ToolTip, Couldn't find 'Connect'
  SetTimer, RemoveToolTip, -3000
  Return
}
MouseClick, Left, FoundX, FoundY


ToolTip, "Waiting for login window"
WinWait GlobalProtect Login,, 15
if ErrorLevel {
  ToolTip, Login window didn't show up in time
  SetTimer, RemoveToolTip, -3000
  Return
}
Sleep, 500
gosub RemoveToolTip

; Click 'Sign in with CAC'
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\cac.png
if ErrorLevel {
  ToolTip, Couldn't find 'Sign in with CaC'
  SetTimer, RemoveToolTip, -3000
  Return
}
MouseClick, Left, FoundX, FoundY

; Wait for the Cac selection window to come up
WinWait, Windows Security,, 10
if ErrorLevel {
  ToolTip, Cac selection window didn't show up in time. COnsidering it as already entered.
  SetTimer, RemoveToolTip, -3000
  gosub EnterPin
}

; Click the 'More choices' button
Sleep, 500
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\more.png
if ErrorLevel {
  ToolTip, Couldn't find 'More choices' button
  SetTimer, RemoveToolTip, -3000
  Return
}
MouseClick, Left, FoundX, FoundY

; Click the parsons Cert
Sleep, 500
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\cacCert.png
if ErrorLevel {
  ToolTip, Couldn't find 'Parsons CaC'
  SetTimer, RemoveToolTip, -3000
  Return
}
MouseClick, Left, FoundX, FoundY

; Click the OK button
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\ok.png
if ErrorLevel {
  ToolTip, Couldn't find final 'OK'
  SetTimer, RemoveToolTip, -3000
  Return
}
MouseClick, Left, FoundX, FoundY

EnterPin:

ToolTip, "Waiting for pin window"
Sleep, 1000
WinActivate, Token Login
gosub RemoveToolTip

; Enter the pin
Sleep, 200
SendInput, %pin%
SendInput, {Enter}

; Start outlook
Sleep, 1500
ToolTip, Opening outlook
SetTimer, RemoveToolTip, -3000
Run, "C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE",, Min

WinWait, GlobalProtect
WinClose, GlobalProtect
Return
