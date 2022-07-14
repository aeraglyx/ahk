; run as admin, otherwise some of the functionality (eg. chrome hotkeys) won't work
; you'll need to have Python installed for some stuff

#SingleInstance Force
InstallKeybdHook
Persistent
KeyHistory 2
SendMode "Input"

; SUB-SCRIPTS
; has to be run before any hotkeys/returns etc.
Run("support_scripts\acc_scroll.ah2")
Run("support_scripts\acc_mouse.ah2")

#Include "functions.ah2"
#Include "support_scripts\kb_layout_stuff.ah2"
#Include "*i secret.ah2"
; #Include spotify_search.ah2

^!+x:: ExitApp

SoundSetVolume 12.5




XButton2 & t:: switch_to("chrome", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
XButton2 & c:: switch_to("Code", "C:\Users\Vladislav\AppData\Local\Programs\Microsoft VS Code\Code.exe")
XButton2 & s:: switch_to("Spotify", "C:\Users\Vladislav\AppData\Local\Microsoft\WindowsApps\Spotify.exe")
XButton2 & f:: switch_to("blender", newest_blender())





; RAlt:: Send, {Backspace}

l1() {
	return GetKeyState("XButton1", "P")
}
l2() {
	return GetKeyState("XButton2", "P")
}

; ^Volume_Down:: {
; 	Loop 20 {
; 		Send "{Volume_Down}"
; 		Sleep 64
; 	}
; }

Volume_Down::
Volume_Up:: {
	volume := SoundGetVolume()
	ratio := 1.25992105  ; 2^(1/n) means n strokes for doubling
	if A_ThisHotkey = "Volume_Down" {
		volume /= ratio
	} else {
		volume *= ratio
	}
	SoundSetVolume volume
	CoordMode "ToolTip", "Screen"
	ToolTip round(volume, 2), 64, 128
	SetTimer () => ToolTip(), -1000
}


^!WheelUp:: Send "^{Home}"
^!WheelDown:: Send "^{End}"

; #`:: {
; 	MouseGetPos	&x_orig, &y_orig
; }

; #` Up:: {
; 	MouseGetPos &x_new, &y_new
; 	x_diff := x_new - x_orig
; 	y_diff := y_new - y_orig
; 	MouseMove x_orig, y_orig
; 	if (max(abs(x_diff), abs(y_diff)) > 64) {
; 		if (abs(x_diff) > abs(y_diff)) {
; 			; horizontal
; 			if (x_diff < 0) {
; 				; left
; 				Run "X:\projects"
; 				WinActivate "projects"
; 				; MsgBox, left
; 			} else {
; 				; right
; 				; chrome_new_tab()
; 			}
; 		} else {
; 			;vertical
; 			if (y_diff < 0) {
; 				; up
; 				Run "X:\UTB"
; 				WinActivate "UTB"
; 			} else {
; 				; down
; 				Run "X:\assets"
; 				WinActivate "assets"
; 			}
; 		}
; 	}
; }




#HotIf l1()

r:: Reload
q:: WinClose "A"
t:: Send "^#{a}"

; c:: toggle("support_scripts\color_picker.ahk")
; m:: toggle("support_scripts\measure.ahk")

; s:: Run "support_scripts\spotify_search.ah2"
p:: Run "support_files\new_project.py"

; 2:: Send "1.41421356237" ; sqrt(2)
; 3:: Send "1.73205080757" ; sqrt(3)
; 4:: Send "1.57079632679" ; tau / 4


; Numpad7:: {  ; duplicate display
; 	Send "#p"
; 	Sleep 64
; 	Send "{Home}{Down}"
; 	Sleep 64
; 	Send "{Enter}{Escape}"
; }

; Numpad9:: {  ; extend display
; 	Send "#p"
; 	Sleep 64
; 	Send "{Home}{Down 2}"
; 	Sleep 64
; 	Send "{Enter}{Escape}"
; }

