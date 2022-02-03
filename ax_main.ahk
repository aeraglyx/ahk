; run as admin, otherwise some of the functionality (eg. chrome hotkeys) won't work
; you'll need to have Python installed for some stuff

#NoEnv
#SingleInstance Force
#InstallKeybdHook
#Persistent
#KeyHistory, 2
SendMode Input

; SUB-SCRIPTS
; has to be run before any hotkeys/returns etc.
Run, support_scripts\acc_scroll.ahk
Run, support_scripts\acc_mouse.ahk

#Include functions.ahk
#Include *i secret.ahk
; #Include spotify_search.ahk

XButton1 & r:: Reload

RAlt:: Send, {Enter}

l1() {
	return GetKeyState("XButton1", "P")
}
l2() {
	return GetKeyState("XButton2", "P")
}





; d::
; 	Send, {F24}
; 	if (A_PriorKey != "F24") {
; 		Send, d
; 	} else {
; 		Send, s
; 	}
; 	return

; dd() {
; 	if (A_TimeIdlePhysical < 250 && A_PriorKey = "d") {
; 		return True
; 	} else {
; 		return False
; 	}
; }

; dddddddddfdfdddfdfddfdf
; #if dd()dddddddd
; k:: Send, {5}fssskkkkkkk



~XButton1::






#if l1()

; r:: Reload
q:: WinClose A

t:: Winset, AlwaysOnTop, Toggle, A
	WinGet, windows, List

; COLOR PICKER
c:: toggle("support_scripts\color_picker.ahk")

; MEASURE TOOL
m:: toggle("support_scripts\measure.ahk")

; SPOTIFY SEARCH
s:: Run, "support_scripts\spotify_search.ahk"

; NEW PROJECT
p:: Run, "support_files\new_project.py"

Numpad7::  ; duplicate display
	Send, #p
	Sleep, 64
	Send, {Home}{Down}
	Sleep, 64
	Send, {Enter}{Escape}
	Return

Numpad9::  ; extend display
	Send, #p
	Sleep, 64
	Send, {Home}{Down 2}
	Sleep, 64
	Send, {Enter}{Escape}
	Return



; hold L click without holding it
`::
	MouseGetPos, x_orig, y_orig
	Click, Down
	mouse_pressed := True
	Return
#if
#If mouse_pressed
$LButton::
	Click, Up
	mouse_pressed := False
	Return
$*Esc::`
$*RButton::
	MouseGetPos, x_new, y_new
	MouseMove, %x_orig%, %y_orig%, 0
	Click, Up
	MouseMove, %x_new%, %y_new%, 0
	mouse_pressed := False
	Return
; #ifWinActive  ; why?



#if l1()
; VOLUME & SOUND

Left::
PgUp::
LButton::
	Send {Media_Prev}
	Return

Space::
MButton::
	Send, {Media_Play_Pause}
	Return

Right::
PgDn::
RButton::
	Send {Media_Next}
	Return

XButton1 & 2:: Send, 1.41421356237 ; sqrt(2)
XButton1 & 3:: Send, 1.73205080757 ; sqrt(3)
XButton1 & 4:: Send, 1.57079632679 ; tau / 4


; spaces to underscores
; TODO other way around?
u::
	txt := selected()
	txt := StrReplace(txt, " ", "_")
	len := StrLen(txt)
	Send, %txt%{ShiftDown}{Left %len%}{ShiftUp}

	Return
; NIGHT LIGHT
e::
	Run, ms-settings:nightlight
	WinWaitActive, Settings
	Send, #{Up}
	Sleep, 128
	BlockInput, On
	MouseGetPos, x_orig, y_orig
	MouseClick, Left, 53, 206, 1
	Sleep, 32
	MouseMove, %x_orig%, %y_orig%
	WinClose, A
	BlockInput, Off
	Return

; FOCUS ASSIST
assist := false
a::
	SendInput, #{b}{Left}{AppsKey}{Down}{Down}{Right}
	if (assist = false) {
		SendInput, {Up}
		assist := true
	} else {
		assist := false
	}
	SendInput, {Enter}
	Sleep, 256
	SendInput, {Escape}
	Return

; FORCE MONO
n::
	Run, ms-settings:easeofaccess-audio
	WinWaitActive, Settings
	Send, #{Up}
	Sleep, 64
	BlockInput, On
	MouseGetPos, x_orig, y_orig
	MouseClick, Left, 366, 411, 1
	Sleep, 64
	WinClose, A
	MouseMove, %x_orig%, %y_orig%
	BlockInput, Off
	Return


