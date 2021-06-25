#NoEnv
#SingleInstance Force
#Persistent
SendMode Input

; SUB-SCRIPTS
; has to be run before any hotkeys/returns etc.
Run, acc_scroll.ahk
;Run, acc_mouse.ahk

#Include functions.ahk
#Include *i secret.ahk

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

; MEASURE TOOL
XButton1 & m:: toggle("measure.ahk")

; KEYBOARD LAYOUT
~LAlt Up::
	if (A_PriorKey = "LShift"){
		toggle("en_cs_hybrid.ahk")
	}
	Return




; VOLUME & SOUND
; ± 40 for switching between headphones and speakers
XButton1 & Volume_Down:: Send, {Volume_Down 20}
XButton1 & Volume_Up:: Send, {Volume_Up 20}

; XButton1 & LButton:: Send {Media_Prev}
; XButton1 & MButton:: Send {Media_Play_Pause}
; XButton1 & RButton:: Send {Media_Next}

; NUMBERS - Maybe only in Blender?
XButton1 & 2:: Send, 1.41421356237 ; sqrt(2)
XButton2 & 2:: Send, 0.70710678118 ; sqrt(2) / 2
XButton1 & 3:: Send, 1.73205080757 ; sqrt(3)
XButton2 & 3:: Send, 0.86602540378 ; sqrt(3) / 2
XButton1 & 4:: Send, 1.57079632679 ; tau / 4
XButton2 & 4:: Send, 0.78539816339 ; tau / 8

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
; TODO other way around?
XButton1 & u::
	txt := selected()
	txt := StrReplace(txt, " ", "_")
	len := StrLen(txt)
	Send, %txt%{ShiftDown}{Left %len%}{ShiftUp}
	Return

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
	Return

RAlt::Down

; faster arrows, 1 min steps on YT
/*
Ctrl & Left:: Send, {Left 12}
Ctrl & Right:: Send, {Right 12}
Ctrl & Up:: Send, {Up 12}
Ctrl & Down:: Send, {Down 12}
*/




; format
; :r*?:ttt::
; FormatTime, time_now,, yyyyMMdd_HHmmss
; SendInput, %time_now%
; return

; encode time
:r*?:ttt::
	time_now := A_NowUTC
	time_now -= 19700101000000, Seconds
	time_now := Floor(time_now / 60)
	time_now := to62(time_now)
	SendRaw, %time_now%
	Return

; decode time
XButton1 & x::
	SendInput, ^{c}
	ClipWait, 1
	Sleep, 64
	unix := from62(Clipboard) * 60
	diff := A_Now - A_NowUTC
	out := 19700101000000 + diff
	; out -= diff, Seconds
	out += unix, Seconds
	FormatTime, out, %out%, yyyy MMMM dd, HH:mm
	MsgBox,, Encoded at UTC, %out%
	Return



; WEBSITES

XButton1 & g::
	txt := selected()
	If (txt = "") {
		Run, "https://www.google.com/"
	} Else {
		query("https://www.google.com/search?q=", txt)
	}
	Return

XButton1 & y::
	txt := selected()
	If (txt = "") {
		Run, "https://www.youtube.com/"
		Sleep, 2000
		Send, {Tab 4}
	} Else {
		query("https://www.youtube.com/results?search_query=", txt)
	}      
	Return

XButton1 & w::
	InputBox, to_solve, WolframAlpha,,, 256, 128
	if !ErrorLevel {
		query("https://www.wolframalpha.com/input/?i=", to_solve)
	}
	Return

XButton1 & t:: Run https://twitter.com/home
XButton1 & d:: Run, https://drive.google.com/drive/my-drive
XButton1 & n:: Run, https://www.notion.so/

XButton1 & f::
	InputBox, to_run, Run,,, 256, 128
	array := {"monke": "https://monkeytype.com/"
		,"assets": "X:\Assets"
		,"utb": "X:\UTB"
		,"rec": "X:\Cache\Desktop"
		,"rcs": "https://blender.community/c/rightclickselect/"
		,"git": "https://github.com/aeraglyx"
		,"ig": "https://www.instagram.com/"
		,"we": "https://wetransfer.com/"
		,"desmos": "https://www.desmos.com/calculator"
		,"out": "https://outlook.office.com/mail/inbox"
		,"idos": "https://idos.idnes.cz/vlakyautobusymhdvse/spojeni/"}
	if ErrorLevel {
		Return
	}
	else If (array.HasKey(to_run)) {
		x := array[to_run]
		Run, %x%
	}
	Return



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

; Reload footage
XButton1 & `::
	BlockInput, On
	MouseClick, Right
	MouseGetPos, x_orig, y_orig
	MouseClick, Left, 42, 190,, 1,, R
	MouseMove, %x_orig%, %y_orig%
	BlockInput, Off
	Return

^y:: Send, ^y{Tab 6}{Enter}{Tab 4}
^+y:: Send, ^+y{Tab 6}{Enter}{Tab 3}{Enter}

; PREMIERE PRO
; #ifWinActive ahk_exe Adobe Premiere Pro.exe




; CHROME
#ifWinActive ahk_exe chrome.exe

F1:: Send, ^+{Tab}
F2:: Send, ^w
F3:: Send, ^{Tab}
F4:: Send, ^t

XButton2:: Send, ^w

; make Ctrl + Z work
; BUG reloading triggers this
; ^z:: Send, !{Left}
; ^+z:: Send, !{Right}

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
Return

:o*:pywrite::
(
with open("test.txt", "w") as f:
	for thing in final:
		f.write(str(thing))
		f.write("\n")
)
Return

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
		MouseClick, Left, -1525, -15, 1
		MouseClick, Left, -1100, -94, 3
		Send, %to_play%
		Sleep, 2000 ; timing
		MouseClick, Left, -956, 176, 1
		; Send, {ShiftDown}{Left 20}{ShiftUp}
		MouseMove, %OrigX%, %OrigY%
		; Run, Spotify:search:%searchQuery% ; TODO
	}
	Return

; BLENDER
; Copy over my addon and restart Blender
; TODO path for blender at top as variable
; TODO for loop for dst folders
XButton1 & F5::
	Process, Close, blender.exe
	src := "X:\Aeraglyx\Git\fulcrum"
	dst293 := "C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\2.93\scripts\addons\fulcrum"
	dst300 := "C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\3.0\scripts\addons\fulcrum"
	FileCopyDir, %src%, %dst293%, 1
	FileCopyDir, %src%, %dst300%, 1
	Run, "X:\Software\Blender\daily\blender-2.93.0-beta+blender-v293-release.d5c3bff6e774-windows.amd64-release\blender.exe"
	Return

#ifWinActive ahk_exe blender.exe
:*:ddd::D.materials['Material'].node_tree.nodes.active.
#IfWinActive