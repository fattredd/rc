; Startup and 
#SingleInstance Force
#NoEnv

EnvGet, pin, pin
if (pin == "") {
  MsgBox, "You need to set a 'pin' ENV variable"
  return
}

CoordMode, Pixel, Screen
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\globalConnect.png
if ErrorLevel {
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\globalConnect2.png
}

CoordMode, Mouse, Screen
MouseClick, Left, FoundX, FoundY

ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\connect.png
MouseClick, Left, FoundX, FoundY

WinWait "GlobalProtect Login",, 10

ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\cac.png
MouseClick, Left, FoundX, FoundY

ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\more.png
MouseClick, Left, FoundX, FoundY

ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\cacCert.png
MouseClick, Left, FoundX, FoundY

ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, assets\ok.png
MouseClick, Left, FoundX, FoundY

Sleep, 1500

SendInput, %pin%
SendInput, {Enter}

Sleep, 500
SendInput {LWin}
SendInput Outlook{Enter}

WinKill "GlobalProtect"
Return
