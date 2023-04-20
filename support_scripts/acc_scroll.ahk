#SingleInstance Force
Persistent
#NoTrayIcon

^!+x::ExitApp

speed_max := 14  ; max scroll speed at the threshold
response := 32  ; spread, higher -> bigger effect
smooth := 0.2  ; [0-1] higher -> smoother but more sluggish
threshold := 16  ; [ms] scroll speed at which speed_max is set

global last_down := A_TickCount - 1000
global last_up := last_down

global last_diff_down := 1000
global last_diff_up := 1000

lines(x, threshold, speed_max, response) {
	out := round((speed_max - 1) * exp((threshold - x) / response)) + 1
	return out
}

WheelDown:: {
	diff_now := A_TickCount - last_down
	diff := smooth * last_diff_down + (1 - smooth) * diff_now
	n := lines(diff, threshold, speed_max, response)
	Click "WheelDown", n
	; last_diff_down could be set to either diff or diff_now
	; diff -> longer smoothing, diff_now -> just for fixing glitching
	; could do both but that seems overkill
	global last_diff_down := diff
	global last_down := A_TickCount
}

WheelUp:: {
	diff_now := A_TickCount - last_up
	diff := smooth * last_diff_up + (1 - smooth) * diff_now
	n := lines(diff, threshold, speed_max, response)
	Click "WheelUp", n
	global last_diff_up := diff
	global last_up := A_TickCount
}