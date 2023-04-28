#Requires AutoHotkey v2.0
#SingleInstance force
SetWorkingDir(A_ScriptDir)

#Include "%A_LineFile%\..\lib\common.ahk"
#Include "%A_LineFile%\..\lib\github.ahk"
#Include "%A_LineFile%\..\enc.ahk"

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

global bin_path := "C:\bin\bin\"

set_user_online(status) {
  ; Discord (takes a few seconds)
  discord_console_path := bin_path . "DiscordConsole.exe"
  if ! FileExist(discord_console_path)
    grab_discord_console()
  discord_key := CredRead("AHK_discord")
  if IsObject(discord_key) {
    discord_status := status ? "online" : "invisible"
    while true { ; Because sometimes this fails
      discord_status := RunWait(discord_console_path . ' -noupdate -t "user ' . discord_key.password . '" -x "status ' . discord_status . '" -x "exit"',, "Hide")
      if discord_status == 0
        break
      Sleep(250)
    }
  }

  ; Steam
  steam_status := status ? "online" : "invisible"
  Run "steam://friends/status/" . steam_status

  ; Echo
  show_status := status ? "online" : "offline"
  tToolTip("Set status to " show_status, 1000)
  beepBoop(status, "B3", "B2")
}

grab_discord_console() {
  git := Gitter("discordconsole-team/DiscordConsole", "windows")
  git.extract(bin_path, "64-bit\DiscordConsole.exe")
}