; hold L click without holding it
; `:: {
; 	MouseGetPos &x_orig, &y_orig
; 	Click "Down"
; 	mouse_pressed := True
; }

; if mouse_pressed {
; 	$LButton:: {
; 		Click "Up"
; 		mouse_pressed := False
; 	}
; 	$*Esc::`
; 	$*RButton:: {
; 		MouseGetPos &x_new, &y_new
; 		MouseMove x_orig, y_orig, 0
; 		Click "Up"
; 		MouseMove x_new, y_new, 0
; 		mouse_pressed := False
; 	}
; }
; #ifWinActive  ; why?






; spaces to underscores
; TODO other way around?
; u:: {
; 	txt := selected()
; 	txt := StrReplace(txt, " ", "_")
; 	len := StrLen(txt)
; 	Send %txt%{ShiftDown}{Left %len%}{ShiftUp}
; }

; NIGHT LIGHT
; ^+!e::
; e:: {
; 	Run "ms-settings:nightlight"
; 	WinWaitActive "Settings"
; 	Send "#{Up}"
; 	Sleep 128
; 	BlockInput true
; 	MouseGetPos &x_orig, &y_orig
; 	MouseClick "Left", 53, 206, 1
; 	Sleep 32
; 	MouseMove x_orig, y_orig
; 	WinClose "A"
; 	BlockInput false
; }

; FOCUS ASSIST
; assist := false
; a:: {
; 	SendInput "#{b}{Left}{AppsKey}{Down}{Down}{Right}"
; 	if (assist = false) {
; 		SendInput "{Up}"
; 		assist := true
; 	} else {
; 		assist := false
; 	}
; 	SendInput "{Enter}"
; 	Sleep 256
; 	SendInput "{Escape}"
; }

; FORCE MONO
; n::
; 	Run, ms-settings:easeofaccess-audio
; 	WinWaitActive, Settings
; 	Send, #{Up}
; 	Sleep, 64
; 	BlockInput, On
; 	MouseGetPos, x_orig, y_orig
; 	MouseClick, Left, 366, 411, 1
; 	Sleep, 64
; 	WinClose, A
; 	MouseMove, %x_orig%, %y_orig%
; 	BlockInput, Off
; 	Return


; WEBSITES
g:: {
	txt := selected()
	if (txt = "") {
		Run "https://www.google.com/"
	} else if RegExMatch(txt, "^[a-zA-Z]:\\[\\\S|*\S]?.*$") {
		Run(txt)
	} else if RegExMatch(txt, "^(https?://|www\.)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$") {
		Run(txt)
	} else {
		query("https://www.google.com/search?q=", txt)
	}
}

y:: {
	txt := selected()
	if (txt = "") {
		Run "https://www.youtube.com/"
		Sleep 2000
		Send "{Tab 4}"
	} else {
		query("https://www.youtube.com/results?search_query=", txt)
	}      
}

; w:: {
; 	to_solve := InputBox(,"WolframAlpha", "w256 h128")
; 	; bad := ["OK", "Cancel", "Timeout"]
; 	if !(to_solve = "OK" | to_solve = "Cancel" | to_solve = "Timeout") {
; 		query("https://www.wolframalpha.com/input/?i=", to_solve)
; 	}
; }




; BLENDER
; Copy over addons and restart Blender

F5:: {
	git := "X:\git"
	addons := ["fulcrum"]
	versions := ["C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\3.2\scripts\addons"
		, "C:\Users\Vladislav\AppData\Roaming\Blender Foundation\Blender\3.3\scripts\addons"]
	ProcessClose "blender.exe"
	for version in versions {
		for addon in addons {
			src := git . "\" . addon
			dst := version . "\" . addon
			DirCopy src, dst, 1
		}
	}
	Run newest_blender()
}



; :*:fdfd::D.materials['Material'].node_tree.nodes.active.
; ; x:: Send, ^{/}

; #IfWinActive



#HotIf l2()

; t:: {
; 	Loop, %windows% {
; 		this_id := "ahk_id " . windows%A_Index%
; 		Winset, AlwaysOnTop, Off, %this_id%
; 	}
; 	WinGet, win_state, MinMax, A
; 	WinMaximize, A  ; sort of twice, because the windows remained on top
; 	WinRestore, A
; 	if (win_state = 1) {  ; if it was maximized
; 		WinMaximize, A
; 	}
; }

; 2:: Send "0.70710678118" ; sqrt(2) / 2
; 3:: Send "0.86602540378" ; sqrt(3) / 2
; 4:: Send "0.78539816339" ; tau / 8

