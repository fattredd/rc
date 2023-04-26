#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir(A_ScriptDir)

; USAGE:
; ToolTip, Somemsg
; SetTimer, RemoveToolTip, -3000
RemoveToolTip() {
  ToolTip()
  Return
}

updateMouseMoved(&curX, &curY) {
  MouseGetPos(&curX, &curY)
}

getMouseMoved(currentX, currentY, startX, startY, tolerance := 5) {
  if (Abs(currentX - startX) > tolerance)
    Return True
  if (Abs(currentY - startY) > tolerance)
    Return True
  Return False
}

hasValue(haystack, needle, approx:=False) {
  if(!isObject(haystack))
      Return -1
  if(haystack.Length==0)
      Return -1
  for k,v in haystack
      if(v==needle)
          Return k
      if(approx)
        if (InStr(v, needle))
          Return k
  Return -1
}

RevArray(arr) {
  new_arr := []
  For i, val in arr
    new_arr.InsertAt(1, val)
  Return new_arr
}

note_to_freq(music_note) {
  ; music_note is either 'A' or 'A4'
  ;   invalid notes return 0Hz
  note := SubStr(music_note, 1, 1)
  octave := StrLen(music_note) > 1 ? SubStr(music_note, 2, 1) : 4
  note_lookup := Map(
    "C4", 261.626,
    "D4", 293.655,
    "E4", 329.628,
    "F4", 349.228,
    "G4", 391.995,
    "A4", 440.000,
    "B4", 493.883
  )
  if ! note_lookup.Has(note "4")
    Return 0
  base_freq := note_lookup[note "4"] * (2**-4)
  Return base_freq * (2**octave)
}

beepBoop(status, freqTrue, freqFalse := 0, freqLen := 200) {
  ; Play a beep to indicate status. Missing freqFalse will result in
  ;  a tone an octave down
  beep_tone := status ? freqTrue : freqFalse
  if Type(beep_tone) = "String"
    beep_tone := note_to_freq(beep_tone)
  SoundBeep(beep_tone, freqLen)
}

beep_OdeToJoy() {
  song := StrSplit("B B C5 D5 D5 C5 B A G G A B B A A", " ")
  beepBoopSeq(song)
}

beepBoopSeq(freqs, status := 1, freqLen := 100) {
  if status = -1
    freqs := RevArray(freqs)
  if status = 0
    Return

  for beep_tone in freqs {
    if Type(beep_tone) = "String"
      beep_tone := note_to_freq(beep_tone)
    SoundBeep(beep_tone, freqLen)
  }
}
