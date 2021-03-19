#NoEnv
#SingleInstance Force
#Persistent
SendMode Input

; RUN SUB-SCRIPTS
; Has to be before any hotkeys/returns etc. I guess.
Run, acc_scroll.ahk
;Run, acc_mouse.ahk

XButton1 & r:: Reload

#Include X:\Aeraglyx\secret.ahk
#Include functions.ahk

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




XButton1 & b:: toggle("color_picker.ahk")


; KEYBOARD LAYOUT TOGGLE
~LAlt Up::
if (A_PriorKey = "LShift"){
    toggle("en_cs_hybrid.ahk")
}
return




; VOLUME
; ± 40 for switching between headphones and speakers
XButton1 & Volume_Down:: Send, {Volume_Down 20}
XButton1 & Volume_Up:: Send, {Volume_Up 20}

XButton1 & LButton:: Send {Media_Prev}
XButton1 & RButton:: Send {Media_Next}
XButton1 & MButton:: Send {Media_Play_Pause}

; NIGHT LIGHT
XButton1 & e::
Run, ms-settings:nightlight
WinWaitActive, Settings
Send, #{Up}
;Sleep, 250
BlockInput, On
MouseGetPos, OrigX, OrigY
MouseClick, Left, 53, 206, 1 ; where's the on/off button
WinClose, A
MouseMove, %OrigX%, %OrigY%
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

XButton1 & w:: Run, https://www.wolframalpha.com/
XButton1 & t:: Run https://twitter.com/home
XButton1 & d:: Run, https://drive.google.com/drive/my-drive

#n::
XButton1 & n:: Run, https://www.notion.so/





; LATEX
:o:ltx::/latex{Down}{Enter} 
:o:frac::\frac{{}{}}{{}{}}{Left 3}
:ro:fn::f(x)=
:ro:finv::f^{-1}(x)=





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

^y:: Send, ^y{Tab 6}{Enter}{Tab 2}{Enter}{Enter}

; PREMIERE PRO
#ifWinActive ahk_exe Adobe Premiere Pro.exe
/*
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
^z:: Send, !{Left}
^+z:: Send, !{Right}
; TODO reloading triggers this

#ifWinActive




; QUICK SPOTIFY SEARCH
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