; Left:: {
; 	WinGet prev_pid, PID, A
; 	WinActivate ahk_exe Spotify.exe
; 	Send "+{Left 6}"
; 	WinActivate ahk_pid %prev_pid%
; }

; Right:: {
; 	WinGet prev_pid, PID, A
; 	WinActivate ahk_exe Spotify.exe
; 	Send "+{Right 6}"
; 	WinActivate ahk_pid %prev_pid%
; }







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

; #Numpad4::
; XButton2 & F1::
; XButton1 & Numpad4::
; 	; TODO check if it's on the right side, otherwise just make active?
; 	CoordMode, Mouse, Screen
; 	WinGetPos, x, y, w, h, A
; 	; WinGet, win_state, MinMax, A
; 	; MsgBox, %x% %y% %w% %h%
	
; 	center := x + w/2
; 	if (center > 0) {
; 		WinMove, A,, -1928, 905, 1936, 1056
; 		WinMaximize, A
; 	}
; 	Return

; #Numpad5::
; XButton2 & F2::
; XButton1 & Numpad5::
; 	; center to main monitor
; 	CoordMode, Mouse, Screen
; 	; WinGet, win_state, MinMax, A
; 	WinGetPos, x, y, w, h, A
; 	WinRestore, A
; 	WinMove, A,, A_ScreenWidth/2 - w/2, A_ScreenHeight/2 - h/2, w, h
; 	Return
; #Numpad2::

; XButton1 & Numpad2::
; 	CoordMode, Mouse, Screen
; 	WinRestore, A
; 	WinMove, A,, A_ScreenWidth/2 - 512, A_ScreenHeight/2 - 512, 1024, 1024
; 	Return

; #Numpad6::
; XButton2 & F3::
; XButton1 & Numpad6::
; 	; from left to right
; 	CoordMode, Mouse, Screen
; 	WinGetPos, x, y, w, h, A
; 	center := x + w/2
; 	if (center < 0) {
; 		WinMove, A,, -8, -8, 2576, 1416
; 		WinMaximize, A
; 	}
; 	Return


; XButton1 & F6::
; 	MouseGetPos, x_orig, y_orig
; 	MouseClick, Left, 19, 53, 1
; 	Send, {PgUp}{Down 6}{Right}
; 	; MouseMove, %x_orig%, %y_orig%, 0
; 	Return

#HotIf






:*oc:boris::Mocha AE

; NUMBERS - Maybe only in Blender?

; SYMBOLS
+!<:: Send "{U+2264}"	; ≤
+!>:: Send "{U+2265}"	; ≥
::approx::{U+2248}		; ≈
::noteq::{U+2260}		; ≠
::+-::{U+00B1}			; ±
:*o:/alpha::{U+03B1}	; α

:*o:leftar::{U+2190}	; ←
:*o:rightar::{U+2192}	; →
:*o:upar::{U+2191}		; ↑
:*o:downar::{U+2193}	; ↓

!Numpad4:: Send "{U+2190}"  ; ←
!Numpad6:: Send "{U+2192}"  ; →
!Numpad8:: Send "{U+2191}"  ; ↑
!Numpad2:: Send "{U+2193}"  ; ↓

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
#HotIf WinActive("ahk_exe AfterFX.exe")

^y:: Send "^y{Tab 6}{Enter}{Tab 4}" ; force new solids to have comp size
^+y:: Send "^+y{Tab 6}{Enter}{Tab 3}{Enter}" ; make current solid comp size

!+z:: Send "^+h"  ; overlay toggle

; fx_console(effect){
; 	Send "{LControl down}"
; 	Sleep 128
; 	Send "{Space down}"
; 	Sleep 128
; 	Send "{LControl up}"
; 	Sleep 128
; 	Send "{Space up}"
; 	Sleep 256
; 	Send effect
; 	Sleep 256
; 	Send "{Enter}"
; 	Sleep 256
; }

; fx_subroutine(name, effect){
; 	Send "^!y"
; 	Send "{Enter}%name%{Enter}"
; 	fx_console(effect)
; 	MouseClick "Middle", 1700, 1200,, 1
; }