; WEBSITES
g::
	txt := selected()
	If (txt = "") {
		Run, "https://www.google.com/"
	} Else If RegExMatch(txt, "^[a-zA-Z]:\\[\\\S|*\S]?.*$") {
		Run, %txt%
	} Else If RegExMatch(txt, "^(https?://|www\.)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$") {
		Run, %txt%
	} Else {
		query("https://www.google.com/search?q=", txt)
	}
	Return

y::
	txt := selected()
	If (txt = "") {
		Run, "https://www.youtube.com/"
		Sleep, 2000
		Send, {Tab 4}
	} Else {
		query("https://www.youtube.com/results?search_query=", txt)
	}      
	Return

w::
	InputBox, to_solve, WolframAlpha,,, 256, 128
	if !ErrorLevel {
		query("https://www.wolframalpha.com/input/?i=", to_solve)
	}
	Return

Volume_Down::
	; Send, {Volume_Down 20}
	Loop, 20 {
		Send, {Volume_Down}
		Sleep, 64
	}
	Return
Volume_Up::
	; Send, {Volume_Up 20}
	Loop, 20 {
		Send, {Volume_Up}
		Sleep, 64
	}
	Return

; BLENDER
; Copy over addons and restart Blender
#ifWinActive ahk_exe blender.exe

F5::

	git := "X:\Aeraglyx\Git"
	addons := ["fulcrum", "bbp_tools"]  ; "i-have-spoken"

	; versions := ["C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\2.93\scripts\addons"
	; 	,"C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\3.0\scripts\addons"]

	versions := ["C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\3.1\scripts\addons"
		, "C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\3.0\scripts\addons"]
	; TODO latest version OF latest version ?
	
	Process, Close, blender.exe

	For version in versions {
		For addon in addons {
			src := git . "\" . addons[addon]
			dst := versions[version] . "\" . addons[addon]
			FileCopyDir, %src%, %dst%, 1
		}
	}

	bl_folder := "X:\Software\Blender\daily"
	newest_time := 0
	Loop, Files, %bl_folder%\*, D
	{
		bl_time := A_LoopFileTimeCreated
		if (bl_time > newest_time) {
			newest_time := bl_time
			newest_blender := A_LoopFileFullPath
		}
	}
	newest_blender := newest_blender . "\blender.exe"
	Run, %newest_blender%

	Return



:*:fdfd::D.materials['Material'].node_tree.nodes.active.
; x:: Send, ^{/}

#IfWinActive


























#if l2()
t::
	Loop, %windows%
	{
		this_id := "ahk_id " . windows%A_Index%
		Winset, AlwaysOnTop, Off, %this_id%
	}
	WinGet, win_state, MinMax, A
	WinMaximize, A  ; sort of twice, because the windows remained on top
	WinRestore, A
	if (win_state = 1) {  ; if it was maximized
		WinMaximize, A
	}
	Return

2:: Send, 0.70710678118 ; sqrt(2) / 2
3:: Send, 0.86602540378 ; sqrt(3) / 2
4:: Send, 0.78539816339 ; tau / 8

#if





























; KEYBOARD LAYOUT
~LAlt Up::
	if (A_PriorKey = "LShift"){
		toggle("en_cs_hybrid.ahk")
	}
	Return



; -1 - minimized
;  0 - normal
;  1 - maximized

; check_win_center(){
; 	CoordMode, Mouse, Screen
; 	WinGet, win_state, MinMax, A
; 	WinGetPos, x, y, w, h, A
; 	center := x + w/2
; 	return
; }

#Numpad4::
XButton2 & F1::
XButton1 & Numpad4::
	; TODO check if it's on the right side, otherwise just make active?
	CoordMode, Mouse, Screen
	WinGetPos, x, y, w, h, A
	; WinGet, win_state, MinMax, A
	; MsgBox, %x% %y% %w% %h%
	
	center := x + w/2
	if (center > 0) {
		WinMove, A,, -1928, 905, 1936, 1056
		WinMaximize, A
	}
	Return

#Numpad5::
XButton2 & F2::
XButton1 & Numpad5::
	; center to main monitor
	CoordMode, Mouse, Screen
	; WinGet, win_state, MinMax, A
	WinGetPos, x, y, w, h, A
	WinRestore, A
	WinMove, A,, A_ScreenWidth/2 - w/2, A_ScreenHeight/2 - h/2, w, h
	Return
#Numpad2::

