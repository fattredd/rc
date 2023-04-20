#Requires AutoHotkey v2.0
#SingleInstance force
SetWorkingDir(A_ScriptDir)

#Include "%A_LineFile%\..\common.ahk"

; Allow us to set the user to be offline
; https://old.reddit.com/r/AutoHotkey/comments/tafs9i/how_to_make_a_script_that_will_set_your_steam_and/
;
; Currently supports Steam and Discord

; For discord, you'll need:
; https://github.com/discordconsole-team/DiscordConsole
;   then put the exe in `C:\bin\bin\`
; Get your discord token: https://www.howtogeek.com/879956/what-is-a-discord-token-and-how-do-you-get-one/
;   Web Client > Network > Refresh > filter by `/api` > select `library` > Headers > Authorization
;   then store it as pass in the Credential Manager. See ./enc.ahk (CredWrite)

set_user_online(status) {
  ; Discord (takes a few seconds)
  discord_console_path := "C:\bin\bin\DiscordConsole.exe"
  if FileExist(discord_console_path) {
    discord_key := CredRead("AHK_discord")
    discord_status := status ? "online" : "invisible"
    Run discord_console_path . ' -noupdate -t "user ' . discord_key.pass . '" -x "status ' . discord_status . '" -x "exit"',, "Hide"
  }

  ; Steam
  steam_status := status ? "online" : "invisible"
  Run "steam://friends/status/" . steam_status

  ; Echo
  show_status := status ? "online" : "offline"
  ToolTip("Set status to " show_status)
  SetTimer(RemoveToolTip,-1000)
}