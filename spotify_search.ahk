XButton1 & s::
	
	title := "ahk_exe Spotify.exe"

	WinGet, prev_pid, PID, A
	InputBox, to_play, Spotify Search, What to play on Spotify,, 256, 128

	if GetKeyState("LCtrl" , "P") {
		play_now := False
	} else {
		play_now := True
	}

	if !WinExist(title){
		Run, C:\Users\Vladislav\AppData\Local\Microsoft\WindowsApps\Spotify.exe
		WinWait, %title%
		Sleep, 1000
	}
	; Winset, AlwaysOnTop, Toggle, "Spotify Search"
	
	; TODO if Spotify was active, keep it at front...

	DetectHiddenWindows, On
	;SetTitleMatchMode 2 
	if (ErrorLevel = 0) {
		
		CoordMode, Mouse, Screen
		BlockInput, On
		MouseGetPos, orig_x, orig_y
		WinGet, win_state, MinMax, %title%
		
		WinMaximize, %title%
		WinRestore, %title%

		WinActivate, %title%
		WinWaitActive, %title%

		WinGetPos, x, y, w, h
		WinMove, %title%,, A_ScreenWidth/2 - 512, A_ScreenHeight/2 - 512, 1024, 1024
		
		CoordMode, Mouse, Client
		MouseClick, Left, 33, 105, 1
		MouseClick, Left, 625, 30, 3
		Send, %to_play%
		
		; Run, Spotify:search:%to_play%

		if play_now {
			
			Sleep, 1000 ; timing
			MouseClick, Left, 700, 300, 1			
			; ; Send, {ShiftDown}{Left 20}{ShiftUp}
		}

		CoordMode, Mouse, Screen
		WinMove, %title%,, x, y, w, h

		if play_now {
			if (win_state = -1) {
				WinMinimize, %title%
			}
			if (win_state = 1) {
				WinMaximize, %title%
			}
			WinActivate, ahk_pid %prev_pid%
		}

		MouseMove, %orig_x%, %orig_y%
		BlockInput, Off
	}
	Return