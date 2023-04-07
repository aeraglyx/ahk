; run as admin, otherwise some of the functionality (eg. chrome hotkeys) won't work
; you'll need to have Python installed for some stuff

#SingleInstance Force
InstallKeybdHook
Persistent
KeyHistory 2
SendMode "Input"

; SUB-SCRIPTS
; has to be run before any hotkeys/returns etc.
Run("support_scripts\acc_scroll.ahk")
Run("support_scripts\acc_mouse.ahk")

#Include "functions.ahk"
#Include "support_scripts\kb_layout_stuff.ahk"
#Include "*i secret.ahk"
; #Include spotify_search.ahk

^!+x:: ExitApp

; SoundSetVolume 12.5


l1() {
	return GetKeyState("XButton1", "P")
}
l2() {
	return GetKeyState("XButton2", "P")
}


main_pc() {
	return A_ComputerName = "FULCRUM"
}
bbp_pc() {
	return A_ComputerName = "BBP-P-N03"
}
home_pc() {
	return A_ComputerName = "BEN"
}

; MsgBox home_pc()




; APP SWITCHER

#HotIf l1() and main_pc()
f:: switch_to("Files ahk_exe ApplicationFrameHost.exe", "C:\Users\Vladislav\AppData\Local\Files\FilesLauncher.exe")
t:: switch_to("ahk_exe chrome.exe", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
s:: switch_to("ahk_exe Spotify.exe", "C:\Users\Vladislav\AppData\Local\Microsoft\WindowsApps\Spotify.exe")
c:: switch_to("ahk_exe Code.exe", "C:\Users\Vladislav\AppData\Local\Programs\Microsoft VS Code\Code.exe")
d:: switch_to("ahk_exe blender.exe", newest_blender())
b:: switch_to("ahk_exe blender.exe", "X:\software\Blender\stable\blender-3.2.2+stable.bcfdb14560e7\blender.exe")
x:: switch_to("NukeX ahk_exe Nuke13.2.exe", "C:\Program Files\Nuke13.2v2\Nuke13.2.exe --nc --nukex")  ; TODO newest nuke
p:: switch_to("ahk_exe cmd.exe", "C:\Windows\System32\cmd.exe")

#HotIf l1() and bbp_pc()  ; FIXME
t:: switch_to("ahk_exe chrome.exe", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
s:: switch_to("ahk_exe Spotify.exe", "C:\Users\Aeraglyx\AppData\Local\Microsoft\WindowsApps\Spotify.exe")
c:: switch_to("ahk_exe Code.exe", "C:\Users\Aeraglyx\AppData\Local\Programs\Microsoft VS Code\Code.exe")
b:: switch_to("ahk_exe blender.exe", "C:\Blender\stable\blender-3.4.0+stable.a95bf1ac01be\blender.exe")
p:: switch_to("ahk_exe cmd.exe", "C:\Windows\System32\cmd.exe")

; #HotIf home_pc()
; ^!+f:: switch_to("ahk_exe explorer.exe", "C:\Windows\explorer.exe")  ; FIXME
; ^!+t:: switch_to("ahk_exe chrome.exe", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
; ^!+s:: switch_to("ahk_exe Spotify.exe", "C:\Users\Aeraglyx\AppData\Local\Microsoft\WindowsApps\Spotify.exe")
; ^!+c:: switch_to("ahk_exe Code.exe", "C:\Users\Aeraglyx\AppData\Local\Programs\Microsoft VS Code\Code.exe")
; ^!+b:: switch_to("ahk_exe blender.exe", "C:\Users\Aeraglyx\Desktop\blender\stable\blender-3.4.1+stable.55485cb379f7\blender.exe")
; ^!+p:: switch_to("ahk_exe cmd.exe", "C:\Windows\System32\cmd.exe")

#HotIf



Volume_Down::
Volume_Up:: {
	volume := SoundGetVolume()
	a := 2.0
	b := 0.06
	if A_ThisHotkey = "Volume_Down" {
		volume := (volume - a) / (1.0 + b)
		volume := max(volume, 0.0)
	} else {
		volume += a + volume * b
		volume := min(volume, 100.0)
	}
	SoundSetVolume volume
	CoordMode "ToolTip", "Screen"
	if WinExist("muhahahaha") {
		WinClose("muhahahaha")
	}
	MyGui := Gui(, "muhahahaha")
	MyGui.Opt("+Owner +AlwaysOnTop -Caption +LastFound +e0x00000020")
	MyGui.BackColor := "161616"
	WinSetTransparent 255
	MyGui.SetFont("s24 w700", "Fira Code")
	MyGui.Add("Text", "c888888", round(volume / 100, 2))
	active_id := WinGetID("A")
	MyGui.Show("Center")
	WinActivate active_id
	destroy_gui() {
		MyGui.Destroy()
	}
	SetTimer destroy_gui, -1000
}

title_last := ""
~Media_Play_Pause::
~Media_Prev::
~Media_Next:: {
	; if SubStr(ThisHotkey, 2) = "Media_Play_Pause" {
	; 	Sleep 512
	; 	Send "{Media_Play_Pause}"
	; 	Sleep 512
	; 	Send "{Media_Play_Pause}"
	; }
	Sleep 256
	title := WinGetTitle("ahk_exe Spotify.exe")
	if title != "Spotify Premium" {
		global title_last := title
	}
	if title_last = "" {
		return
	}
	word_array := StrSplit(title_last, " - ")
	if WinExist("muhahahaha") {
		WinClose("muhahahaha")
	}
	MyGui := Gui(, "muhahahaha")
	MyGui.Opt("+Owner +AlwaysOnTop -Caption +LastFound +e0x00000020")
	MyGui.BackColor := "161616"
	WinSetTransparent 255
	MyGui.SetFont("s24 w700", "Fira Code")
	MyGui.Add("Text", "c888888", word_array[2])
	MyGui.SetFont("s16 w700", "Fira Code")
	MyGui.Add("Text", "c555555 y+0", word_array[1])
	active_id := WinGetID("A")
	MyGui.Show("Center")
	WinActivate active_id
	destroy_gui() {
		MyGui.Destroy()
	}
	SetTimer destroy_gui, -2000
}




^!WheelUp:: Send "^{Home}"
^!WheelDown:: Send "^{End}"


; x_orig_whaat := 0
; y_orig_whaat := 0
; x_new_whaat := 0
; y_new_whaat := 0

; CoordMode "Mouse", "Screen"
; SetTitleMatchMode 1

; +XButton1:: {
; 	MouseGetPos	&x_orig_whaat, &y_orig_whaat
; }

; +XButton1 Up:: {
; 	MouseGetPos &x_new_whaat, &y_new_whaat
; 	x_diff_whaat := x_new_whaat - x_orig_whaat
; 	y_diff_whaat := y_new_whaat - y_orig_whaat
; 	BlockInput "On"
; 	MouseMove x_orig_whaat, y_orig_whaat
; 	BlockInput "Off"
; 	if (max(abs(x_diff_whaat), abs(y_diff_whaat)) > 64) {
; 		if (abs(x_diff_whaat) > abs(y_diff_whaat)) {
; 			; horizontal
; 			if (x_diff_whaat < 0) {
; 				; left
; 				RunWait "X:\projects"
; 				WinActivate "projects"
; 				; MsgBox, left
; 			} else {
; 				; right
; 				; chrome_new_tab()
; 			}
; 		} else {
; 			;vertical
; 			if (y_diff_whaat < 0) {
; 				; up
; 				RunWait "X:\UTB"
; 				WinActivate "UTB"
; 			} else {
; 				; down
; 				RunWait "X:\assets"
; 				WinActivate "assets"
; 			}
; 		}
; 	}
; }




#HotIf l1()

r:: Reload
q:: WinClose "A"
; t:: Send "^#{a}"

; c:: toggle("support_scripts\color_picker.ahk")
; m:: toggle("support_scripts\measure.ahk")

; s:: Run "support_scripts\spotify_search.ahk"

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



#HotIf l1()

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

#HotIf


; BLENDER
; Copy over addons and restart Blender
^!+a::
XButton1 & F5:: {

	; MsgBox(A_ComputerName)
	
	switch A_ComputerName {
		case "FULCRUM":
			git := "X:\git"
			versions := [3.4, 3.5]
			addons := ["fulcrum"]
		case "BEN":
			git := "C:\Users\Aeraglyx\Desktop\git"
			versions := [3.4, 3.5]
			addons := ["fulcrum"]
		case "BBP-P-N03":
			git := "C:\Users\Aeraglyx\Desktop\git"
			versions := [3.4]
			addons := ["fulcrum"]
		case "BBP-N3":
			git := "C:\Users\user\Desktop\aeraglyx\git"
			versions := [3.4, 3.5]
			addons := ["fulcrum", "bbproducer"]
	}
	
	; ProcessClose "blender.exe"  ; XXX kinda dangerous > ask user? And close all instances?
	for version in versions {
		for addon in addons {
			src := git . "\" . addon
			dst := A_AppData . "\Blender Foundation\Blender\" . round(version, 1) . "\scripts\addons\" . addon
			if DirExist(dst) {
				DirDelete dst, 1
			}
			DirCopy src, dst, 1
		}
	}

	TrayTip("Addon updater", "Done.")

	switch A_ComputerName {
		case "FULCRUM": 	run newest_blender()
		case "BEN": 		run "C:\Users\Aeraglyx\Desktop\blender\stable\blender-3.4.1+stable.55485cb379f7\blender.exe"
		; case "BBP-P-N03": 	run "C:\Blender\stable\blender-3.3.1+lts.b292cfe5a936\blender.exe"
		; case "BBP-N3": 		run "C:\Blender\stable\blender-3.4.1+stable.55485cb379f7\blender.exe"
	}
}



; :*:fdfd::D.materials['Material'].node_tree.nodes.active.
; ; x:: Send, ^{/}

; #IfWinActive



#HotIf l2()

p:: {
	; Run "support_files\new_project.py"
	; TODO
	MyGui := Gui()
	; MyGui.Opt("+Owner +AlwaysOnTop -Caption +LastFound")
	; MyGui.SetFont("s24 w700", "Fira Code")
	MyGui.Add("Edit", "r1 vname w236", "")
	MyGui.Add("CheckBox", "v2d Checked", "2D")
	MyGui.Add("CheckBox", "v3d Checked", "3D")
	MyBtn := MyGui.Add("Button", "Default w236", "OK")
	; MyBtn_Click(MyGui){
	; 	MyGui.Destroy()
	; }
	; MyBtn.OnEvent("Click", MyBtn_Click(MyGui))
	MyGui.Show("Center w256")
}

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
:*o:+-::{U+00B1}		; ±
:*o:?alpha::{U+03B1}	; α

:*o:leftar::{U+2190}	; ←
:*o:rightar::{U+2192}	; →
:*o:upar::{U+2191}		; ↑
:*o:downar::{U+2193}	; ↓

:*o:?epsilon::{U+03B5}	; ε
; LATEX
:o:ltx::/latex{Down}{Enter} ; get LaTeX on Notion
:o:frac::\frac{{}{}}{{}{}}{Left 3}
:ro:fn::f(x)=
:ro:finv::f^{-1}(x)=

; SOFTWARE HELP
::?bpy::Blender Python
::?ae::After Effects
::?fus::Blackmagic Fusion
::?res::DaVinci Resolve
::?vsc::Visual Studio Code
::?win::Windows 11






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

; FUSION
#HotIf WinActive("ahk_exe Fusion.exe")
^d:: Send "^p"



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
XButton1 & c::
XButton1 & x:: Send "^{/}"

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
	; if RegExMatch(selected(), "\w"){
	; 	Send("{End}{Space 2}")
	; }
	SetTitleMatchMode 2
	title := WinGetTitle("A")
	dict := map("ahk", "{;}", "ahk", "{;}", "jsx", "//", "dctl", "//", "py", "{#}")
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