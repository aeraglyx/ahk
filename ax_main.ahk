#NoEnv
#SingleInstance Force
SendMode Input

XButton1 & r::
Reload
Return

Run, acc_scroll.ahk
Run, acc_mouse.ahk

#Include X:\Aeraglyx\secret.ahk
;#Include functions.ahk



; VOLUME
; ± 40 for switching between headphones and speakers
XButton1 & Volume_Down::
Send, {Volume_Down 20}
Return
XButton1 & Volume_Up::
Send, {Volume_Up 20}
Return

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

; faster arrows
; 1 min steps on YT
Ctrl & Left::
Send, {Left 12}
return
Ctrl & Right::
Send, {Right 12}
return
Ctrl & Up::
Send, {Up 12}
return
Ctrl & Down::
Send, {Down 12}
return





; format
:r*?:ttt::
FormatTime, time_now,, yyyyMMdd_HHmmss
SendInput, %time_now%
return





; WEBSITES

/*XButton1::
Run, https://keep.google.com/u/0/
return
*/

#g::
XButton1 & f::
XButton1::
Run, https://www.google.com/
return

XButton1 & d::
Run, https://drive.google.com/drive/my-drive
return

XButton1 & t::
Run, https://www.youtube.com/
Sleep, 2000
Send, {Tab 4}           
return
XButton1 & w::
/*IfWinExist Watch later - YouTube - Google Chrome
    MsgBox, yes
*/
Run, https://www.youtube.com/playlist?list=WL
return

#n::
XButton1 & n::
Run, https://www.notion.so/
return


; LATEX
:o:ltx::/latex{Down}{Enter} 
:o:frac::\frac{{}{}}{{}{}}{Left 3}
:ro:fn::f(x)=
:ro:finv::f^{-1}(x)=



; After Effects
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

^y::
Send, ^y{Tab 6}{Enter}{Tab 2}{Enter}{Enter}
Return

;^!y::
;^!#t::





; CHROME
#ifWinActive ahk_exe chrome.exe

F1::
Send, ^+{Tab}
return
F2::
Send, ^w
return
F3::
Send, ^{Tab}
return
F4::
Send, ^t
return

XButton2::
Send, ^w
return

; make Ctrl + Z work
^z::
Send, !{Left}
return
^+z::
Send, !{Right}
return

#ifWinActive





; KEYBOARD LAYOUT TOGGLE
~Alt Up::
if (A_PriorKey = "LShift"){
    DetectHiddenWindows, On
    SetTitleMatchMode, 2 
    if WinExist("en_cs_hybrid.ahk") {
        WinClose, en_cs_hybrid.ahk
        TrayTip Keyboard Layout, EN, 2
    } else {
        Run, en_cs_hybrid.ahk
        TrayTip Keyboard Layout, CS, 2
    }
}
return





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