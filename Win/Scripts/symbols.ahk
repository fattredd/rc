#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; :[opt]:input::output
;
; Options are:
; *  trigger before the word ends
; ?  trigger even in another word
; B0 don't remove the original str
; R  raw, don't decode {enter} and such
; O  omit the end char when replacing "ftw " -> "for the win"
; X  execute insread of replacement text

; almost eq ≈
:*:~~::{U+2248}
:*:=~=::{U+2248}
; not eq ≠
:*:=/=::{U+2260}
; less or eq ≤
:*:=<=::{U+2264}
; greater or eq ≥
:*:=>=::{U+2265}

; inf ∞
:*:-inf-::{U+221E}
; degree °
:*:-deg-::{U+00B0}
; celsius ℃
:*:-c-::{U+2103}
; fahrenheit ℉
:*:-f-::{U+2109}
; sqrt √
:*:-sqrt-::{U+221A}
; division ÷
:*:-div-::{U+00F7}

; mu μ
:*:-u-::{U+03BC}
; pi π
:*:-pi-::{U+03C0}
; psi Ψ
:*:-psi-::{U+03A8}
; phi Φ
:*:-phi-::{U+03A6}
; lambda λ
:*:-lambda-::{U+03BB}
; omega Ω
:*:-ohm-::{U+03A9}
; delta Δ
:*:-delta-::{U+0394}
; sigma Σ
:*:-sum-::{U+03A3}

; arrows ← → ↑ ↓
:*:<--::{U+2190}
:*:--<::{U+2190}
:*:-->::{U+2192}
:*:--^::{U+2191}
:*:--v::{U+2193}
; pointers ∧ ∨ ⟨ ⟩
:*:-<-::{U+27E8}
:*:->-::{U+27E9}
:*:-^-::{U+2227}
:*:-v-::{U+2228}
; block arrows ◄ ► ▲ ▼
:*:-<<-::{U+25C4}
:*:->>-::{U+25BA}
:*:-^^-::{U+25B2}
:*:-vv-::{U+25BC}

; cent ¢
:*:-cent-::{U+00A2}
; euro €
:*:-euro-::{U+20AC}
; pound £
:*:-pound-::{U+00A3}
; yen ¥
:*:-yen-::{U+00A5}
; curency ¤
:*:-money-::{U+00A4}
; bitcoin ₿
:*:-btc-::{U+20BF}

; copyright ©
:*:-copy-::{U+00A9}
; registered ®
:*:-r-::{U+00AE}
; trademark ™
:*:-tm-::{U+2122}
; number №
:*:-no-::{U+2116}

; german ss(B) ẞ
:*:-ss-::{U+1E9E}
; inv question ¿
:*:-?-::{U+00BF}
; iterobang ‽
:*:-!?-::{U+203D}
; elipsis …
:*:-...-::{U+2026}
; bullet •
:*:-.-::{U+2022}

; power ⏻
:*:-power-::{U+23FB}
; check ✓
:*:-y-::{U+2713}
; cross ✗
:*:-x-::{U+2717}
; warning ⚠
:*:-warn-::{U+26A0}
; biohazard ☣
:*:-bio-::{U+2623}
; radioactive ☢
:*:-rad-::{U+2622}
; balls ȸ
:*:-balls-::{U+238}
; zig zag ෴
:*:-zig-::{U+0DF4}
; Rx perscription ℞
:*:-rx-::{U+211E}
; hex
:*:-hex-::{U+2394}
; benzine hex ⌬
:*:-hex2-::{U+232C}
; helm ⎈
:*:-helm-::{U+2388}
; eye ⏿
:*:-eye-::{U+23FF}

; citation needed [citation needed]
::-cit-::[citation needed]
