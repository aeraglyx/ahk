#NoEnv
#SingleInstance Force
; #InstallKeybdHook
#Persistent
SendMode Input

; SUB-SCRIPTS
; has to be run before any hotkeys/returns etc.
Run, acc_scroll.ahk
Run, acc_mouse.ahk

#Include functions.ahk
#Include *i secret.ahk
#Include spotify_search.ahk

; #InputLevel, 1
; RAlt:: Send, {XButton1}

; #InputLevel, 0


; XButton2:: Send {F24}
; F24 & Numpad8:: Send X

; F24 & Numpad8::
; 	Send, k
; 	Return


XButton1 & r:: Reload
XButton1 & q:: WinClose A

XButton1 & t:: Winset, AlwaysOnTop, Toggle, A
XButton2 & t::
	WinGet, windows, List
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




; COLOR PICKER
XButton1 & c:: toggle("color_picker.ahk")

; MEASURE TOOL
XButton1 & m:: toggle("measure.ahk")

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
	; WinGet, win_state, MinMax, A
	WinGetPos, x, y, w, h, A
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






; hold L click without holding it

XButton1 & `::
	MouseGetPos, x_orig, y_orig
	Click, Down
	mouse_pressed := True
	Return

#If mouse_pressed
$LButton::
	Click, Up
	mouse_pressed := False
	Return
$*Esc::
$*RButton::
	MouseGetPos, x_new, y_new
	MouseMove, %x_orig%, %y_orig%, 0
	Click, Up
	MouseMove, %x_new%, %y_new%, 0
	mouse_pressed := False
	Return

#ifWinActive  ; why?






; VOLUME & SOUND

XButton1 & Left::
XButton1 & PgUp::
XButton1 & LButton::
	Send {Media_Prev}
	Return

XButton1 & Space::
XButton1 & MButton::
	Send, {Media_Play_Pause}
	Return

XButton1 & Right::
XButton1 & PgDn::
XButton1 & RButton::
	Send {Media_Next}
	Return


; Spotify ± 30s
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
XButton1 & Volume_Down::
	; Send, {Volume_Down 20}
	Loop, 20 {
		Send, {Volume_Down}
		Sleep, 64
	}
	Return
XButton1 & Volume_Up::
	; Send, {Volume_Up 20}
	Loop, 20 {
		Send, {Volume_Up}
		Sleep, 64
	}
	Return





; NUMBERS - Maybe only in Blender?
XButton1 & 2:: Send, 1.41421356237 ; sqrt(2)
XButton2 & 2:: Send, 0.70710678118 ; sqrt(2) / 2
XButton1 & 3:: Send, 1.73205080757 ; sqrt(3)
XButton2 & 3:: Send, 0.86602540378 ; sqrt(3) / 2
XButton1 & 4:: Send, 1.57079632679 ; tau / 4
XButton2 & 4:: Send, 0.78539816339 ; tau / 8

; SYMBOLS
+!<:: Send, {U+2264}	; ≤
+!>:: Send, {U+2265}	; ≥
::approx::{U+2248}		; ≈
::noteq::{U+2260}		; ≠
::+-::{U+00B1}			; ±
:*o:/alpha::{U+03B1}	; α
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
	MouseClick, Left, 53, 206, 1
	Sleep, 64
	WinClose, A
	MouseMove, %x_orig%, %y_orig%
	BlockInput, Off
	Return

; FOCUS ASSIST
assist := false
XButton1 & a::
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
XButton1 & n::
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
; 	out := 19700101000000 + diff
; 	out += unix, Seconds
; 	FormatTime, out, %out%, yyyy MMMM dd, HH:mm
; 	MsgBox,, Encoded at UTC, %out%
; 	Return



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
	ae_dir := "C:\Program Files\Adobe\Adobe After Effects 2021\Support Files"
	script_dir := A_ScriptDir . "\support_files\" . script
	RunWait, %ComSpec% /c afterfx -r %script_dir%, %ae_dir%
	WinMaximize, A
}

XButton1 & n::
	run_ae_script("ae_process.jsx")
	Return

XButton1 & m::
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
XButton1 & p::
	directory := "C:\Program Files\Adobe\Adobe After Effects 2021\Support Files"
	script := "app.purge(PurgeTarget.ALL_CACHES)"
	RunWait, %ComSpec% /c afterfx -s %script%, %directory%
	WinMaximize, A
	Return

^y:: Send, ^y{Tab 6}{Enter}{Tab 4} ; force new solids to have comp size
^+y:: Send, ^+y{Tab 6}{Enter}{Tab 3}{Enter} ; make current solid comp size

; PREMIERE PRO
; #ifWinActive ahk_exe Adobe Premiere Pro.exe




; CHROME
#ifWinActive ahk_exe chrome.exe

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

; make Ctrl + Z work
; BUG reloading triggers this
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

XButton1 & p::
	SendRaw, print(f"{x = }")
	Send, {Left 7}{ShiftDown}{Right}{ShiftUp}
	Return

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



; BLENDER
; Copy over addons and restart Blender

XButton1 & F5::

	git := "X:\Aeraglyx\Git"
	addons := ["fulcrum", "bbp_tools"]  ; "i-have-spoken"

	; versions := ["C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\2.93\scripts\addons"
	; 	,"C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\3.0\scripts\addons"]

	versions := ["C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\3.1\scripts\addons"]
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


#ifWinActive ahk_exe blender.exe

:*:fdfd::D.materials['Material'].node_tree.nodes.active.
XButton1 & x:: Send, ^{/}

#IfWinActive