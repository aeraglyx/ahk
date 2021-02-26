#NoEnv
#SingleInstance Force
SendMode Input

XButton1 & r::
Reload
Return

; system
XButton1 & Volume_Down::
Send, {Volume_Down 20}
Return
XButton1 & Volume_Up::
Send, {Volume_Up 20}
Return

; night light
XButton1 & e::
;Send, {LWinDown}{LWinUp}night light{Enter}
Run, ms-settings:nightlight
Sleep, 250
Send, {Tab 3}{Enter}
Send, !{F4}
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




; info
:o:vm::Vladislav Mac{U+00ED}{U+010D}ek
:o:@me::vladislav.cam{2}{4}{@}gmail.com
:o*:v_m::v_macicek
;:o*:(::(){Left}

; format
:r*?:ttt::
FormatTime, time_now,, yyyyMMdd_HHmmss
SendInput, %time_now%
return

:r*?:mrcl::
FormatTime, date_now,, yyyyMMdd
SendInput, %date_now%
Send, _title_v_macicek_v01{Left 14}{Shift Down}{Left 5}{Shift Up}
return
:r*?:avcf::
Send, v_macicek_AV2FC_cviceni_2_v01{Left 4}{Shift Down}{Left}{Shift Up}
return




; websites

/*XButton1::
Run, https://keep.google.com/u/0/
return
*/

#g::
XButton1 & f::
;XButton1::
Run, https://www.google.com/
return

XButton1 & d::
Run, https://drive.google.com/drive/my-drive
return

#y::
XButton1 & t::
Run, https://www.youtube.com/
Sleep, 2000
Send, {Tab 4}           
return
#o::
XButton1 & w::
IfWinExist Watch later - YouTube - Google Chrome
    MsgBox, yes
;Run, https://www.youtube.com/playlist?list=WL
return

#n::
Run, https://www.notion.so/
return
XButton1::
Run, https://www.notion.so/Ideas-c162763c26ce4077a4eb4c55e6eedfb2
return

/*
; DEBUG
XButton1 & z::
If WinExist("Watch later - YouTube - Google Chrome")
    WinActivate
    MsgBox, works
else {
    toFind := "Watch later - YouTube - Google Chrome"
    WinGetActiveTitle, StartingTitle
    loop{
        Send, {Control down}{Tab}{Control Up}
        Sleep, 400
        IfWinActive, %toFind%
            Return
        WinGetActiveTitle, CurrentTabTitle
        If (CurrentTabTitle == StartingTitle)
            break
    }
    Run, https://webpage/index.php
}
return
*/


; latex
:o:ltx::/latex{Down}{Enter} 
:o:frac::\frac{{}{}}{{}{}}{Left 3}
:ro:fn::f(x)=
:ro:finv::f^{-1}(x)=

; scroll
;Scroll:



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

#ifWinActive

/*
XButton2 & r::
Coordmode, Mouse, Screen
MouseGetPos, OrigX, OrigY
MouseClick, Right
MouseClick, Left
MouseMove, 10, -200, 0, R
return
*/





; CUSTOM KEYBOARD LAYOUT 
XButton1 & b::
DetectHiddenWindows, On
SetTitleMatchMode, 2 
if WinExist("en_cs_hybrid.ahk") {
    WinClose, en_cs_hybrid.ahk
    TrayTip Custom Keyboard Layout, Disabled., 2
    ;MsgBox, 0, Custom Keyboard Layout, OFF, 0.75
} else {
    Run, X:\Aeraglyx\Git\ahk\en_cs_hybrid.ahk
    TrayTip Custom Keyboard Layout, Enabled., 2
    ;MsgBox, 0, Custom Keyboard Layout, ON, 0.75
}
return







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