XButton1 & Numpad2::
	CoordMode, Mouse, Screen
	WinRestore, A
	WinMove, A,, A_ScreenWidth/2 - 512, A_ScreenHeight/2 - 512, 1024, 1024
	Return

#Numpad6::
XButton2 & F3::
XButton1 & Numpad6::
	; from left to right
	CoordMode, Mouse, Screen
	WinGetPos, x, y, w, h, A
	center := x + w/2
	if (center < 0) {
		WinMove, A,, -8, -8, 2576, 1416
		WinMaximize, A
	}
	Return







; XButton1 & F6::
; 	MouseGetPos, x_orig, y_orig
; 	MouseClick, Left, 19, 53, 1
; 	Send, {PgUp}{Down 6}{Right}
; 	; MouseMove, %x_orig%, %y_orig%, 0
; 	Return




^!WheelUp:: Send, ^{Home}
^!WheelDown:: Send, ^{End}











; Spotify ± 30s
#if l2()
XButton2 & Left::
	WinGet, prev_pid, PID, A
	WinActivate, ahk_exe Spotify.exe
	Send, +{Left 6}
	WinActivate, ahk_pid %prev_pid%
	Return

XButton2 & Right::
	WinGet, prev_pid, PID, A
	WinActivate, ahk_exe Spotify.exe
	Send, +{Right 6}
	WinActivate, ahk_pid %prev_pid%
	Return



; ± 40 for switching between headphones and speakers
#if







:*oc:boris::Mocha AE

; NUMBERS - Maybe only in Blender?

; SYMBOLS
+!<:: Send, {U+2264}	; ≤
+!>:: Send, {U+2265}	; ≥
::approx::{U+2248}		; ≈
::noteq::{U+2260}		; ≠
::+-::{U+00B1}			; ±
:*o:/alpha::{U+03B1}	; α

:*o:leftar::{U+2190}	; ←
:*o:rightar::{U+2192}	; →
:*o:upar::{U+2191}		; ↑
:*o:downar::{U+2193}	; ↓

!Numpad4:: Send, {U+2190}  ; ←
!Numpad6:: Send, {U+2192}  ; →
!Numpad8:: Send, {U+2191}  ; ↑
!Numpad2:: Send, {U+2193}  ; ↓

:*o:/epsilon::{U+03B5}	; ε
; LATEX
:o:ltx::/latex{Down}{Enter} ; get LaTeX on Notion
:o:frac::\frac{{}{}}{{}{}}{Left 3}
:ro:fn::f(x)=
:ro:finv::f^{-1}(x)=

; SOFTWARE HELP
::/bpy::Blender Python
::/ae::After Effects
::/fus::Blackmagic Fusion
::/res::DaVinci Resolve



; RAlt::Down
Shift & RAlt::Up




; format
; :r*?:ttt::
; FormatTime, time_now,, yyyyMMdd_HHmmss
; SendInput, %time_now%

; return
; encode time
; :r*?:ttt::
; 	time_now := A_NowUTC
; 	time_now -= 19700101000000, Seconds
; 	time_now := Floor(time_now / 60)
; 	time_now := to62(time_now)
; 	SendRaw, %time_now%
; 	Return

; decode time
; XButton1 & x::
; 	SendInput, ^{c}
; 	ClipWait, 1
; 	Sleep, 64
; 	unix := from62(Clipboard) * 60
; 	diff := A_Now - A_NowUTC
; 	out += unix, Seconds
; 	out := 19700101000000 + diff
; 	FormatTime, out, %out%, yyyy MMMM dd, HH:mm
; 	MsgBox,, Encoded at UTC, %out%
; 	Return







; AFTER EFFECTS
#ifWinActive ahk_exe AfterFX.exe

fx_console(effect){
	Send, {LControl down}
	Sleep, 128
	Send, {Space down}
	Sleep, 128
	Send, {LControl up}
	Sleep, 128
	Send, {Space up}
	Sleep, 256
	Send, %effect%
	Sleep, 256
	Send, {Enter}
	Sleep, 256
}

fx_subroutine(name, effect){
	Send, ^!y
	Send, {Enter}%name%{Enter}
	fx_console(effect)
	MouseClick, Middle, 1700, 1200,, 1
}

run_ae_script(script){
	ae_dir := "C:\Program Files\Adobe\Adobe After Effects 2022\Support Files"  ; XXX current AE version
	script_dir := A_ScriptDir . "\support_files\" . script
	RunWait, %ComSpec% /c afterfx -r %script_dir%, %ae_dir%
	WinMaximize, A
}

