#Requires AutoHotkey v2.0
#SingleInstance force
SetWorkingDir(A_ScriptDir)

#Include "%A_LineFile%\..\lib\common.ahk"

global ini_file := "%A_LineFile%\..\settings.ini"

if ! FileExist(ini_file)
  setupINI()

setupINI() {
  config := {
    includes: {
      audio: true,
      volume: true,
      macropad: true,
      lock_bypass: true,
      symbols: true,
      scrot: false,
      capslock: false,
      monitorSwap: false,
      user_status: true
    },
    mic_ctrl: {
      enabled: true
    },
    status: {
      steam: true,
      discord: true
    },
    sounds: {
      enabled: true
    }
  }
  for section, conf in config.OwnProps() {
    for key, val in conf.OwnProps() {
      try {
        _ := IniRead(ini_file, section, key)
      } catch {
        IniWrite(val, ini_file, section, key)
      }
    }
  }
}

getConf(key, section := "includes") {
  try
    Return IniRead(ini_file, section, key) == 1
  catch
    setupINI()
  Return IniRead(ini_file, section, key) == 1
}
getConfVal(key, section := "includes") {
  try
    Return IniRead(ini_file, section, key)
  catch
    setupINI()
  Return IniRead(ini_file, section, key)
}

#1::setupINI()