; run_ae_script(script){
; 	ae_dir := "C:\Program Files\Adobe\Adobe After Effects 2022\Support Files"  ; XXX current AE version
; 	script_dir := A_ScriptDir . "\support_files\" . script
; 	RunWait %ComSpec% /c afterfx -r %script_dir%, %ae_dir%
; 	WinMaximize "A"
; }

; XButton1 & n::
; 	run_ae_script("ae_process.jsx")
; 	Return

; XButton1 & i::
; 	run_ae_script("cineon.jsx")
; 	Return

; ; Black colour
; XButton1 & b::
; 	MouseClick, Left
; 	SendRaw, 000000
; 	Send, {Tab}{Enter}
; 	Return

; ; White colour
; XButton1 & w::
; 	MouseClick, Left
; 	SendRaw, FFFFFF
; 	Send, {Tab}{Enter}
; 	Return

; Reload footage
; XButton2 & `:: {  ; TODO change hotkey + AE script
; 	BlockInput "On"
; 	MouseClick "Right"
; 	MouseGetPos x_orig, y_orig
; 	MouseClick "Left", 42, 190,, 1,, R
; 	MouseMove %x_orig%, %y_orig%
; 	BlockInput "Off"
; }

; Clear cache
; XButton2 & p:: {
; 	directory := "C:\Program Files\Adobe\Adobe After Effects 2021\Support Files"
; 	script := "app.purge(PurgeTarget.ALL_CACHES)"
; 	RunWait %ComSpec% /c afterfx -s %script%, %directory%
; 	WinMaximize A
; }




; CHROME
#HotIf WinActive("ahk_exe chrome.exe")

F1:: Send "^+{Tab}"
; Moving tabs uses Rearrange Tabs:
; https://chrome.google.com/webstore/detail/rearrange-tabs/ccnnhhnmpoffieppjjkhdakcoejcpbga
F2:: Send "^w"
F3:: Send "^{Tab}"
F4:: Send "^t"
; XButton2:: Send "^w"



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




; ; RESOLVE  ; TODO how to know which tab I'm in?
; #HotIf WinActive("ahk_exe Resolve.exe")
; ^d:: Send "^p"

; ; FUSION
; #HotIf WinActive("ahk_exe Fusion.exe")
; ^d:: Send "^p"



; NUKE
#HotIf WinActive("ahk_exe Nuke13.2.exe")  ; XXX version

y1 := 0
y2 := 0

!RButton:: {
	CoordMode "Mouse", "Screen"
	BlockInput "On"
	MouseGetPos , &y1
	Send "{Click}"
	BlockInput "Off"
}
!RButton UP:: {
	CoordMode "Mouse", "Screen"
	MouseGetPos , &y2
	Send "+{Click}"
	if (y2 > y1) {
		Send "+y"
	} else {
		Send "y"
	}
}

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

; #If in_range_abs(50, 1930, 800, 1350)
; !LButton:: Send, {Click}^+




; VS CODE
#HotIf WinActive("ahk_exe Code.exe")

F1:: Send "^{PgUp}"
; F2:: Send, ^w
F3:: Send "^{PgDn}"
F4:: Send "^n"
XButton1 & c:: Send "^{/}"

^Up:: Send "{Up 8}"
^Down:: Send "{Down 8}"

^+n:: {
	Send "^+n"
	Sleep 512
	WinMaximize "A"
	Send "^r"
}


; PYTHON

; XButton1 & p::
; 	SendRaw, print(f"{x = }")
; 	Send, {Left 7}{ShiftDown}{Right}{ShiftUp}
; 	Return


XButton1 & d:: {
	if RegExMatch(selected(), "\w"){
		Send("{End}{Space 2}")
	}
	title := WinGetTitle("A")
	dict := Map("ahk", "{;}", "ah2", "{;}", "jsx", "//", "dctl", "//", "py", "{#}")
	for ext in dict {
		if InStr(title, "." . ext){
			Send(dict[ext])
		}
		break
	}
	Send("{Space}TODO{Space}")
}


#HotIf





; #ifWinActive ahk_exe blender.exe

; :*:fdfd::D.materials['Material'].node_tree.nodes.active.
; ; XButton1 & x:: Send, ^{/}

; #HotIf