XButton1 & n::
	run_ae_script("ae_process.jsx")
	Return

XButton1 & i::
	run_ae_script("cineon.jsx")
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
XButton2 & `::  ; TODO change hotkey + AE script
	BlockInput, On
	MouseClick, Right
	MouseGetPos, x_orig, y_orig
	MouseClick, Left, 42, 190,, 1,, R
	MouseMove, %x_orig%, %y_orig%
	BlockInput, Off
	Return

; Clear cache
XButton2 & p::
	directory := "C:\Program Files\Adobe\Adobe After Effects 2021\Support Files"
	script := "app.purge(PurgeTarget.ALL_CACHES)"
	RunWait, %ComSpec% /c afterfx -s %script%, %directory%
	WinMaximize, A
	Return

^y:: Send, ^y{Tab 6}{Enter}{Tab 4} ; force new solids to have comp size
^+y:: Send, ^+y{Tab 6}{Enter}{Tab 3}{Enter} ; make current solid comp size

!+z:: Send, ^+h  ; overlay toggle

; PREMIERE PRO
; #ifWinActive ahk_exe Adobe Premiere Pro.exe




; CHROME
#ifWinActive ahk_exe chrome.exe

; f:: MsgBox, chroooomeeeee

F1:: Send, ^+{Tab}
; Moving tabs uses Rearrange Tabs:
; https://chrome.google.com/webstore/detail/rearrange-tabs/ccnnhhnmpoffieppjjkhdakcoejcpbga
XButton1 & F1:: Send, +!{Left}
XButton2 & F1:: Send, +!{Down}

F2:: Send, ^w

F3:: Send, ^{Tab}
XButton1 & F3:: Send, +!{Right}
XButton2 & F3:: Send, +!{Up}

F4:: Send, ^t

XButton2:: Send, ^w



; XButton1 & Numpad1::
; ; 28, 17
; 	WinGet, win_state, MinMax, A
; 	if (win_state = 1){
		
; 	}
; 	MouseGetPos, x_orig, y_orig
; 	Click, Down
; 	mouse_pressed := True

; 	MouseClick, Left, 28, 17, 1
; 	Return



; make Ctrl + Z work
; BUG reloading triggers this (does it?)
; TODO exception sites?
; ^z:: Send, !{Left}
; ^+z:: Send, !{Right}




; RESOLVE  ; TODO how to know which tab I'm in?
; #ifWinActive ahk_exe Resolve.exe
; ^d::
; 	Send, ^p
; 	return


; FUSION
#ifWinActive ahk_exe Fusion.exe
^d::
	Send, ^p
	return



; NUKE
#ifWinActive ahk_exe Nuke13.0.exe  ; XXX version

; Space::
; 	CoordMode, Mouse, Client
; 	if in_range_abs(45, 1945, 45, 780) {
; 		Send, l
; 	} else {
; 		Send, {Space}
; 	}
; 	return


; TODO then grab the node
; problem - zoom level - avg dist or find color or sth

#If in_range_abs(50, 1930, 800, 1350)
!LButton:: Send, {Click}^+
#If


; TODO node wrangler y to connect, shift+y to connect upwards
; !LButton::
; 	loop {
; 		MouseClick, Left
; 	}
; 	return





; VS CODE
#ifWinActive ahk_exe Code.exe

F1:: Send, ^{PgUp}
; F2:: Send, ^w
F3:: Send, ^{PgDn}
F4:: Send, ^n
XButton1 & x:: Send, ^{/}

^Up:: Send, {Up 8}
^Down:: Send, {Down 8}

^+n::
	Send, ^+n
	Sleep, 512
	WinMaximize, A
	Send, ^r
	return


; PYTHON

; XButton1 & p::
; 	SendRaw, print(f"{x = }")
; 	Send, {Left 7}{ShiftDown}{Right}{ShiftUp}
; 	Return

XButton1 & d::
	if RegExMatch(selected(), "\w")
		Send, {End}{Space 2}
	WinGetTitle, title, A
	if InStr(title, ".ahk")
		Send, {;}
	else if InStr(title, ".jsx") or InStr(title, ".dctl")
		SendRaw, //
	else
		Send, {#}
	Send, {Space}TODO{Space}
	Return


#ifWinActive





#ifWinActive ahk_exe blender.exe

:*:fdfd::D.materials['Material'].node_tree.nodes.active.
XButton1 & x:: Send, ^{/}

#IfWinActive