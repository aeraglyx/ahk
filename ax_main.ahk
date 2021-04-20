#NoEnv
#SingleInstance Force
#Persistent
SendMode Input

; SUB-SCRIPTS
; has to be before any hotkeys/returns etc. I guess
Run, acc_scroll.ahk
;Run, acc_mouse.ahk

#Include functions.ahk
#Include X:\Aeraglyx\secret.ahk

XButton1 & r:: Reload
XButton1 & q:: WinClose A

toggle(app) {
    DetectHiddenWindows, On
    SetTitleMatchMode, 2 
    if WinExist(app) {
        WinClose, %app%
    } else {
        Run, %app%
    }
}




; COLOR PICKER
XButton1 & b:: toggle("color_picker.ahk")


; KEYBOARD LAYOUT TOGGLE
~LAlt Up::
if (A_PriorKey = "LShift"){
    toggle("en_cs_hybrid.ahk")
}
return




; VOLUME & SOUND
; ± 40 for switching between headphones and speakers
XButton1 & Volume_Down:: Send, {Volume_Down 20}
XButton1 & Volume_Up:: Send, {Volume_Up 20}

; XButton1 & LButton:: Send {Media_Prev}
; XButton1 & MButton:: Send {Media_Play_Pause}
; XButton1 & RButton:: Send {Media_Next}




; NIGHT LIGHT
XButton1 & e::
Run, ms-settings:nightlight
WinWaitActive, Settings
Send, #{Up}
Sleep, 64
BlockInput, On
MouseGetPos, x_orig, y_orig
MouseClick, Left, 53, 206, 1 ; where's the on/off button
Sleep, 64
WinClose, A
MouseMove, %x_orig%, %y_orig%
BlockInput, Off
return

RAlt::Down

; faster arrows, 1 min steps on YT
/*
Ctrl & Left:: Send, {Left 12}
Ctrl & Right:: Send, {Right 12}
Ctrl & Up:: Send, {Up 12}
Ctrl & Down:: Send, {Down 12}
*/




; format
:r*?:ttt::
FormatTime, time_now,, yyyyMMdd_HHmmss
SendInput, %time_now%
return




; WEBSITES

XButton1 & f::
XButton1:: Run, https://www.google.com/

XButton1 & y::
Run, https://www.youtube.com/
Sleep, 2000
Send, {Tab 4}           
return

XButton1 & w::
    InputBox, to_solve, WolframAlpha,,, 256, 128
    clipboard := to_solve ; just in case
    if !ErrorLevel {
        Run, https://www.wolframalpha.com/
        WinWaitActive, ahk_exe chrome.exe
        WinWait, Wolfram|Alpha: Computational Intelligence
        Sleep, 500
        SendRaw, %to_solve%
        Send, {Enter}
    }
return

XButton1 & t:: Run https://twitter.com/home
XButton1 & d:: Run, https://drive.google.com/drive/my-drive

#n::
XButton1 & n:: Run, https://www.notion.so/

XButton1 & g::
    InputBox, to_run, Run,,, 256, 128
    array := {"monke": "https://monkeytype.com/"
        ,"rcs": "https://blender.community/c/rightclickselect/"
        ,"git": "https://github.com/aeraglyx"
        ,"ig": "https://www.instagram.com/"
        ,"we": "https://wetransfer.com/"
        ,"desmos": "https://www.desmos.com/calculator"
        ,"out": "https://outlook.office.com/mail/inbox"}
    if ErrorLevel {
        return
    }
    else If (array.HasKey(to_run)) {
        x := array[to_run]
        Run, %x%
    }
return




; SYMBOLS
+!<:: Send, {U+2264} ; ≤
+!>:: Send, {U+2265} ; ≥
::approx::{U+2248}   ; ≈
::notequal::{U+2260} ; ≠

; LATEX
:o:ltx::/latex{Down}{Enter} ; get LaTeX on Notion
:o:frac::\frac{{}{}}{{}{}}{Left 3}
:ro:fn::f(x)=
:ro:finv::f^{-1}(x)=

; spaces to underscores
XButton1 & u::
Send, ^c
Sleep, 64
txt := clipboard
txt := StrReplace(txt, " ", "_")
len := StrLen(txt)
Send, %txt%{ShiftDown}{Left %len%}{ShiftUp}
return



; AFTER EFFECTS
#ifWinActive ahk_exe AfterFX.exe

XButton1 & a::
Send, ^!y
Send, {Enter}glow{Enter}
Send, ^!y
Send, {Enter}chroma{Enter}
Send, ^!y
Send, {Enter}lin2log{Enter}
Send, ^!y
Send, {Enter}grain{Enter}
Send, ^!y
Send, {Enter}grade{Enter}
Return

; Black colour
XButton1 & b::
MouseClick, Left
SendRaw, 000000
Send, {Tab}{Enter}
Return

; White colour
XButton1 & w::
MouseClick, Left
SendRaw, FFFFFF
Send, {Tab}{Enter}
Return

^y:: Send, ^y{Tab 6}{Enter}{Tab 4}
^+y:: Send, ^+y{Tab 6}{Enter}{Tab 3}{Enter}

; PREMIERE PRO
/*
#ifWinActive ahk_exe Adobe Premiere Pro.exe
MButton::
MsgBox, Yes
return
*/




; CHROME
#ifWinActive ahk_exe chrome.exe

F1:: Send, ^+{Tab}
F2:: Send, ^w
F3:: Send, ^{Tab}
F4:: Send, ^t

XButton2:: Send, ^w

; make Ctrl + Z work
; BUG reloading triggers this
^z:: Send, !{Left}
^+z:: Send, !{Right}

#ifWinActive




; VS CODE
#ifWinActive ahk_exe Code.exe

F1:: Send, ^{PgUp}
; F2:: Send, ^w
F3:: Send, ^{PgDn}
F4:: Send, ^n

; comment
XButton1 & c:: Send, ^{/}

; PYTHON
:o*:pyread::
(
with open("file.txt", "r") as f:
    data = []
    for line in f.readlines():
        data.append(float(line))
)
return

:o*:pywrite::
(
with open("test.txt", "w") as f:
    for thing in final:
        f.write(str(thing))
        f.write("\n")
)
return

#ifWinActive




; SPOTIFY SEARCH
XButton1 & s::

if !WinExist("ahk_exe Spotify.exe"){
    Run, C:\Users\Vladislav\AppData\Local\Microsoft\WindowsApps\Spotify.exe
}
InputBox, to_play, Spotify Search, What to play on Spotify,, 256, 128

DetectHiddenWindows, On
;SetTitleMatchMode 2 
CoordMode, Mouse, Screen
if (ErrorLevel = 0) {
    MouseGetPos, OrigX, OrigY
    WinActivate, ahk_exe Spotify.exe
    WinWaitActive, ahk_exe Spotify.exe
    MouseClick, Left, -1192, -101, 2
    Send, %to_play%
    Sleep, 2000 ; timing
    MouseClick, Left, -1232, 109, 1
    Send, {ShiftDown}{Left 20}{ShiftUp}
    MouseMove, %OrigX%, %OrigY%
}

return