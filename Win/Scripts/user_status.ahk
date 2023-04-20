#Requires AutoHotkey v2.0
#SingleInstance force
SetWorkingDir(A_ScriptDir)

#Include "%A_LineFile%\..\common.ahk"
#Include "%A_LineFile%\..\lib\github.ahk"

; Allow us to set the user to be offline
; https://old.reddit.com/r/AutoHotkey/comments/tafs9i/how_to_make_a_script_that_will_set_your_steam_and/
;
; Currently supports Steam and Discord

; For discord, you'll need:
; https://github.com/discordconsole-team/DiscordConsole (we try to get it automatically)
;   then put the exe in `C:\bin\bin\`
; Get your discord token: https://www.howtogeek.com/879956/what-is-a-discord-token-and-how-do-you-get-one/
;   Web Client > Network > Refresh > filter by `/api` > select `library` > Headers > Authorization
;   then store it as pass in the Credential Manager. See ./enc.ahk (CredWrite)

bin_path := "C:\bin\bin\"

set_user_online(status) {
  ; Discord (takes a few seconds)
  discord_console_path := bin_path . "DiscordConsole.exe"
  if ! FileExist(discord_console_path)
    grab_discord_console()
  discord_key := CredRead("AHK_discord")
  discord_status := status ? "online" : "invisible"
  Run discord_console_path . ' -noupdate -t "user ' . discord_key.pass . '" -x "status ' . discord_status . '" -x "exit"',, "Hide"

  ; Steam
  steam_status := status ? "online" : "invisible"
  Run "steam://friends/status/" . steam_status

  ; Echo
  show_status := status ? "online" : "offline"
  ToolTip("Set status to " show_status)
  SetTimer(RemoveToolTip,-1000)
  beep_status := status ? 400 : 200
  SoundBeep beep_status, 200
}

grab_discord_console() {
  git := Gitter("discordconsole-team/DiscordConsole", "windows")
  git.extract(bin_path, "64-bit\DiscordConsole.exe")
}
